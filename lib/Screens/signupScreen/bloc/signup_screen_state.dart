import 'package:tatsam/Screens/signupScreen/data/model/signup_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class SignupScreenState {}

class SignupInitialState extends SignupScreenState {}

class SignupLoadingStartedState extends SignupScreenState {
  bool loaded;
  SignupLoadingStartedState(this.loaded);
}

class SignupLoadingStoppedState extends SignupScreenState {
  bool loaded;
  SignupLoadingStoppedState(this.loaded);
}

class SignupUserState extends SignupScreenState {
  SignupResponseModel responseModel;

  SignupUserState(this.responseModel);
}

class SignupErrorState extends SignupScreenState {
  AppException exception;
  SignupErrorState(this.exception);
}
