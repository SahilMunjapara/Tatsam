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
