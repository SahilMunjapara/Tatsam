abstract class OtpScreenState {}

class OtpInitialState extends OtpScreenState {}

class TimerStartState extends OtpScreenState {}

class TimerStartedState extends OtpScreenState {}

class TimerStoppedState extends OtpScreenState {}

class TimerTickedState extends OtpScreenState {
  String timeDetails;
  TimerTickedState(this.timeDetails);
}
