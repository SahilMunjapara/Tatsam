import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BusinessFormEditScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusinessTypeChangeEvent extends BusinessFormEditScreenEvent {
  final String? businessType;

  BusinessTypeChangeEvent({this.businessType});

  @override
  List<Object?> get props => [businessType];
}

class BusinessImageChangeEvent extends BusinessFormEditScreenEvent {
  final File? pickedImage;

  BusinessImageChangeEvent({this.pickedImage});

  @override
  List<Object?> get props => [pickedImage];
}

class UpdateBusinessEvent extends BusinessFormEditScreenEvent {
  final String? businessId;
  final String? businessName;
  final String? businessAddress;
  final String? businessPhoneNumber;
  final String? businessTypeId;
  final File? businessImage;

  UpdateBusinessEvent({
    this.businessId,
    this.businessName,
    this.businessAddress,
    this.businessPhoneNumber,
    this.businessTypeId,
    this.businessImage,
  });

  @override
  List<Object?> get props => [
        businessId,
        businessName,
        businessAddress,
        businessPhoneNumber,
        businessTypeId,
        businessImage
      ];
}
