import 'package:equatable/equatable.dart';

abstract class BusinessScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusinessSearchEvent extends BusinessScreenEvent {}
