import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessFormEditScreen/bloc/business_form_edit_screen_event.dart';
import 'package:tatsam/Screens/businessFormEditScreen/bloc/business_form_edit_screen_state.dart';
import 'package:tatsam/Screens/businessFormEditScreen/data/repository/business_form_edit_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class BusinessFormEditBloc
    extends Bloc<BusinessFormEditScreenEvent, BusinessFormEditScreenState> {
  BusinessFormEditBloc() : super(BusinessFormEditInitialState());

  final BusinessFormEditRepository _businessFormEditRepository =
      BusinessFormEditRepository();

  @override
  Stream<BusinessFormEditScreenState> mapEventToState(
      BusinessFormEditScreenEvent event) async* {
    if (event is BusinessTypeChangeEvent) {
      yield BusinessTypeChangeState(event.businessType!);
    }
    if (event is BusinessImageChangeEvent) {
      yield BusinessImageChangeState(event.pickedImage!);
    }
    if (event is UpdateBusinessEvent) {
      yield BusinessFormEditLoadingStartState();
      Resource resource =
          await _businessFormEditRepository.updateBusiness(event);
      if (resource.data != null) {
        yield UpdateBusinessState(resource.data);
      } else {
        yield BusinessFormEditErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield BusinessFormEditLoadingEndState();
    }
  }
}
