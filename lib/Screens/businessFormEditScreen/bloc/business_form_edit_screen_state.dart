import 'dart:io';

import 'package:tatsam/Screens/businessFormEditScreen/data/model/business_update_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class BusinessFormEditScreenState {}

class BusinessFormEditInitialState extends BusinessFormEditScreenState {}

class BusinessFormEditLoadingStartState extends BusinessFormEditScreenState {}

class BusinessFormEditLoadingEndState extends BusinessFormEditScreenState {}

class BusinessTypeChangeState extends BusinessFormEditScreenState {
  String businessType;
  BusinessTypeChangeState(this.businessType);
}

class BusinessImageChangeState extends BusinessFormEditScreenState {
  File pickedImage;
  BusinessImageChangeState(this.pickedImage);
}

class UpdateBusinessState extends BusinessFormEditScreenState {
  BusinessUpdateResponseModel responseModel;
  UpdateBusinessState(this.responseModel);
}

class BusinessFormEditErrorState extends BusinessFormEditScreenState {
  AppException exception;
  BusinessFormEditErrorState(this.exception);
}
