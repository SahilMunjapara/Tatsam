import 'package:tatsam/Screens/contactProfileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IContactProfileRepository {
  Future getContactProfile(GetContactProfileEvent event) async {}
}

class ContactProfileRepository implements IContactProfileRepository {
  static final ContactProfileRepository _contactProfileRepository =
      ContactProfileRepository._init();

  factory ContactProfileRepository() {
    return _contactProfileRepository;
  }

  ContactProfileRepository._init();

  @override
  Future getContactProfile(GetContactProfileEvent event) async {
    Resource? resource;
    try {
      var result = await NetworkAPICall().get(userFetchURL + event.userId!);

      LoginUserFetchResponseModel responseModel =
          LoginUserFetchResponseModel.fromJson(result);

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
