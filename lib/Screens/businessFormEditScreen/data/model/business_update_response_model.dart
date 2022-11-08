import 'dart:convert';

BusinessUpdateResponseModel businessUpdateResponseModelFromJson(String str) =>
    BusinessUpdateResponseModel.fromJson(json.decode(str));

String businessUpdateResponseModelToJson(BusinessUpdateResponseModel data) =>
    json.encode(data.toJson());

class BusinessUpdateResponseModel {
  BusinessUpdateResponseModel({
    this.status,
    this.message,
    this.businessUpdateData,
  });

  String? status;
  String? message;
  BusinessUpdateData? businessUpdateData;

  factory BusinessUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      BusinessUpdateResponseModel(
        status: json["status"],
        message: json["message"],
        businessUpdateData: BusinessUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": businessUpdateData!.toJson(),
      };
}

class BusinessUpdateData {
  BusinessUpdateData({
    this.userId,
    this.groupId,
    this.businessName,
    this.businessAddress,
    this.businessPhoneNo,
    this.businessId,
    this.businessTypeId,
    this.id,
    this.user,
    this.businessType,
  });

  int? userId;
  int? groupId;
  String? businessName;
  String? businessAddress;
  String? businessPhoneNo;
  int? businessId;
  int? businessTypeId;
  int? id;
  User? user;
  BusinessType? businessType;

  factory BusinessUpdateData.fromJson(Map<String, dynamic> json) =>
      BusinessUpdateData(
        userId: json["userId"],
        groupId: json["groupId"],
        businessName: json["business_name"],
        businessAddress: json["business_address"],
        businessPhoneNo: json["business_phone_no"],
        businessId: json["businessId"],
        businessTypeId: json["businessTypeId"],
        id: json["id"],
        user: User.fromJson(json["user"]),
        businessType: BusinessType.fromJson(json["businessType"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "groupId": groupId,
        "business_name": businessName,
        "business_address": businessAddress,
        "business_phone_no": businessPhoneNo,
        "businessId": businessId,
        "businessTypeId": businessTypeId,
        "id": id,
        "user": user!.toJson(),
        "businessType": businessType!.toJson(),
      };
}

class BusinessType {
  BusinessType({
    this.id,
    this.typeName,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? typeName;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
        id: json["id"],
        typeName: json["type_name"],
        imagePath: json["image_path"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_name": typeName,
        "image_path": imagePath,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
