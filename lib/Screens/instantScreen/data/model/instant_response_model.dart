import 'dart:convert';

InstantResponseModel instantResponseModelFromJson(String str) =>
    InstantResponseModel.fromJson(json.decode(str));

String instantResponseModelToJson(InstantResponseModel data) =>
    json.encode(data.toJson());

class InstantResponseModel {
  InstantResponseModel({
    this.status,
    this.message,
    this.instantData,
  });

  String? status;
  String? message;
  List<InstantData>? instantData;

  factory InstantResponseModel.fromJson(Map<String, dynamic> json) =>
      InstantResponseModel(
        status: json["status"],
        message: json["message"],
        instantData: List<InstantData>.from(
            json["data"].map((x) => InstantData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(instantData!.map((x) => x.toJson())),
      };
}

class InstantData {
  InstantData({
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
    this.instantId,
  });

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
  InstantId? instantId;

  factory InstantData.fromJson(Map<String, dynamic> json) => InstantData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        imagePath: json["image_path"] ?? '',
        groupId: json["groupId"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        instantId: InstantId.fromJson(json["instantId"]),
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
        "instantId": instantId!.toJson(),
      };
}

class InstantId {
  InstantId({
    this.id,
    this.userId,
    this.instantUserId,
    this.groupId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? instantUserId;
  int? groupId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InstantId.fromJson(Map<String, dynamic> json) => InstantId(
        id: json["id"],
        userId: json["userId"],
        instantUserId: json["instantUserId"],
        groupId: json["groupId"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "instantUserId": instantUserId,
        "groupId": groupId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
