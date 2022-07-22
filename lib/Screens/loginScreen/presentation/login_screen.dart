import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/Utils/validation/validation.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';

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
                      SizedBox(height: SizeUtils().hp(4)),
                      Text(
                        Strings.appName,
                        style: size48Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeUtils().hp(3),
                              bottom: SizeUtils().hp(7),
                            ),
                            child: SizedBox(
                              height: SizeUtils().hp(60),
                              width: SizeUtils().wp(150),
                              child: Image.asset(
                                ImageString.rectangle,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: SizeUtils().hp(13),
                            left: SizeUtils().wp(7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.login,
                                  style: size38Regular(),
                                ),
                                SizedBox(height: SizeUtils().hp(7)),
                                Text(
                                  Strings.mobileNo,
                                  style: size18Regular(),
                                ),
                                SizedBox(
                                  width: SizeUtils().wp(70),
                                  height: SizeUtils().hp(5),
                                  child: CustomTextField(
                                    prefix: Strings.phoneCode,
                                    maxLength: 10,
                                    controller: mobileNumberController,
                                    focusNode: mobileNumberFocusNode,
                                    textInputType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    style: size15Regular(letterSpacing: 1.25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: SizedBox(
                              height: SizeUtils().hp(15),
                              width: SizeUtils().wp(40),
                              child: Image.asset(
                                ImageString.polygonTopRight,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                              height: SizeUtils().hp(15),
                              width: SizeUtils().wp(40),
                              child: Image.asset(
                                ImageString.polygonBottomLeft,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: SizeUtils().hp(17),
                            child: SizedBox(
                              height: SizeUtils().hp(3.5),
                              width: SizeUtils().wp(3.5),
                              child: SvgPicture.asset(
                                ImageString.facebookSvg,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: SizeUtils().hp(13.8),
                            left: SizeUtils().wp(16),
                            child: SizedBox(
                              height: SizeUtils().hp(3.5),
                              width: SizeUtils().wp(6),
                              child: SvgPicture.asset(
                                ImageString.googleSvg,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: SizeUtils().hp(10.5),
                            left: SizeUtils().wp(34),
                            child: SizedBox(
                              height: SizeUtils().hp(3.3),
                              width: SizeUtils().wp(6),
                              child: SvgPicture.asset(
                                ImageString.instagramSvg,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: SizeUtils().hp(6),
                            left: SizeUtils().wp(11),
                            child: GestureDetector(
                              onTap: () {
                                checkValidation();
                              },
                              child: SizedBox(
                                height: SizeUtils().hp(3),
                                width: SizeUtils().wp(6),
                                child: SvgPicture.asset(
                                  ImageString.loginSvg,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (mobileNumberController.text.isEmpty) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: ValidatorString.mobileRequire,
      );
      return false;
    } else if (!Validator.mobileCharacter
        .hasMatch(mobileNumberController.text)) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: ValidatorString.validMobile,
      );
      return false;
    } else {
      return true;
    }
  }
}
