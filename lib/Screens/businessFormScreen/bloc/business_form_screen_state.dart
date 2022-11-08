import 'dart:io';

import 'package:tatsam/Screens/businessFormScreen/data/model/business_add_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class BusinessFormScreenState {}

class BusinessFormInitialState extends BusinessFormScreenState {}

class BusinessFormLoadingStartState extends BusinessFormScreenState {}

class BusinessFormLoadingEndState extends BusinessFormScreenState {}

class BusinessTypeSelectState extends BusinessFormScreenState {
  String businessType;
  BusinessTypeSelectState(this.businessType);
}

class BusinessImageFetchState extends BusinessFormScreenState {
  File pickedImage;
  BusinessImageFetchState(this.pickedImage);
}

class AddNewBusinessState extends BusinessFormScreenState {
  BusinessAddResponseModel responseModel;
  AddNewBusinessState(this.responseModel);
}

class BusinessFormErrorState extends BusinessFormScreenState {
  AppException exception;
  BusinessFormErrorState(this.exception);
}
