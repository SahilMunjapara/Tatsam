import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/signupScreen/bloc/bloc.dart';

class SignupBloc extends Bloc<SignupScreenEvent, SignupScreenState> {
  SignupBloc() : super(SignupInitialState());

  @override
  Stream<SignupScreenState> mapEventToState(SignupScreenEvent event) async* {
    if (event is SignupLoadingStartedEvent) {
      yield SignupLoadingStartedState(true);
    }

    if (event is SignupLoadingStoppedEvent) {
      yield SignupLoadingStoppedState(false);
    }
  }
}
