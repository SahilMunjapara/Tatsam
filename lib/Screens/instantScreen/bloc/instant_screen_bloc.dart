import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/instantScreen/data/repository/instant_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class InstantBloc extends Bloc<InstantScreenEvent, InstantScreenState> {
  InstantBloc() : super(InstantInitialState());
  final InstantRepository _instantRepository = InstantRepository();

  @override
  Stream<InstantScreenState> mapEventToState(InstantScreenEvent event) async* {
    if (event is InstantSearchEvent) {
      yield InstantSelectSearchState(false);
      yield InstantSearchState(event.isSearching!);
    }

    if (event is InstantSelectSearchEvent) {
      yield InstantSearchState(false);
      yield InstantSelectSearchState(event.isSelectSearching!);
    }

    if (event is GetInstantEvent) {
      yield InstantLoadingStartState();
      Resource resource = await _instantRepository.getInstantList(event);
      if (resource.data != null) {
        yield GetInstantState(resource.data);
      } else {
        yield InstantErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield InstantLoadingEndState();
    }
  }
}
