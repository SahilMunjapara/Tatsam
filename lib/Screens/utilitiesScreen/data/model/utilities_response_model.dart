import 'dart:convert';

UtilitiesResponseModel utilitiesResponseModelFromJson(String str) =>
    UtilitiesResponseModel.fromJson(json.decode(str));

String utilitiesResponseModelToJson(UtilitiesResponseModel data) =>
    json.encode(data.toJson());

class UtilitiesResponseModel {
  UtilitiesResponseModel({
    this.status,
    this.message,
    this.utilitiesData,
  });

  String? status;
  String? message;
  List<UtilitiesData>? utilitiesData;

  factory UtilitiesResponseModel.fromJson(Map<String, dynamic> json) =>
      UtilitiesResponseModel(
        status: json["status"],
        message: json["message"],
        utilitiesData: List<UtilitiesData>.from(
            json["data"].map((x) => UtilitiesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(utilitiesData!.map((x) => x.toJson())),
      };
}

class UtilitiesData {
  UtilitiesData({
    this.id,
    this.name,
    this.phoneNo,
    this.imagePath,
    this.groupId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? phoneNo;
  String? imagePath;
  int? groupId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UtilitiesData.fromJson(Map<String, dynamic> json) => UtilitiesData(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phone_no"],
        imagePath: json["image_path"],
        groupId: json["groupId"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_no": phoneNo,
        "image_path": imagePath,
        "groupId": groupId,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
