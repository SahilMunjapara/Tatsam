import 'package:equatable/equatable.dart';

abstract class UtilitiesScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UtilitiesSearchEvent extends UtilitiesScreenEvent {}

class UtilitiesListEvent extends UtilitiesScreenEvent {
  final String? groupId;

  UtilitiesListEvent({this.groupId});

  @override
  List<Object?> get props => [groupId];
}

class UtilitiesSearchCharEvent extends UtilitiesScreenEvent {
  final String? searchChar;

  UtilitiesSearchCharEvent({this.searchChar});

  @override
  List<Object?> get props => [searchChar];
}
