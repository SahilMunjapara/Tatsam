import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoadingBeginEvent extends LoginScreenEvent {}

class LoginLoadingEndEvent extends LoginScreenEvent {}

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
