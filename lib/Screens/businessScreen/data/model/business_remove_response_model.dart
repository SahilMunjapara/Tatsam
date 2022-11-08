import 'dart:convert';

BusinessRemoveResponseModel businessRemoveResponseModelFromJson(String str) =>
    BusinessRemoveResponseModel.fromJson(json.decode(str));

String businessRemoveResponseModelToJson(BusinessRemoveResponseModel data) =>
    json.encode(data.toJson());

class BusinessRemoveResponseModel {
  BusinessRemoveResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory BusinessRemoveResponseModel.fromJson(Map<String, dynamic> json) =>
      BusinessRemoveResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
