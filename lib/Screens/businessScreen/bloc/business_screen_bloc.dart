import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/businessScreen/data/repository/business_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class BusinessBloc extends Bloc<BusinessScreenEvent, BusinessScreenState> {
  BusinessBloc() : super(BusinessInitialState());

  final BusinessRepository _businessRepository = BusinessRepository();

  @override
  Stream<BusinessScreenState> mapEventToState(
      BusinessScreenEvent event) async* {
    if (event is BusinessSearchEvent) {
      yield BusinessSearchState();
    }

    if (event is GetBusinessEvent) {
      yield BusinessLoadingStartState();
      Resource resource = await _businessRepository.getBusiness(event);
      if (resource.data != null) {
        yield GetBusinessState(resource.data);
      } else {
        yield BusinessErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield BusinessLoadingEndState();
    }
  }
}
