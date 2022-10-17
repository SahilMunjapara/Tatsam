import 'package:tatsam/Screens/businessScreen/bloc/business_screen_event.dart';
import 'package:tatsam/Screens/businessScreen/data/model/business_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IBusinessRepository {
  Future getBusiness(GetBusinessEvent event) async {}
}

class BusinessRepository implements IBusinessRepository {
  static final BusinessRepository _businessRepository =
      BusinessRepository._init();

  factory BusinessRepository() {
    return _businessRepository;
  }

  BusinessRepository._init();

  @override
  Future getBusiness(GetBusinessEvent event) async {
    Resource? resource;
    try {
      var result =
          await NetworkAPICall().get(getAllBusinessURL + event.groupId!);

      BusinessResponseModel responseModel =
          BusinessResponseModel.fromJson(result);

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
