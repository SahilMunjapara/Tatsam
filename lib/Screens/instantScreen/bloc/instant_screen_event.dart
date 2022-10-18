import 'package:equatable/equatable.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';

abstract class InstantScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InstantSearchEvent extends InstantScreenEvent {
  final bool? isSearching;

  InstantSearchEvent({this.isSearching});

  @override
  List<Object?> get props => [isSearching];
}

class InstantSelectSearchEvent extends InstantScreenEvent {
  final bool? isSelectSearching;

  InstantSelectSearchEvent({this.isSelectSearching});

  @override
  List<Object?> get props => [isSelectSearching];
}

class GetInstantEvent extends InstantScreenEvent {
  final String? userId;

  GetInstantEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetAllContactEvent extends InstantScreenEvent {}

class InstantSearchCharEvent extends InstantScreenEvent {
  final String? searchChar;

  InstantSearchCharEvent({this.searchChar});

  @override
  List<Object?> get props => [searchChar];
}

class InstantDeleteEvent extends InstantScreenEvent {
  final String? instantId;

  InstantDeleteEvent({this.instantId});

  @override
  List<Object?> get props => [instantId];
}

class SelectedInstantUserEvent extends InstantScreenEvent {
  final UserResponseModel userResponseModel;

  SelectedInstantUserEvent({required this.userResponseModel});

  @override
  List<Object?> get props => [userResponseModel];
}

class SelectedInstantRemoveEvent extends InstantScreenEvent {
  final UserResponseModel userResponseModel;

  SelectedInstantRemoveEvent({required this.userResponseModel});

  @override
  List<Object?> get props => [userResponseModel];
}
