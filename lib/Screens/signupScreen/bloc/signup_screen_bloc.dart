import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/signupScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/signupScreen/data/repository/signup_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class SignupBloc extends Bloc<SignupScreenEvent, SignupScreenState> {
  SignupScreenRepository signupScreenRepository = SignupScreenRepository();
  SignupBloc() : super(SignupInitialState());

  @override
  Stream<SignupScreenState> mapEventToState(SignupScreenEvent event) async* {
    if (event is SignupLoadingStartedEvent) {
      yield SignupLoadingStartedState(true);
    }

    if (event is SignupLoadingStoppedEvent) {
      yield SignupLoadingStoppedState(false);
    }

    if (event is SignupPasswordEvent) {
      yield SignupPasswordState();
    }

    if (event is SignupUserEvent) {
      yield SignupLoadingStartedState(true);
      Resource resource = await signupScreenRepository.signup(event);
      if (resource.data != null) {
        yield SignupUserState(resource.data);
      } else {
        yield SignupErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield SignupLoadingStoppedState(false);
    }
  }
}
