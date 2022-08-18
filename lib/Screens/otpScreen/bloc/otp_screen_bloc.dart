import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/otpScreen/bloc/otp_screen_event.dart';
import 'package:tatsam/Screens/otpScreen/bloc/otp_screen_state.dart';
import 'package:tatsam/Screens/otpScreen/data/repository/otp_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class OtpBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  OtpScreenRepository otpScreenRepository = OtpScreenRepository();
  OtpBloc() : super(OtpInitialState());
  int timerSecond = 120;

  @override
  Stream<OtpScreenState> mapEventToState(OtpScreenEvent event) async* {
    if (event is TimerStartEvent) {
      timerSecond = 120;
      add(TimerStartedEvent());
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerSecond != 0) {
          timerSecond--;
          add(TimerTickedEvent(
            time: timerSecond.toString(),
          ));
        } else {
          timer.cancel();
          add(TimerStoppedEvent());
        }
      });
    }

    if (event is TimerTickedEvent) {
      yield TimerTickedState(timerSecond.toString());
    }

    if (event is TimerStartedEvent) {
      yield TimerStartedState();
    }

    if (event is TimerStoppedEvent) {
      yield TimerStoppedState();
    }

    if (event is LoadingStartedEvent) {
      yield LoadingStartedState(true);
    }

    if (event is LoadingStoppedEvent) {
      yield LoadingStoppedState(false);
    }

    if (event is SignUpEvent) {
      yield LoadingStartedState(true);
      Resource resource = await otpScreenRepository.signup(event);
      if (resource.data != null) {
        yield SignupState(resource.data);
      } else {
        yield OtpErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield LoadingStoppedState(false);
    }

    if (event is FetchUserEvent) {
      yield LoadingStartedState(true);
      Resource resource = await otpScreenRepository.getUser(event);
      if (resource.data != null) {
        yield FetchUserState(resource.data);
      } else {
        yield OtpErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield LoadingStoppedState(false);
    }
  }
}
