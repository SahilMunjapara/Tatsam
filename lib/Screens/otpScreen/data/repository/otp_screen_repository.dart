import 'package:tatsam/Screens/otpScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/Screens/signupScreen/data/model/signup_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class IOtpScreenRepository {
  Future signup(SignUpEvent event);

  Future getUser(FetchUserEvent event);
}

class OtpScreenRepository implements IOtpScreenRepository {
  static final OtpScreenRepository _otpScreenRepository =
      OtpScreenRepository._init();

  factory OtpScreenRepository() {
    return _otpScreenRepository;
  }

  OtpScreenRepository._init();

  @override
  Future signup(SignUpEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      body['name'] = event.userName;
      body['email'] = event.userEmail;
      body['password'] = event.userPassword;
      body['phone_no'] = event.userMobileNumber;

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

  @override
  Future getUser(FetchUserEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};

      var result = await NetworkAPICall().get(userDetail + event.userPhone!);

      FetchUserResponseModel responseModel =
          FetchUserResponseModel.fromJson(result);

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
