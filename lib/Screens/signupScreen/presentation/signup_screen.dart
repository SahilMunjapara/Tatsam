import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailIdController;

  late FocusNode nameFocusNode;
  late FocusNode mobileNumberFocusNode;
  late FocusNode emailIdFocusNode;

  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    mobileNumberController = TextEditingController();
    emailIdController = TextEditingController();
    nameFocusNode = FocusNode();
    mobileNumberFocusNode = FocusNode();
    emailIdFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    formKey = null;
    nameController.dispose();
    mobileNumberController.dispose();
    emailIdController.dispose();
    nameFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    emailIdFocusNode.dispose();
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
                child: Image.asset(ImageString.topRightBlur),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(ImageString.bottomLeftBlur),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeUtils().hp(3)),
                    Text(
                      Strings.appName,
                      style: size48Regular(),
                    ),
                    SizedBox(height: SizeUtils().hp(2)),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 40),
                          child: Image.asset(ImageString.signupRectangle),
                        ),
                        Positioned(
                          top: 80,
                          right: 18,
                          child: Text(
                            Strings.signup.toUpperCase(),
                            style: size38Regular(),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.name,
                                style: size18Regular(),
                              ),
                              SizedBox(
                                width: 270,
                                height: 30,
                                child: TextFormField(
                                  decoration: const InputDecoration(
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
                              const SizedBox(height: 20),
                              Text(
                                Strings.email,
                                style: size18Regular(),
                              ),
                              SizedBox(
                                width: 270,
                                height: 30,
                                child: TextFormField(
                                  decoration: const InputDecoration(
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
                              const SizedBox(height: 20),
                              Text(
                                Strings.mobileNo,
                                style: size18Regular(),
                              ),
                              SizedBox(
                                width: 270,
                                height: 30,
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
                          left: 0,
                          child: Image.asset(ImageString.polygonTopLeft),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(ImageString.polygonBottomRight),
                        ),
                        Positioned(
                          bottom: 125,
                          right: 0,
                          child: SvgPicture.asset(ImageString.facebookSvg),
                        ),
                        Positioned(
                          bottom: 100,
                          right: 55,
                          child: SvgPicture.asset(ImageString.googleSvg),
                        ),
                        Positioned(
                          bottom: 80,
                          right: 120,
                          child: SvgPicture.asset(ImageString.instagramSvg),
                        ),
                        Positioned(
                          bottom: 45,
                          right: 35,
                          child: SvgPicture.asset(ImageString.signupSvg),
                        ),
                        Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.loginScreen, (route) => false);
                            },
                            child: Text(
                              Strings.login,
                              style: size18Regular(
                                decoration: TextDecoration.underline,
                              ),
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
