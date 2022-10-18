import 'package:equatable/equatable.dart';

abstract class BusinessScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusinessSearchEvent extends BusinessScreenEvent {}

class GetBusinessEvent extends BusinessScreenEvent {
  final String? groupId;

  GetBusinessEvent({this.groupId});

  @override
  List<Object?> get props => [groupId];
}

class BusinessSearchCharEvent extends BusinessScreenEvent {
  final String? searchChar;

  BusinessSearchCharEvent({this.searchChar});

  @override
  List<Object?> get props => [searchChar];
}
