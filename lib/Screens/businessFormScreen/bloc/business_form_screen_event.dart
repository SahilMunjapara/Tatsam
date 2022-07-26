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

class AddNewBusinessEvent extends BusinessFormScreenEvent {
  final String? businessName;
  final String? businessAddress;
  final String? businessPhoneNumber;
  final String? businessTypeId;
  final File? businessImage;

  AddNewBusinessEvent({
    this.businessName,
    this.businessAddress,
    this.businessPhoneNumber,
    this.businessTypeId,
    this.businessImage,
  });

  @override
  List<Object?> get props => [
        businessName,
        businessAddress,
        businessPhoneNumber,
        businessTypeId,
        businessImage
      ];
}
