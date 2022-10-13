import 'dart:developer';

import 'package:tatsam/Screens/contactScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IContactScreenRepository {
  Future getContactList(ContactListEvent event) async {}
}

class ContactScreenRepository implements IContactScreenRepository {
  static final ContactScreenRepository _contactScreenRepository =
      ContactScreenRepository._init();

  factory ContactScreenRepository() {
    return _contactScreenRepository;
  }

  ContactScreenRepository._init();

  @override
  Future getContactList(ContactListEvent event) async {
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
}
