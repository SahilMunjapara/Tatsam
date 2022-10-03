import 'package:equatable/equatable.dart';

abstract class InstantScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InstantSearchEvent extends InstantScreenEvent {}
