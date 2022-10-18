import 'package:equatable/equatable.dart';

abstract class ContactScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactLoadingStartEvent extends ContactScreenEvent {}

class ContactLoadingEndEvent extends ContactScreenEvent {}

class ContactSearchEvent extends ContactScreenEvent {}

class ContactListEvent extends ContactScreenEvent {}

class ContactWithCharSearchEvent extends ContactScreenEvent {
  final String? searchChar;

  ContactWithCharSearchEvent({this.searchChar});

  @override
  List<Object?> get props => [searchChar];
}
