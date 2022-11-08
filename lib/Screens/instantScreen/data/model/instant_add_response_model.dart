import 'dart:convert';

InstantAddResponseModel instantAddResponseModelFromJson(String str) =>
    InstantAddResponseModel.fromJson(json.decode(str));

String instantAddResponseModelToJson(InstantAddResponseModel data) =>
    json.encode(data.toJson());

class InstantAddResponseModel {
  InstantAddResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<dynamic>? data;

  factory InstantAddResponseModel.fromJson(Map<String, dynamic> json) =>
      InstantAddResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}
