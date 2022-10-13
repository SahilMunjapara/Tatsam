import 'package:tatsam/Screens/signupScreen/bloc/signup_screen_event.dart';
import 'package:tatsam/Screens/signupScreen/data/model/signup_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class ISignupScreenRepository {
  Future signup(SignupUserEvent event);
}

class SignupScreenRepository implements ISignupScreenRepository {
  static final SignupScreenRepository _otpScreenRepository =
      SignupScreenRepository._init();

  factory SignupScreenRepository() {
    return _otpScreenRepository;
  }

  SignupScreenRepository._init();

  @override
  Future signup(SignupUserEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      body['name'] = event.userName;
      body['email'] = event.userEmail;
      body['password'] = event.userPassword;
      body['phone_no'] = event.userMobileNumber;
      body['groupId'] = '1';
      body['device_token'] = event.deviceToken;

      var result = await NetworkAPICall().post(signupURL, body);

      SignupResponseModel responseModel = SignupResponseModel.fromJson(result);

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
