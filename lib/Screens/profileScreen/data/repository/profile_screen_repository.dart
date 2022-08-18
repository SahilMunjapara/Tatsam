import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/profileScreen/data/model/profile_update_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IProfileScreenRepository {
  Future updateProfile(ProfileupdatedEvent event);
}

class ProfileScreenRepository implements IProfileScreenRepository {
  static final ProfileScreenRepository _profileScreenRepository =
      ProfileScreenRepository._init();

  factory ProfileScreenRepository() {
    return _profileScreenRepository;
  }

  ProfileScreenRepository._init();

  @override
  Future updateProfile(ProfileupdatedEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      body['name'] = event.userName;
      body['email'] = event.userEmail;
      body['password'] = '111111';
      body['phone_no'] = event.userPhone;

      var result =
          await NetworkAPICall().patch(updateProfileURL + event.userId!, body);

      ProfileUpdateResponseModel responseModel =
          ProfileUpdateResponseModel.fromJson(result);

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
