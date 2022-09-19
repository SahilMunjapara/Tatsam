import 'dart:convert';

FetchUserResponseModel fetchUserResponseModelFromJson(String str) =>
    FetchUserResponseModel.fromJson(json.decode(str));

String fetchUserResponseModelToJson(FetchUserResponseModel data) =>
    json.encode(data.toJson());

class FetchUserResponseModel {
  FetchUserResponseModel({
    this.status,
    this.message,
    this.userData,
  });

  int? status;
  String? message;
  List<UserData>? userData;

  factory FetchUserResponseModel.fromJson(Map<String, dynamic> json) =>
      FetchUserResponseModel(
        status: json["status"],
        message: json["message"],
        userData:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(userData!.map((x) => x.toJson())),
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.imagePath,
  });

  int? id;
  String? name;
  String? email;
  String? password;
  String? phoneNo;
  String? imagePath;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        imagePath: json["image_path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "image_path": imagePath,
      };
}
