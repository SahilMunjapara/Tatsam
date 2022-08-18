import 'package:equatable/equatable.dart';

abstract class ProfileScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingStartedEvent extends ProfileScreenEvent {}

class ProfileLoadingStoppedEvent extends ProfileScreenEvent {}

class ProfileEditEvent extends ProfileScreenEvent {
  final bool? isProfileEdit;

  ProfileEditEvent({this.isProfileEdit});

  @override
  List<Object?> get props => [isProfileEdit];
}

class ProfileupdatedEvent extends ProfileScreenEvent {
  final String? userId;
  final String? userName;
  final String? userPhone;
  final String? userEmail;

  ProfileupdatedEvent(
      {this.userId, this.userName, this.userPhone, this.userEmail});

  @override
  List<Object?> get props => [userId, userName, userPhone, userEmail];
}
