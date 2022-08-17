import 'package:equatable/equatable.dart';

abstract class OtpScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingStartedEvent extends OtpScreenEvent {}

class LoadingStoppedEvent extends OtpScreenEvent {}

class TimerStartEvent extends OtpScreenEvent {}

class TimerStartedEvent extends OtpScreenEvent {}

class TimerStoppedEvent extends OtpScreenEvent {}

class TimerTickedEvent extends OtpScreenEvent {
  final String? time;

  TimerTickedEvent({this.time});

  @override
  List<Object?> get props => [time];
}
