import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/profileScreen/data/model/profile_update_response_model.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IProfileScreenRepository {
  Future updateProfile(ProfileupdatedEvent event);

  Future getUserDetail(ProfileDetailFetchEvent event);
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
      var body = <String, String>{};

      body['name'] = event.userName!;
      body['email'] = event.userEmail!;
      body['password'] = AppPreference().getStringData(PreferencesKey.userPassword);
      body['phone_no'] = event.userPhone!;
      body['groupId'] = event.groupId!;

      var result = event.userImage!.path.isNotEmpty
          ? await NetworkAPICall().multiPartPatchrequest(
              updateProfileURL + event.userId!,
              body,
              event.userImage!,
            )
          : await NetworkAPICall().patch(
              updateProfileURL + event.userId!,
              body,
            );

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

  @override
  Future getUserDetail(ProfileDetailFetchEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      var result = await NetworkAPICall().get(userDetail + event.userId!);

      LoginUserFetchResponseModel responseModel =
          LoginUserFetchResponseModel.fromJson(result);

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
