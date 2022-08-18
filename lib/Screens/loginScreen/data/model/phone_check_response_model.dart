import 'dart:convert';

PhoneCheckResponseModel phoneCheckResponseModelFromJson(String str) =>
    PhoneCheckResponseModel.fromJson(json.decode(str));

String phoneCheckResponseModelToJson(PhoneCheckResponseModel data) =>
    json.encode(data.toJson());

class PhoneCheckResponseModel {
  PhoneCheckResponseModel({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory PhoneCheckResponseModel.fromJson(Map<String, dynamic> json) =>
      PhoneCheckResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
