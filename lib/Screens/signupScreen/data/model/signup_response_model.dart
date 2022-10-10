import 'dart:convert';

SignupResponseModel signUpResponseModelFromJson(String str) =>
    SignupResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignupResponseModel data) =>
    json.encode(data.toJson());

class SignupResponseModel {
  SignupResponseModel({
    this.status,
    this.message,
    this.signupData,
  });

  String? status;
  String? message;
  List<SignupData>? signupData;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        status: json["status"],
        message: json["message"],
        signupData: List<SignupData>.from(
            json["data"].map((x) => SignupData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(signupData!.map((x) => x.toJson())),
      };
}

class SignupData {
  SignupData({
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.groupId,
    this.imagePath,
    this.id,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  String? email;
  String? password;
  String? phoneNo;
  int? groupId;
  dynamic imagePath;
  int? id;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        groupId: json["groupId"],
        imagePath: json["image_path"],
        id: json["id"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "groupId": groupId,
        "image_path": imagePath,
        "id": id,
        "type": type,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
