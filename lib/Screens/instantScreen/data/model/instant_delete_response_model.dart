import 'dart:convert';

InstantDeleteResponseModel instantDeleteResponseModelFromJson(String str) =>
    InstantDeleteResponseModel.fromJson(json.decode(str));

String instantDeleteResponseModelToJson(InstantDeleteResponseModel data) =>
    json.encode(data.toJson());

class InstantDeleteResponseModel {
  InstantDeleteResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<dynamic>? data;

  factory InstantDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      InstantDeleteResponseModel(
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
