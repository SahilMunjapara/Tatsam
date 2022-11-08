import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessFormScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/businessFormScreen/data/repository/business_form_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class BusinessFormBloc
    extends Bloc<BusinessFormScreenEvent, BusinessFormScreenState> {
  BusinessFormBloc() : super(BusinessFormInitialState());

  final BusinessFormRepository _businessFormRepository =
      BusinessFormRepository();

  @override
  Stream<BusinessFormScreenState> mapEventToState(
      BusinessFormScreenEvent event) async* {
    if (event is BusinessTypeSelectEvent) {
      yield BusinessTypeSelectState(event.businessType!);
    }
    if (event is BusinessImageFetchEvent) {
      yield BusinessImageFetchState(event.pickedImage!);
    }
    if (event is AddNewBusinessEvent) {
      yield BusinessFormLoadingStartState();
      Resource resource = await _businessFormRepository.addBusiness(event);
      if (resource.data != null) {
        yield AddNewBusinessState(resource.data);
      } else {
        yield BusinessFormErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield BusinessFormLoadingEndState();
    }
  }
}
