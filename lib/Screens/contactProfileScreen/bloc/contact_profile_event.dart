import 'package:equatable/equatable.dart';

abstract class ContactProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContactProfileEvent extends ContactProfileEvent {
  final String? userId;

  GetContactProfileEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}
