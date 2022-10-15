import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/contactProfileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/loginScreen/data/model/login_user_fetch_response_model.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/gradient_text.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';

class ContactProfileScreen extends StatefulWidget {
  const ContactProfileScreen({Key? key}) : super(key: key);

  @override
  State<ContactProfileScreen> createState() => _ContactProfileScreenState();
}

class _ContactProfileScreenState extends State<ContactProfileScreen> {
  final ContactProfileBloc _contactProfileBloc = ContactProfileBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late LoginUserFetchResponseModel userProfileData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userProfileData = LoginUserFetchResponseModel(status: 'blank');
    _contactProfileBloc.add(
      GetContactProfileEvent(
          userId: context.read<DashboardBloc>().contactProfileSearchId),
    );
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        backgroundColor: transparentColor,
        drawer: const DrawerScreen(),
        body: BlocConsumer(
          bloc: _contactProfileBloc,
          listener: (context, state) {
            if (state is ContactProfileLoadingStartState) {
              isLoading = true;
            }
            if (state is ContactProfileLoadingEndState) {
              isLoading = false;
            }
            if (state is GetContactProfileState) {
              userProfileData = state.responseModel;
            }
            if (state is ContactProfileErrorState) {
              AppException exception = state.exception;

              SnackbarWidget.showBottomToast(message: exception.message);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils().hp(2)),
                      CustomAppBar(
                        title: Strings.profile,
                        onMenuTap: () =>
                            scaffoldState.currentState!.openDrawer(),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Expanded(
                        child: Stack(
                          children: [
                            userProfileData.status == 'blank'
                                ? const SizedBox()
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: SizeUtils().hp(12),
                                      width: SizeUtils().wp(22),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            ImageString.person,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: shadow1Color,
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            userProfileData.status == 'blank'
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeUtils().hp(5),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: otpBoxColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: SizeUtils().wp(4),
                                        ),
                                        child: ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            SizedBox(height: SizeUtils().hp(9)),
                                            _gradientTextWithShadow(
                                              userProfileData
                                                  .loginUserData!.name!,
                                            ),
                                            SizedBox(
                                                height: SizeUtils().hp(4.5)),
                                            _listComponentWidget(
                                              ImageString.bagSvg,
                                              'UI designer',
                                            ),
                                            _listComponentWidget(
                                              ImageString.callSvg,
                                              userProfileData
                                                  .loginUserData!.phoneNo!,
                                            ),
                                            _listComponentWidget(
                                              ImageString.emailSvg,
                                              userProfileData
                                                  .loginUserData!.email!,
                                            ),
                                            _listComponentWidget(
                                              ImageString.phoneSvg,
                                              userProfileData
                                                  .loginUserData!.phoneNo!,
                                            ),
                                            _listComponentWidget(
                                              ImageString.locationSvg,
                                              '35, Tulshivan Row House',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
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
    );
  }

  Widget _listComponentWidget(String image, String titleText) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeUtils().hp(2.5)),
      child: Row(
        children: [
          Container(
            height: SizeUtils().hp(6),
            width: SizeUtils().wp(11),
            decoration: const BoxDecoration(
              color: otpBoxColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(2, 2),
                  color: blackColor,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeUtils().wp(1.8)),
              child: SvgPicture.asset(image),
            ),
          ),
          SizedBox(width: SizeUtils().wp(2)),
          Text(
            titleText,
            style: size18Regular(),
          ),
        ],
      ),
    );
  }

  Widget _gradientTextWithShadow(String name) {
    return Center(
      child: GradientText(
        name,
        style: size24Regular().copyWith(shadows: [
          Shadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: blackColor.withOpacity(0.3),
          ),
        ]),
        gradient: const LinearGradient(
          colors: [textGradient1Color, textGradient2Color],
        ),
      ),
    );
  }
}
