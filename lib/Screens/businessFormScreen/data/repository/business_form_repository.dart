import 'package:tatsam/Screens/businessFormScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/businessFormScreen/data/model/business_add_response_model.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

class IBusinessFormRepository {
  Future addBusiness(AddNewBusinessEvent event) async {}
}

class BusinessFormRepository implements IBusinessFormRepository {
  static final BusinessFormRepository _businessFormRepository =
      BusinessFormRepository._init();

  factory BusinessFormRepository() {
    return _businessFormRepository;
  }

  BusinessFormRepository._init();

  @override
  Future addBusiness(AddNewBusinessEvent event) async {
    Resource? resource;
    try {
      var body = <String, String>{};
      body['userId'] =
          await AppPreference().getStringData(PreferencesKey.userId);
      body['groupId'] =
          await AppPreference().getStringData(PreferencesKey.groupId);
      body['business_name'] = event.businessName!;
      body['business_address'] = event.businessAddress!;
      body['business_phone_no'] = event.businessPhoneNumber!;
      body['businessTypeId'] = event.businessTypeId!;

      var result = await NetworkAPICall()
          .multiPartPostRequest(addBusinessURL, body, event.businessImage!);

      BusinessAddResponseModel responseModel =
          BusinessAddResponseModel.fromJson(result);

      resource = Resource(data: responseModel, error: null);
    } catch (e, stackTrace) {
      resource = Resource(error: e.toString(), data: null);
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }
}
