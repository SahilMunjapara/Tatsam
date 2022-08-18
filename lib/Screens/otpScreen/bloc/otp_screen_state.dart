import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/Screens/signupScreen/data/model/signup_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class OtpScreenState {}

class OtpInitialState extends OtpScreenState {}

class LoadingStartedState extends OtpScreenState {
  bool loaded;
  LoadingStartedState(this.loaded);
}

class LoadingStoppedState extends OtpScreenState {
  bool loaded;
  LoadingStoppedState(this.loaded);
}

class TimerStartState extends OtpScreenState {}

class TimerStartedState extends OtpScreenState {}

class TimerStoppedState extends OtpScreenState {}

class TimerTickedState extends OtpScreenState {
  String timeDetails;
  TimerTickedState(this.timeDetails);
}

class FetchUserState extends OtpScreenState {
  FetchUserResponseModel responseModel;

  FetchUserState(this.responseModel);
}

class SignupState extends OtpScreenState {
  SignupResponseModel responseModel;

  SignupState(this.responseModel);
}

class OtpErrorState extends OtpScreenState {
  AppException exception;
  OtpErrorState(this.exception);
}
