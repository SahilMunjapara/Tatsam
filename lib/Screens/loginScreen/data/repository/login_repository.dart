import 'package:tatsam/Screens/loginScreen/bloc/login_screen_event.dart';
import 'package:tatsam/Screens/loginScreen/data/model/login_response_model.dart';
import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/Screens/loginScreen/data/model/phone_check_response_model.dart';
import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class ILoginRepository {
  Future phoneCheck(PhoneCheckEvent event);

  Future loginUserDetail(LoginUserDetailEvent event);

  Future loginUser(LoginUserEvent event);

  Future loginUserFetch(LoginUserFetchEvent event);
}

class LoginRepository implements ILoginRepository {
  static final LoginRepository _homeRepository = LoginRepository._init();

  factory LoginRepository() {
    return _homeRepository;
  }

  LoginRepository._init();

  @override
  Future loginUser(LoginUserEvent event) async {
    Resource? resource;
    try {
      var body = <String, dynamic>{};
      body['email'] = event.userEmail;
      body['password'] = event.userPassword;
      body['device_token'] = event.deviceToken;

      var result = await NetworkAPICall().post(loginUserURL, body);
      LoginResponseModel responseModel = LoginResponseModel.fromJson(result);

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
  Future loginUserFetch(LoginUserFetchEvent event) async {
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

  @override
  Future phoneCheck(PhoneCheckEvent event) async {
    Resource? resource;
    try {
      var result =
          await NetworkAPICall().get(phoneCheckURL + event.phoneNumber!);
      PhoneCheckResponseModel responseData =
          PhoneCheckResponseModel.fromJson(result);
      resource = Resource(
        error: null,
        data: responseData,
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
  Future loginUserDetail(LoginUserDetailEvent event) async {
    Resource? resource;
    try {
      var result = await NetworkAPICall().get(userDetail + event.phoneNumber!);

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
