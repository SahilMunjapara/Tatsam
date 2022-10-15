import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/data/repository/utilities_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class UtilitiesBloc extends Bloc<UtilitiesScreenEvent, UtilitiesScreenState> {
  UtilitiesBloc() : super(UtilitiesInitialState());

  final UtilitiesRepository _utilitiesRepository = UtilitiesRepository();

  @override
  Stream<UtilitiesScreenState> mapEventToState(
      UtilitiesScreenEvent event) async* {
    if (event is UtilitiesSearchEvent) {
      yield UtilitiesSearchState();
    }

    if (event is UtilitiesListEvent) {
      yield UtilitiesLoadingStartState();
      Resource resource = await _utilitiesRepository.getUtilitiesList(event);
      if (resource.data != null) {
        yield UtilitiesListState(resource.data);
      } else {
        yield UtilitiesErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield UtilitiesLoadingEndState();
    }
  }
}
