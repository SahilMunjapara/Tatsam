import 'package:equatable/equatable.dart';

abstract class OtpScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimerStartEvent extends OtpScreenEvent {}

class TimerStartedEvent extends OtpScreenEvent {}

class TimerStoppedEvent extends OtpScreenEvent {}

class TimerTickedEvent extends OtpScreenEvent {
  final String? time;

  TimerTickedEvent({this.time});

  @override
  List<Object?> get props => [time];
}
