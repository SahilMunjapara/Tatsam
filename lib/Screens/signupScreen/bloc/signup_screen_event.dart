import 'package:equatable/equatable.dart';

abstract class SignupScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupLoadingStartedEvent extends SignupScreenEvent {}

class SignupLoadingStoppedEvent extends SignupScreenEvent {}
