import 'package:equatable/equatable.dart';

abstract class SignupScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupLoadingStartedEvent extends SignupScreenEvent {}

class SignupLoadingStoppedEvent extends SignupScreenEvent {}

class SignupPasswordEvent extends SignupScreenEvent {}

class SignupUserEvent extends SignupScreenEvent {
  final String? userName;
  final String? userEmail;
  final String? userPassword;
  final String? userMobileNumber;

  SignupUserEvent({
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userMobileNumber,
  });

  @override
  List<Object?> get props =>
      [userName, userEmail, userPassword, userMobileNumber];
}
