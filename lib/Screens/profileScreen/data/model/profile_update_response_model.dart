import 'dart:convert';

ProfileUpdateResponseModel profileUpdateResponseModelFromJson(String str) =>
    ProfileUpdateResponseModel.fromJson(json.decode(str));

String profileUpdateResponseModelToJson(ProfileUpdateResponseModel data) =>
    json.encode(data.toJson());

class ProfileUpdateResponseModel {
  ProfileUpdateResponseModel({
    this.status,
    this.message,
    this.profileData,
  });

  String? status;
  String? message;
  ProfileData? profileData;

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponseModel(
        status: json["status"],
        message: json["message"],
        profileData: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": profileData!.toJson(),
      };
}

class ProfileData {
  ProfileData();

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData();

  Map<String, dynamic> toJson() => {};
}
