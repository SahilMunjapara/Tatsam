import 'package:tatsam/Screens/utilitiesScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/data/model/utilities_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IUtilitiesRepository {
  Future getUtilitiesList(UtilitiesListEvent event) async {}
}

class UtilitiesRepository implements IUtilitiesRepository {
  static final UtilitiesRepository _utilitiesRepository =
      UtilitiesRepository._init();

  factory UtilitiesRepository() {
    return _utilitiesRepository;
  }

  UtilitiesRepository._init();

  @override
  Future getUtilitiesList(UtilitiesListEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      var result = await NetworkAPICall().get(getUtilitiesURL + event.groupId!);

      UtilitiesResponseModel responseModel =
          UtilitiesResponseModel.fromJson(result);

      resource = Resource(
        error: null,
        data: responseModel,
      );
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
