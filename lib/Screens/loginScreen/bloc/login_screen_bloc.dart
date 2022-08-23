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
    if (event is PhoneCheckEvent) {
      yield LoginLoadingBeginState();
      Resource resource = await LoginRepository().phoneCheck(event);
      if (resource.data != null) {
        yield PhoneCheckState(resource.data);
      } else {
        yield LoginErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield LoginLoadingEndState();
    }

    if (event is LoginLoadingBeginEvent) {
      yield LoginLoadingBeginState();
    }

    if (event is LoginLoadingEndEvent) {
      yield LoginLoadingEndState();
    }

    if (event is LoginUserDetailEvent) {
      yield LoginLoadingBeginState();
      Resource resource = await LoginRepository().loginUserDetail(event);
      if (resource.data != null) {
        yield LoginUserDetailState(resource.data);
      } else {
        yield LoginErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield LoginLoadingEndState();
    }
  }
}
