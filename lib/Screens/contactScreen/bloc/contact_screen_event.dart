import 'package:equatable/equatable.dart';

abstract class ContactScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactSearchEvent extends ContactScreenEvent {}
