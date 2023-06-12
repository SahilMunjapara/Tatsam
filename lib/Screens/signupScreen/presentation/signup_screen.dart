import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/otpScreen/data/model/otp_screen_param.dart';
import 'package:tatsam/Screens/signupScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/log_utils/log_util.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/Utils/validation/validation.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/network_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool obscureTextValue = true;
  SignupBloc signupBloc = SignupBloc();
  late String deviceToken;
  late String userId;
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailIdController;
  late TextEditingController passwordController;

  late FocusNode nameFocusNode;
  late FocusNode mobileNumberFocusNode;
  late FocusNode emailIdFocusNode;
  late FocusNode passwordFocusNode;

  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();
    getDeviceToken();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    mobileNumberController = TextEditingController();
    emailIdController = TextEditingController();
    passwordController = TextEditingController();
    nameFocusNode = FocusNode();
    mobileNumberFocusNode = FocusNode();
    emailIdFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  getDeviceToken() async {
    deviceToken = '';
    await FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    formKey = null;
    isLoading = false;
    nameController.dispose();
    mobileNumberController.dispose();
    emailIdController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    emailIdFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: BlocConsumer(
            bloc: signupBloc,
            listener: (context, state) {
              if (state is SignupLoadingStartedState) {
                isLoading = state.loaded;
              }
              if (state is SignupLoadingStoppedState) {
                isLoading = state.loaded;
              }
              if (state is SignupPasswordState) {
                obscureTextValue = !obscureTextValue;
              }
              if (state is SignupUserState) {
                if (state.responseModel.status == ApiResponse.success) {
                  AppPreference().setStringData(PreferencesKey.userToken,
                      state.responseModel.signupData!.token!);
                  userId = state.responseModel.signupData!.id!.toString();
                  _phoneVerification(
                    Strings.phoneCode.trim() +
                        state.responseModel.signupData!.phoneNo!,
                  );
                }
              }
              if (state is SignupErrorState) {
                AppException exception = state.exception;
                SnackbarWidget.showBottomToast(message: exception.message);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils().wp(8),
                        ),
                        child:
                            NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowIndicator();
                            return false;
                          },
                          child: SingleChildScrollView(
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
                                      padding: EdgeInsets.only(
                                        top: SizeUtils().hp(3),
                                        bottom: SizeUtils().hp(6),
                                      ),
                                      child: SizedBox(
                                        height: SizeUtils().hp(70),
                                        width: SizeUtils().wp(150),
                                        child: Image.asset(
                                          ImageString.signupRectangle,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: SizeUtils().hp(10),
                                      right: SizeUtils().wp(7),
                                      child: Text(
                                        Strings.signup,
                                        style: size38Regular(),
                                      ),
                                    ),
                                    Positioned(
                                      top: SizeUtils().hp(19.5),
                                      left: SizeUtils().wp(7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: SizeUtils().hp(0.6)),
                                          Text(
                                            Strings.name,
                                            style: size18Regular(),
                                          ),
                                          SizedBox(
                                            width: SizeUtils().wp(70),
                                            height: SizeUtils().hp(4),
                                            child: CustomTextField(
                                              controller: nameController,
                                              focusNode: nameFocusNode,
                                              textInputType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: size15Regular(
                                                  letterSpacing: 1.25),
                                            ),
                                          ),
                                          SizedBox(height: SizeUtils().hp(2.8)),
                                          Text(
                                            Strings.email,
                                            style: size18Regular(),
                                          ),
                                          SizedBox(
                                            width: SizeUtils().wp(70),
                                            height: SizeUtils().hp(4),
                                            child: CustomTextField(
                                              controller: emailIdController,
                                              focusNode: emailIdFocusNode,
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: size15Regular(
                                                  letterSpacing: 1.25),
                                            ),
                                          ),
                                          SizedBox(height: SizeUtils().hp(2.8)),
                                          Text(
                                            Strings.mobileNo,
                                            style: size18Regular(),
                                          ),
                                          SizedBox(
                                            width: SizeUtils().wp(70),
                                            height: SizeUtils().hp(4),
                                            child: CustomTextField(
                                              prefix: Strings.phoneCode,
                                              maxLength: 10,
                                              controller: mobileNumberController,
                                              focusNode: mobileNumberFocusNode,
                                              textInputType: TextInputType.phone,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: size15Regular(
                                                  letterSpacing: 1.25),
                                            ),
                                          ),
                                          SizedBox(height: SizeUtils().hp(2.8)),
                                          Text(
                                            Strings.password,
                                            style: size18Regular(),
                                          ),
                                          SizedBox(
                                            width: SizeUtils().wp(70),
                                            height: SizeUtils().hp(4),
                                            child: CustomTextField(
                                              isObscureText: true,
                                              obscureText: obscureTextValue,
                                              onObscureTap: () => signupBloc
                                                  .add(SignupPasswordEvent()),
                                              controller: passwordController,
                                              focusNode: passwordFocusNode,
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: size15Regular(
                                                  letterSpacing: 1.25),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      child: SizedBox(
                                        height: SizeUtils().hp(15),
                                        width: SizeUtils().wp(40),
                                        child: Image.asset(
                                          ImageString.polygonTopLeft,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                if (checkValidation()) {
                                                  signupBloc.add(
                                                    SignupUserEvent(
                                                      userEmail: emailIdController
                                                          .text
                                                          .trim(),
                                                      userName: nameController
                                                          .text
                                                          .trim(),
                                                      userMobileNumber:
                                                          mobileNumberController
                                                              .text
                                                              .trim(),
                                                      userPassword:
                                                          passwordController.text,
                                                      deviceToken: deviceToken,
                                                    ),
                                                  );
                                                }
                                              },
                                        child: SizedBox(
                                          height: SizeUtils().hp(15),
                                          width: SizeUtils().wp(40),
                                          child: Image.asset(
                                            ImageString.polygonBottomRight,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: SizeUtils().hp(17.5),
                                      right: SizeUtils().wp(0.5),
                                      child: SizedBox(
                                        height: SizeUtils().hp(3.3),
                                        width: SizeUtils().wp(6),
                                        child: SvgPicture.asset(
                                          ImageString.instagramSvg,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: SizeUtils().hp(14),
                                      right: SizeUtils().wp(17.5),
                                      child: SizedBox(
                                        height: SizeUtils().hp(3.5),
                                        width: SizeUtils().wp(6),
                                        child: SvgPicture.asset(
                                          ImageString.googleSvg,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: SizeUtils().hp(10.8),
                                      right: SizeUtils().wp(37),
                                      child: SizedBox(
                                        height: SizeUtils().hp(3.5),
                                        width: SizeUtils().wp(3.5),
                                        child: SvgPicture.asset(
                                          ImageString.facebookSvg,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: SizeUtils().hp(6.5),
                                      right: SizeUtils().wp(11),
                                      child: SizedBox(
                                        height: SizeUtils().hp(3),
                                        width: SizeUtils().wp(6),
                                        child: GestureDetector(
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  if (checkValidation()) {
                                                    signupBloc.add(
                                                      SignupUserEvent(
                                                        userEmail:
                                                            emailIdController.text
                                                                .trim(),
                                                        userName: nameController
                                                            .text
                                                            .trim(),
                                                        userMobileNumber:
                                                            mobileNumberController
                                                                .text
                                                                .trim(),
                                                        userPassword:
                                                            passwordController
                                                                .text,
                                                        deviceToken: deviceToken,
                                                      ),
                                                    );
                                                  }
                                                },
                                          child: SvgPicture.asset(
                                            ImageString.signupSvg,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: InkWell(
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    Routes.loginScreen,
                                                    (route) => false);
                                              },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: SizeUtils().hp(1),
                                          ),
                                          child: Text(
                                            Strings.login,
                                            style: size18Regular(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ProgressBarRound(isLoading: isLoading),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (mobileNumberController.text.isEmpty ||
        emailIdController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      SnackbarWidget.showSnackbar(
        context: context,
        message: ValidatorString.allFieldRequired,
      );
      return false;
    } else {
      if (!Validator.validCharacters.hasMatch(nameController.text)) {
        SnackbarWidget.showSnackbar(
          context: context,
          message: ValidatorString.validName,
        );
        return false;
      } else if (!Validator.emailCharacter.hasMatch(emailIdController.text)) {
        SnackbarWidget.showSnackbar(
          context: context,
          message: ValidatorString.validEmail,
        );
        return false;
      } else if (!Validator.mobileCharacter
          .hasMatch(mobileNumberController.text)) {
        SnackbarWidget.showSnackbar(
          context: context,
          message: ValidatorString.validMobile,
        );
        return false;
      } else if (!Validator.passwordCharacter
          .hasMatch(passwordController.text)) {
        SnackbarWidget.showSnackbar(
          context: context,
          message: ValidatorString.validPassword,
        );
        return false;
      } else {
        return true;
      }
    }
  }

  void _phoneVerification(String phoneNumber) async {
    signupBloc.add(SignupLoadingStartedEvent());
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {
        if (mounted) signupBloc.add(SignupLoadingStoppedEvent());
      },
      verificationFailed: (FirebaseAuthException exception) {
        if (mounted) signupBloc.add(SignupLoadingStoppedEvent());
        LogUtils.showLogs(tag: 'EXCEPTION', message: exception.message!);
      },
      codeSent: (String? verificationId, int? resendToken) {
        if (mounted) signupBloc.add(SignupLoadingStoppedEvent());
        LogUtils.showLogs(
            tag: 'VERIFICATION', message: verificationId ?? 'NO FOUND');
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.otpScreen,
          (route) => false,
          arguments: OtpScreenParam(
            tokenId: verificationId!,
            mobileNumber: phoneNumber,
            userId: userId,
            password: passwordController.text,
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) signupBloc.add(SignupLoadingStoppedEvent());
      },
    );
  }
}
