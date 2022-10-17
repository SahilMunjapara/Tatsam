import 'package:tatsam/Screens/instantScreen/bloc/instant_screen_event.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IInstantrepository {
  Future getInstantList(GetInstantEvent event) async {}
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
}
