import 'package:tatsam/Screens/loginScreen/data/model/login_response_model.dart';
import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/Screens/loginScreen/data/model/phone_check_response_model.dart';
import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class LoginScreenState {}

class LoginInitialState extends LoginScreenState {}

class LoginLoadingBeginState extends LoginScreenState {}

class LoginLoadingEndState extends LoginScreenState {}

class LoginPasswordState extends LoginScreenState {}

class LoginUserState extends LoginScreenState {
  LoginResponseModel responseModel;
  LoginUserState(this.responseModel);
}

class LoginUserFetchState extends LoginScreenState {
  LoginUserFetchResponseModel responseModel;
  LoginUserFetchState(this.responseModel);
}

class PhoneCheckState extends LoginScreenState {
  PhoneCheckResponseModel responseModel;
  PhoneCheckState(this.responseModel);
}

class LoginUserDetailState extends LoginScreenState {
  FetchUserResponseModel responseModel;
  LoginUserDetailState(this.responseModel);
}

class LoginErrorState extends LoginScreenState {
  AppException exception;
  LoginErrorState(this.exception);
}
