import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/log_utils/log_util.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;
  late List<String> _pin;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode?>.filled(4, null, growable: false);
    _textControllers =
        List<TextEditingController?>.filled(4, null, growable: false);
    _pin = List.generate(4, (int i) {
      return '';
    });
  }

  @override
  void dispose() {
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
          body: Stack(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeUtils().hp(3)),
                      Text(
                        Strings.appName,
                        style: size48Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      SizedBox(
                        height: SizeUtils().hp(16),
                        width: SizeUtils().wp(24),
                        child: SvgPicture.asset(
                          ImageString.otpVerificationSvg,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(7.5)),
                      Text(
                        Strings.otpScreenDetail,
                        style: size20Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _otpTextFillWidget(isUp: true, i: 0),
                          _otpTextFillWidget(isUp: false, i: 1),
                          _otpTextFillWidget(isUp: true, i: 2),
                          _otpTextFillWidget(isUp: false, i: 3),
                        ],
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Text(
                        Strings.resendOtp,
                        style: size15Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.dashboardScreen, (route) => false);
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
              ),
            ],
          ),
        ),
      ),
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
          height: SizeUtils().hp(9),
          width: SizeUtils().wp(14),
          child: Stack(
            children: [
              SizedBox(
                height: SizeUtils().hp(9),
                width: SizeUtils().wp(14),
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
                      if (i + 1 != 4 && str.isNotEmpty) {
                        FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                      }

                      String currentPin = _getCurrentPin();

                      if (!_pin.contains(null) &&
                          !_pin.contains('') &&
                          currentPin.length == 4) {
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
    if (str.length > 4) {
      str = str.substring(0, 4);
    }
    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i]!.text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[4 - 1]);

    String currentPin = _getCurrentPin();

    if (!_pin.contains(null) && !_pin.contains('') && currentPin.length == 4) {
      LogUtils.showLogs(message: currentPin, tag: 'PIN');
    }
  }
}
