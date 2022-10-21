import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BusinessFormScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusinessTypeSelectEvent extends BusinessFormScreenEvent {
  final String? businessType;

  BusinessTypeSelectEvent({this.businessType});

  @override
  List<Object?> get props => [businessType];
}

class BusinessImageFetchEvent extends BusinessFormScreenEvent {
  final File? pickedImage;

  BusinessImageFetchEvent({this.pickedImage});

  @override
  List<Object?> get props => [pickedImage];
}
