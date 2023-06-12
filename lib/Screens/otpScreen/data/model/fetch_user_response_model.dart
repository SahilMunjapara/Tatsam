// To parse this JSON data, do
//
//     final fetchUserResponseModel = fetchUserResponseModelFromJson(jsonString);

import 'dart:convert';

FetchUserResponseModel fetchUserResponseModelFromJson(String str) =>
    FetchUserResponseModel.fromJson(json.decode(str));

String fetchUserResponseModelToJson(FetchUserResponseModel data) =>
    json.encode(data.toJson());

class FetchUserResponseModel {
  String? status;
  String? message;
  Userdata? userdata;

  FetchUserResponseModel({
    this.status,
    this.message,
    this.userdata,
  });

  factory FetchUserResponseModel.fromJson(Map<String, dynamic> json) =>
      FetchUserResponseModel(
        status: json["status"],
        message: json["message"],
        userdata: Userdata.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": userdata!.toJson(),
      };
}

class Userdata {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phoneNo;
  String? imagePath;
  int? groupId;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Userdata({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.imagePath,
    this.groupId,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        imagePath: json["image_path"],
        groupId: json["groupId"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "image_path": imagePath,
        "groupId": groupId,
        "type": type,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
