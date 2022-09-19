import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';

abstract class ProfileScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingStartedEvent extends ProfileScreenEvent {}

class ProfileLoadingStoppedEvent extends ProfileScreenEvent {}

class ProfileImageFetchEvent extends ProfileScreenEvent {
  final File? pickedImage;

  ProfileImageFetchEvent({this.pickedImage});

  @override
  List<Object?> get props => [pickedImage];
}

class ProfileEditEvent extends ProfileScreenEvent {
  final bool? isProfileEdit;

  ProfileEditEvent({this.isProfileEdit});

  @override
  List<Object?> get props => [isProfileEdit];
}

class ProfileDetailFetchEvent extends ProfileScreenEvent {
  final String? userPhone;

  ProfileDetailFetchEvent({this.userPhone});

  @override
  List<Object?> get props => [userPhone];
}

class ProfileupdatedEvent extends ProfileScreenEvent {
  final String? userId;
  final String? userName;
  final String? userPhone;
  final String? userEmail;
  final File? userImage;

  ProfileupdatedEvent({
    this.userId,
    this.userName,
    this.userPhone,
    this.userEmail,
    this.userImage,
  });

  @override
  List<Object?> get props =>
      [userId, userName, userPhone, userEmail, userImage];
}
