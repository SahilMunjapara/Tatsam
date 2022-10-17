import 'dart:convert';

BusinessResponseModel businessResponseModelFromJson(String str) =>
    BusinessResponseModel.fromJson(json.decode(str));

String businessResponseModelToJson(BusinessResponseModel data) =>
    json.encode(data.toJson());

class BusinessResponseModel {
  BusinessResponseModel({
    this.status,
    this.message,
    this.businessData,
  });

  String? status;
  String? message;
  List<BusinessData>? businessData;

  factory BusinessResponseModel.fromJson(Map<String, dynamic> json) =>
      BusinessResponseModel(
        status: json["status"],
        message: json["message"],
        businessData: List<BusinessData>.from(
            json["data"].map((x) => BusinessData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(businessData!.map((x) => x.toJson())),
      };
}

class BusinessData {
  BusinessData({
    this.id,
    this.groupId,
    this.businessName,
    this.businessAddress,
    this.businessPhoneNo,
    this.businessImagePath,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.businessType,
  });

  int? id;
  int? groupId;
  String? businessName;
  String? businessAddress;
  String? businessPhoneNo;
  String? businessImagePath;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  BusinessType? businessType;

  factory BusinessData.fromJson(Map<String, dynamic> json) => BusinessData(
        id: json["id"],
        groupId: json["groupId"],
        businessName: json["business_name"],
        businessAddress: json["business_address"],
        businessPhoneNo: json["business_phone_no"],
        businessImagePath: json["business_image_path"] ?? '',
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        businessType: BusinessType.fromJson(json["businessType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "business_name": businessName,
        "business_address": businessAddress,
        "business_phone_no": businessPhoneNo,
        "business_image_path": businessImagePath,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
        "businessType": businessType!.toJson(),
      };
}

class BusinessType {
  BusinessType({
    this.typeName,
    this.imagePath,
  });

  String? typeName;
  String? imagePath;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
        typeName: json["type_name"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "type_name": typeName,
        "image_path": imagePath,
      };
}

class User {
  User({
    this.name,
    this.email,
    this.phoneNo,
  });

  String? name;
  String? email;
  String? phoneNo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_no": phoneNo,
      };
}
