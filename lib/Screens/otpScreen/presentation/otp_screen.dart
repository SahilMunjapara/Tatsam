import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/otpScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/otpScreen/data/model/otp_screen_param.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/database/database_service.dart';
import 'package:tatsam/Utils/log_utils/log_util.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/Utils/validation/validation.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({this.otpScreenParam, Key? key}) : super(key: key);
  final OtpScreenParam? otpScreenParam;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpBloc otpBloc = OtpBloc();
  bool isLoading = false;
  bool isResendAvailable = false;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;
  late List<String> _pin;
  late String _verificationToken;
  String timerValue = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _verificationToken = widget.otpScreenParam!.tokenId;
    _focusNodes = List<FocusNode?>.filled(6, null, growable: false);
    _textControllers =
        List<TextEditingController?>.filled(6, null, growable: false);
    _pin = List.generate(6, (int i) {
      return '';
    });
    otpBloc.add(TimerStartEvent());
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].substring(3);
  }

  @override
  void dispose() {
    isLoading = false;
    _focusNodes.map((node) => node!.dispose()).toList();
    _textControllers.map((controller) => controller!.dispose()).toList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          body: BlocListener(
            bloc: otpBloc,
            listener: (context, state) {
              if (state is TimerStartedState) {
                _textControllers
                    .map((controller) => controller!.clear())
                    .toList();
                isResendAvailable = false;
              }
              if (state is TimerStoppedState) {
                isResendAvailable = true;
              }
              if (state is TimerTickedState) {
                timerValue = formatTime(int.parse(state.timeDetails));
              }
            },
            child: BlocBuilder(
              bloc: otpBloc,
              builder: (context, state) {
                return Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: Image.asset(ImageString.topRightCircle),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(ImageString.bottomLeftCircle),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: SizeUtils().hp(18),
                        width: SizeUtils().screenWidth,
                        child: Image.asset(
                          ImageString.building,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeUtils().hp(3)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils().wp(8)),
                            child: Text(
                              Strings.appName,
                              style: size48Regular(),
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(2)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils().wp(8)),
                            child: SizedBox(
                              height: SizeUtils().hp(16),
                              width: SizeUtils().wp(24),
                              child: SvgPicture.asset(
                                ImageString.otpVerificationSvg,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(7.5)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils().wp(8)),
                            child: Text(
                              Strings.otpScreenDetail,
                              style: size20Regular(),
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(6)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils().wp(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _otpTextFillWidget(isUp: true, i: 0),
                                _otpTextFillWidget(isUp: false, i: 1),
                                _otpTextFillWidget(isUp: true, i: 2),
                                _otpTextFillWidget(isUp: false, i: 3),
                                _otpTextFillWidget(isUp: true, i: 4),
                                _otpTextFillWidget(isUp: false, i: 5),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(6)),
                          isResendAvailable
                              ? GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () async {
                                          // otpBloc.add(TimerStartEvent());
                                          _resendOtp();
                                        },
                                  child: Text(
                                    Strings.resendOtp,
                                    style: size15Regular(),
                                  ),
                                )
                              : Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: Strings.resendOtpDetail,
                                        style: size15Regular(),
                                      ),
                                      TextSpan(
                                        text: timerValue.isEmpty
                                            ? Strings.twoMinute
                                            : timerValue,
                                        style: size15Regular(),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: SizeUtils().hp(2)),
                          InkWell(
                            onTap: isLoading
                                ? null
                                : () {
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //     context,
                                    //     Routes.dashboardScreen,
                                    //     (route) => false);
                                    if (checkValidation()) {
                                      _verifyOtp(
                                        _verificationToken,
                                        _getCurrentPin(),
                                      );
                                    }
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                color: otpBoxColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeUtils().hp(5),
                                  vertical: SizeUtils().wp(3),
                                ),
                                child: Text(
                                  Strings.verify,
                                  style: size19Regular(textColor: blackColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProgressBarRound(isLoading: isLoading),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp(String verificationCode, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationCode,
      smsCode: smsCode,
    );
    setState(() => isLoading = true);
    await auth.signInWithCredential(credential).then((value) async {
      final DatabaseService _databaseService = DatabaseService();
      await _databaseService
          .updateUserData(
        uid: value.user!.uid.toString(),
        userName: widget.otpScreenParam!.userName,
        userEmail: widget.otpScreenParam!.userEmail,
        userMobile: widget.otpScreenParam!.mobileNumber,
      )
          .then((value) {
        AppPreference().setBoolData(PreferencesKey.isLogin, true);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.dashboardScreen, (route) => false);
      });
    }).onError((error, stackTrace) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: error.toString(),
        duration: 1500,
      );
    });
    if (mounted) setState(() => isLoading = false);
  }

  bool checkValidation() {
    String otp = _getCurrentPin();
    if (otp.isEmpty) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: ValidatorString.otpRequired,
      );
      return false;
    } else if (!Validator.validOtp.hasMatch(otp)) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: ValidatorString.validOtp,
      );
      return false;
    } else {
      return true;
    }
  }

  void _resendOtp() async {
    setState(() => isLoading = true);
    await auth.verifyPhoneNumber(
      phoneNumber: widget.otpScreenParam!.mobileNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {
        if (mounted) setState(() => isLoading = false);
      },
      verificationFailed: (FirebaseAuthException exception) {
        SnackbarWidget.showSnackbar(
            context: context, message: exception.message);
        if (mounted) setState(() => isLoading = false);
      },
      codeSent: (String? verificationId, int? resendToken) {
        _verificationToken = verificationId!;
        if (mounted) setState(() => isLoading = false);
        otpBloc.add(TimerStartEvent());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) setState(() => isLoading = false);
      },
    );
  }

  Widget _otpTextFillWidget({bool? isUp, int? i}) {
    if (_focusNodes[i!] == null) _focusNodes[i] = FocusNode();

    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
    }
    return Column(
      children: [
        Visibility(visible: !isUp!, child: SizedBox(height: SizeUtils().hp(5))),
        SizedBox(
          height: SizeUtils().hp(7),
          width: SizeUtils().wp(12),
          child: Stack(
            children: [
              SizedBox(
                height: SizeUtils().hp(7),
                width: SizeUtils().wp(12),
                child: SvgPicture.asset(
                  ImageString.otpBoxSvg,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeUtils().wp(3),
                    right: SizeUtils().wp(3),
                  ),
                  child: TextFormField(
                    controller: _textControllers[i],
                    focusNode: _focusNodes[i],
                    keyboardType: TextInputType.phone,
                    style: size20Regular(textColor: blackColor),
                    textAlign: TextAlign.center,
                    cursorColor: blackColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (String str) {
                      if (str.length > 1) {
                        _handlePaste(str);
                        return;
                      }

                      if (str.isEmpty) {
                        if (i == 0) return;
                        _focusNodes[i]!.unfocus();
                        _focusNodes[i - 1]!.requestFocus();
                      }

                      setState(() {
                        _pin[i] = str;
                      });

                      if (str.isNotEmpty) _focusNodes[i]!.unfocus();
                      if (i + 1 != 6 && str.isNotEmpty) {
                        FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                      }

                      String currentPin = _getCurrentPin();

                      if (!_pin.contains(null) &&
                          !_pin.contains('') &&
                          currentPin.length == 6) {
                        LogUtils.showLogs(message: currentPin, tag: 'PIN');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(visible: isUp, child: SizedBox(height: SizeUtils().hp(5))),
      ],
    );
  }

  String _getCurrentPin() {
    String currentPin = "";
    for (var value in _pin) {
      currentPin += value;
    }
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > 6) {
      str = str.substring(0, 6);
    }
    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i]!.text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[6 - 1]);

    String currentPin = _getCurrentPin();

    if (!_pin.contains(null) && !_pin.contains('') && currentPin.length == 6) {
      LogUtils.showLogs(message: currentPin, tag: 'PIN');
    }
  }
}
