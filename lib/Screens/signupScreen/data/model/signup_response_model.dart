import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) =>
    SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) =>
    json.encode(data.toJson());

class SignupResponseModel {
  SignupResponseModel({
    this.status,
    this.message,
    this.signupData,
  });

  String? status;
  String? message;
  SignupData? signupData;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        status: json["status"],
        message: json["message"],
        signupData: SignupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": signupData!.toJson(),
      };
}

class SignupData {
  SignupData({
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.groupId,
    this.deviceToken,
    this.imagePath,
    this.id,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  String? name;
  String? email;
  String? password;
  String? phoneNo;
  int? groupId;
  String? deviceToken;
  dynamic imagePath;
  int? id;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        groupId: json["groupId"],
        deviceToken: json["device_token"],
        imagePath: json["image_path"],
        id: json["id"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "groupId": groupId,
        "device_token": deviceToken,
        "image_path": imagePath,
        "id": id,
        "type": type,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "token": token,
      };
}
