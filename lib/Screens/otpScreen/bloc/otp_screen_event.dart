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

class BackButtonEvent extends OtpScreenEvent {}

class TimerTickedEvent extends OtpScreenEvent {
  final String? time;

  TimerTickedEvent({this.time});

  @override
  List<Object?> get props => [time];
}

class FetchUserEvent extends OtpScreenEvent {
  final String? userPhone;

  FetchUserEvent({this.userPhone});

  @override
  List<Object?> get props => [userPhone];
}

class UserDataFetchEvent extends OtpScreenEvent {
  final String? userId;

  UserDataFetchEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class SignUpEvent extends OtpScreenEvent {
  final String? userName;
  final String? userEmail;
  final String? userPassword;
  final String? userMobileNumber;

  SignUpEvent({
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userMobileNumber,
  });

  @override
  List<Object?> get props =>
      [userName, userEmail, userPassword, userMobileNumber];
}
