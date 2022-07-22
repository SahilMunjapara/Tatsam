import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/otpScreen/bloc/otp_screen_event.dart';
import 'package:tatsam/Screens/otpScreen/bloc/otp_screen_state.dart';

class OtpBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
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
  }
}
