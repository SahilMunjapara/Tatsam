import 'package:equatable/equatable.dart';

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
