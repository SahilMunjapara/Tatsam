import 'dart:convert';

import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/instantScreen/bloc/instant_screen_event.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_add_response_model.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_delete_response_model.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_response_model.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IInstantrepository {
  Future getInstantList(GetInstantEvent event) async {}

  Future deleteInstant(InstantDeleteEvent event) async {}

  Future getAllContact(GetAllContactEvent event) async {}

  Future instantAdd(InstantAddEvent event) async {}
}

class InstantRepository implements IInstantrepository {
  static final InstantRepository _instantrepository = InstantRepository._init();

  factory InstantRepository() {
    return _instantrepository;
  }

  InstantRepository._init();

  @override
  Future getInstantList(GetInstantEvent event) async {
    Resource? resource;
    try {
      var result = await NetworkAPICall().get(getInstantURL + event.userId!);

      InstantResponseModel responseModel =
          InstantResponseModel.fromJson(result);

      resource = Resource(data: responseModel, error: null);
    } catch (e, stackTrace) {
      resource = Resource(
        error: e.toString(),
        data: null,
      );
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }

  @override
  Future deleteInstant(InstantDeleteEvent event) async {
    Resource? resource;
    try {
      var result =
          await NetworkAPICall().delete(deleteInstantURL + event.instantId!);

      InstantDeleteResponseModel responseModel =
          InstantDeleteResponseModel.fromJson(result);

      resource = Resource(data: responseModel, error: null);
    } catch (e, stackTrace) {
      resource = Resource(
        error: e.toString(),
        data: null,
      );
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }

  @override
  Future getAllContact(GetAllContactEvent event) async {
    Resource? resource;
    try {
      List<dynamic> result = await NetworkAPICall().get(userFetchURL);

      List<UserResponseModel> responseModel =
          result.map((user) => UserResponseModel.fromJson(user)).toList();

      resource = Resource(data: responseModel, error: null);
    } catch (e, stackTrace) {
      resource = Resource(
        error: e.toString(),
        data: null,
      );
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }

  @override
  Future instantAdd(InstantAddEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};
      body['userId'] =
          await AppPreference().getStringData(PreferencesKey.userId);
      body['instantUserId'] = event.instantIds!.map((e) => e).toList();
      body['groupId'] =
          await AppPreference().getStringData(PreferencesKey.groupId);

      var result =
          await NetworkAPICall().post(addNewInstantURL, body, isDecoded: true);

      InstantAddResponseModel responseModel =
          InstantAddResponseModel.fromJson(result);

      resource = Resource(data: responseModel, error: null);
    } catch (e, stackTrace) {
      resource = Resource(
        error: e.toString(),
        data: null,
      );
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }
}
