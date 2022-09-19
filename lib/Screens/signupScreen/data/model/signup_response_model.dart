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

  int? status;
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
    this.imagePath,
    this.id,
  });

  String? name;
  String? email;
  String? password;
  String? phoneNo;
  String? imagePath;
  int? id;

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        imagePath: json["image_path"] ?? '',
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "image_path": imagePath,
        "id": id,
      };
}
