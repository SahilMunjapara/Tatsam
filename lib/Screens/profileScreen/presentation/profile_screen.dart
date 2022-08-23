import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/Utils/validation/validation.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailIdController;
  bool isProfileEdit = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: AppPreference().getStringData(PreferencesKey.userName),
    );
    mobileNumberController = TextEditingController(
      text: AppPreference().getStringData(PreferencesKey.userPhone),
    );
    emailIdController = TextEditingController(
      text: AppPreference().getStringData(PreferencesKey.userEmail),
    );
  }

  void _fetchLocalData() {
    nameController.text =
        AppPreference().getStringData(PreferencesKey.userName);
    emailIdController.text =
        AppPreference().getStringData(PreferencesKey.userEmail);
    mobileNumberController.text =
        AppPreference().getStringData(PreferencesKey.userPhone);
  }

  void _saveToLocalDB() {
    AppPreference().setStringData(PreferencesKey.userName, nameController.text);
    AppPreference()
        .setStringData(PreferencesKey.userEmail, emailIdController.text);
    AppPreference()
        .setStringData(PreferencesKey.userPhone, mobileNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: false,
        body: BlocListener(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is ProfileLoadingStartedState) {
              isLoading = true;
            }
            if (state is ProfileLoadingStoppedState) {
              isLoading = false;
            }
            if (state is ProfileEditState) {
              isProfileEdit = state.isProfileEdit;
            }
            if (state is ProfileUpdatedState) {
              if (state.responseModel.status == 200) {
                _saveToLocalDB();
                profileBloc.add(ProfileEditEvent(isProfileEdit: false));
              } else {
                _fetchLocalData();
                profileBloc.add(ProfileEditEvent(isProfileEdit: false));
              }
            }
            if (state is ProfileErrorState) {
              AppException exception = state.exception;
              SnackbarWidget.showSnackbar(
                context: context,
                message: exception.message,
                duration: 1500,
              );
            }
          },
          child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeUtils().wp(8)),
                    child: Column(
                      children: [
                        SizedBox(height: SizeUtils().hp(2)),
                        _profileTitleWidgets(),
                        SizedBox(height: SizeUtils().hp(4)),
                        Visibility(
                          visible: isProfileEdit,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils().wp(2.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _fetchLocalData();
                                    profileBloc.add(
                                        ProfileEditEvent(isProfileEdit: false));
                                  },
                                  child: SizedBox(
                                    height: SizeUtils().hp(2.5),
                                    width: SizeUtils().wp(5),
                                    child:
                                        SvgPicture.asset(ImageString.closeSvg),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (checkValidation()) {
                                      profileBloc.add(
                                        ProfileupdatedEvent(
                                          userName: nameController.text,
                                          userEmail: emailIdController.text,
                                          userPhone:
                                              mobileNumberController.text,
                                          userId: AppPreference().getStringData(
                                              PreferencesKey.userId),
                                        ),
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    height: SizeUtils().hp(2.5),
                                    width: SizeUtils().wp(5),
                                    child:
                                        SvgPicture.asset(ImageString.checkSvg),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: SizeUtils().hp(2)),
                        Container(
                          height: SizeUtils().hp(18),
                          width: SizeUtils().wp(34),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: whiteColor,
                            // image: const DecorationImage(
                            //   image: AssetImage(ImageString.person),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: SizeUtils().hp(5),
                                  width: SizeUtils().wp(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: backgroundColor,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      profileBloc.add(
                                        ProfileEditEvent(
                                          isProfileEdit: !isProfileEdit,
                                        ),
                                      );
                                      if (!isProfileEdit) {
                                        _fetchLocalData();
                                      }
                                    },
                                    child: const Center(
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeUtils().hp(18),
                                width: SizeUtils().wp(34),
                                child: Center(
                                  child: Text(
                                    nameController.text.substring(0, 1),
                                    style: size48Regular(
                                        textColor: profileButtonColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeUtils().hp(3)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textFormTitle(Strings.fullName),
                            SizedBox(height: SizeUtils().hp(0.5)),
                            _textFormBackground(
                              child: CustomTextField(
                                enabled: isProfileEdit,
                                controller: nameController,
                                isBorder: false,
                                hintText: Strings.nameHint,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                style: size18Regular(),
                              ),
                            ),
                            SizedBox(height: SizeUtils().hp(2.5)),
                            _textFormTitle(Strings.contactNum),
                            SizedBox(height: SizeUtils().hp(0.5)),
                            _textFormBackground(
                              child: CustomTextField(
                                enabled: isProfileEdit,
                                controller: mobileNumberController,
                                isBorder: false,
                                maxLength: 10,
                                hintText: Strings.contactHint,
                                textInputType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                style: size18Regular(),
                              ),
                            ),
                            SizedBox(height: SizeUtils().hp(2.5)),
                            _textFormTitle(Strings.emailId),
                            SizedBox(height: SizeUtils().hp(0.5)),
                            _textFormBackground(
                              child: CustomTextField(
                                enabled: isProfileEdit,
                                controller: emailIdController,
                                isBorder: false,
                                hintText: Strings.emailHint,
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                style: size18Regular(),
                              ),
                            ),
                          ],
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
    );
  }

  bool checkValidation() {
    if (mobileNumberController.text.isEmpty ||
        emailIdController.text.isEmpty ||
        nameController.text.isEmpty) {
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
      } else {
        return true;
      }
    }
  }

  Widget _textFormBackground({Widget? child}) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageString.textForm),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils().hp(1),
          horizontal: SizeUtils().wp(8),
        ),
        child: child,
      ),
    );
  }

  Widget _textFormTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
      child: Text(title, style: size18Regular()),
    );
  }

  Widget _profileTitleWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: SizeUtils().hp(2)),
            Container(
              height: SizeUtils().hp(6),
              width: SizeUtils().wp(11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: profileButtonColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: boxShadow,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils().wp(2.5),
                  vertical: SizeUtils().hp(2),
                ),
                child: SvgPicture.asset(
                  ImageString.menuSvg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        Text(
          Strings.profile,
          style: size38Regular(),
        ),
        Column(
          children: [
            SizedBox(height: SizeUtils().hp(2)),
            Container(
              height: SizeUtils().hp(6),
              width: SizeUtils().wp(11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: profileButtonColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: boxShadow,
                    offset: Offset(-2, 2),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils().wp(3.5),
                  vertical: SizeUtils().hp(2),
                ),
                child: SvgPicture.asset(
                  ImageString.searchSvg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
