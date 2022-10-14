import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class ContactProfileState {}

class ContactProfileInitialState extends ContactProfileState {}

class ContactProfileLoadingStartState extends ContactProfileState {}

class ContactProfileLoadingEndState extends ContactProfileState {}

class GetContactProfileState extends ContactProfileState {
  LoginUserFetchResponseModel responseModel;
  GetContactProfileState(this.responseModel);
}

class ContactProfileErrorState extends ContactProfileState {
  AppException exception;
  ContactProfileErrorState(this.exception);
}
