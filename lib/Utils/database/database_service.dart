import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/database/user_model.dart';
import 'package:tatsam/Utils/log_utils/log_util.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._init();

  factory DatabaseService() {
    return _databaseService;
  }

  DatabaseService._init();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(FirebaseCollectionString.users);

  Future<UserData> getUserData(String uid) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
    UserData data =
        userDataFromJson(jsonEncode(documentSnapshot.data()).toString());
    LogUtils.showLogs(
      message: jsonEncode(documentSnapshot.data()).toString(),
      tag: 'USER DATA',
    );
    return data;
  }

  Future<bool> isUserAvailableInDatabase({String? uid}) async {
    QuerySnapshot querySnapshot = await userCollection.get();

    List<UserData> allData = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      return UserData.fromJson(data);
    }).toList();

    for (var item in allData) {
      if (item.uid == uid) {
        return true;
      }
    }

    return false;
  }

  Future<void> updateUserData({
    String? uid,
    String? userName,
    String? userEmail,
    String? userMobile,
    bool? isActive = true,
}) async {
    Map<String, dynamic> userData = {
      'userUID': uid,
      'userName': userName,
      'userEmail': userEmail,
      'userMobile': userMobile,
      'userIsActive': isActive,
    };

    return await userCollection.doc(uid).set(userData);
  }
}
