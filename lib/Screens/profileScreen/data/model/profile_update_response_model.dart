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

  int? status;
  String? message;
  List<ProfileData>? profileData;

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponseModel(
        status: json["status"],
        message: json["message"],
        profileData: List<ProfileData>.from(
            json["data"].map((x) => ProfileData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(profileData!.map((x) => x.toJson())),
      };
}

class ProfileData {
  ProfileData();

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData();

  Map<String, dynamic> toJson() => {};
}
