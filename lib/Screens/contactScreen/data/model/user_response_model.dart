import 'dart:convert';

List<UserResponseModel> userResponseModelFromJson(String str) =>
    List<UserResponseModel>.from(
        json.decode(str).map((x) => UserResponseModel.fromJson(x)));

String userResponseModelToJson(List<UserResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponseModel {
  UserResponseModel({
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

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
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
