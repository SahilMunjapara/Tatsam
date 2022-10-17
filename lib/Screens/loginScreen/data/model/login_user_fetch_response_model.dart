import 'dart:convert';

LoginUserFetchResponseModel loginUserFetchResponseModelFromJson(String str) =>
    LoginUserFetchResponseModel.fromJson(json.decode(str));

String loginUserFetchResponseModelToJson(LoginUserFetchResponseModel data) =>
    json.encode(data.toJson());

class LoginUserFetchResponseModel {
  LoginUserFetchResponseModel({
    this.status,
    this.message,
    this.loginUserData,
  });

  String? status;
  String? message;
  LoginUserData? loginUserData;

  factory LoginUserFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginUserFetchResponseModel(
        status: json["status"],
        message: json["message"],
        loginUserData: LoginUserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": loginUserData!.toJson(),
      };
}

class LoginUserData {
  LoginUserData({
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

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
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
