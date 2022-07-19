import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  late TextEditingController mobileNumberController;
  late FocusNode mobileNumberFocusNode;
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    mobileNumberController = TextEditingController();
    mobileNumberFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    formKey = null;
    mobileNumberController.dispose();
    mobileNumberFocusNode.dispose();
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
              Image.asset(ImageString.topLeftBlur),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(ImageString.bottomRightBlur),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeUtils().hp(4)),
                    Text(
                      Strings.appName,
                      style: size48Regular(),
                    ),
                    SizedBox(height: SizeUtils().hp(2)),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 55),
                          child: Image.asset(ImageString.rectangle),
                        ),
                        Positioned(
                          top: 100,
                          left: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.login.toUpperCase(),
                                style: size38Regular(),
                              ),
                              SizedBox(height: SizeUtils().hp(7)),
                              Text(
                                Strings.mobileNo,
                                style: size18Regular(),
                              ),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefix: Text(Strings.phoneCode),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Image.asset(ImageString.polygonTopRight),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Image.asset(ImageString.polygonBottomLeft),
                        ),
                        Positioned(
                          bottom: 125,
                          child: SvgPicture.asset(ImageString.facebookSvg),
                        ),
                        Positioned(
                          bottom: 100,
                          left: 55,
                          child: SvgPicture.asset(ImageString.googleSvg),
                        ),
                        Positioned(
                          bottom: 80,
                          left: 120,
                          child: SvgPicture.asset(ImageString.instagramSvg),
                        ),
                        Positioned(
                          bottom: 45,
                          left: 35,
                          child: SvgPicture.asset(ImageString.loginSvg),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.newUser,
                                  style: size18Regular(),
                                ),
                                TextSpan(
                                  text: Strings.sign,
                                  style: size18Regular(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.signupScreen,
                                          (route) => false);
                                    },
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: Strings.up,
                                  style: size18Regular(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.signupScreen,
                                          (route) => false);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
