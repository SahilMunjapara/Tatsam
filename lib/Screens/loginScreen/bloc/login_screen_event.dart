import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoadingBeginEvent extends LoginScreenEvent {}

class LoginLoadingEndEvent extends LoginScreenEvent {}

class LoginPasswordEvent extends LoginScreenEvent {}

class LoginUserEvent extends LoginScreenEvent {
  final String? userEmail;
  final String? userPassword;
  final String? deviceToken;

  LoginUserEvent({this.userEmail, this.userPassword, this.deviceToken});

  @override
  List<Object?> get props => [userEmail, userPassword, deviceToken];
}

class LoginUserFetchEvent extends LoginScreenEvent {
  final String? userId;

  LoginUserFetchEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class PhoneCheckEvent extends LoginScreenEvent {
  final String? phoneNumber;

  PhoneCheckEvent({this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class LoginUserDetailEvent extends LoginScreenEvent {
  final String? phoneNumber;

  LoginUserDetailEvent({this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
