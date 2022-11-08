import 'package:tatsam/Screens/businessFormEditScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/businessFormEditScreen/data/model/business_update_response_model.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IBusinessFormEditRepository {
  Future updateBusiness(UpdateBusinessEvent event) async {}
}

class BusinessFormEditRepository implements IBusinessFormEditRepository {
  static final BusinessFormEditRepository _businessFormEditRepository =
      BusinessFormEditRepository._init();

  factory BusinessFormEditRepository() {
    return _businessFormEditRepository;
  }

  BusinessFormEditRepository._init();

  @override
  Future updateBusiness(UpdateBusinessEvent event) async {
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
      body['businessId'] = event.businessId!;
      body['businessTypeId'] = event.businessTypeId!;

      var result = event.businessImage!.path.isNotEmpty
          ? await NetworkAPICall().multiPartPatchrequest(
              updateBusinessURL, body, event.businessImage!)
          : await NetworkAPICall().patch(updateBusinessURL, body);

      BusinessUpdateResponseModel responseModel =
          BusinessUpdateResponseModel.fromJson(result);

      resource = Resource(error: null, data: responseModel);
    } catch (e, stackTrace) {
      resource = Resource(error: e.toString(), data: null);
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }
    return resource;
  }
}
