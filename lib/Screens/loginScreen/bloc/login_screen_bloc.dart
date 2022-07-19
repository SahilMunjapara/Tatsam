import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/loginScreen/bloc/login_screen_event.dart';
import 'package:tatsam/Screens/loginScreen/bloc/login_screen_state.dart';
import 'package:tatsam/Screens/loginScreen/data/repository/login_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class LoginBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is LoginPerformLoginEvent) {
      yield LoginLoadingBeginState();
      Resource resource = await LoginRepository().performLogin(event);
      if (resource.data != null) {
        yield LoginFormSubmitted(resource.data);
      } else {
        yield LoginErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield LoginLoadingEndState();
    }
  }
}
