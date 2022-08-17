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
