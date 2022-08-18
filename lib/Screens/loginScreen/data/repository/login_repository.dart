import 'package:tatsam/Screens/loginScreen/bloc/login_screen_event.dart';
import 'package:tatsam/Screens/loginScreen/data/model/phone_check_response_model.dart';
import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/service/network/model/resource_model.dart';
import 'package:tatsam/service/network/network.dart';
import 'package:tatsam/service/network/network_string.dart';

abstract class ILoginRepository {
  Future phoneCheck(PhoneCheckEvent event);

  Future loginUserDetail(LoginUserDetailEvent event);
}

class LoginRepository implements ILoginRepository {
  static final LoginRepository _homeRepository = LoginRepository._init();

  factory LoginRepository() {
    return _homeRepository;
  }

  LoginRepository._init();

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
