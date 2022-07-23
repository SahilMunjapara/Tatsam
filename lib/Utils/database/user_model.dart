import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

class UserData {
  String? uid;
  String? userName;
  String? userEmail;
  String? userMobile;
  bool? isActive = true;

  UserData({
    this.uid,
    this.userName,
    this.userEmail,
    this.userMobile,
    this.isActive,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json['userUID'],
        userName: json['userName'],
        userEmail: json['userEmail'],
        userMobile: json['userMobile'],
        isActive: json['userIsActive'],
      );
}
