import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/gradient_text.dart';

class ContactProfileScreen extends StatefulWidget {
  const ContactProfileScreen({Key? key}) : super(key: key);

  @override
  State<ContactProfileScreen> createState() => _ContactProfileScreenState();
}

class _ContactProfileScreenState extends State<ContactProfileScreen> {
  late GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
          child: Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              CustomAppBar(
                title: Strings.profile,
                onMenuTap: () => scaffoldState.currentState!.openDrawer(),
              ),
              SizedBox(height: SizeUtils().hp(4)),
              Expanded(
                child: Stack(
                  children: [
                    Align(
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
                    Padding(
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
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(height: SizeUtils().hp(9)),
                              _gradientTextWithShadow('Nirav Patel'),
                              SizedBox(height: SizeUtils().hp(4.5)),
                              _listComponentWidget(
                                ImageString.bagSvg,
                                'UI designer',
                              ),
                              _listComponentWidget(
                                ImageString.callSvg,
                                '9988776655',
                              ),
                              _listComponentWidget(
                                ImageString.emailSvg,
                                'niravp.divsinfotech@gmail.com',
                              ),
                              _listComponentWidget(
                                ImageString.phoneSvg,
                                '9988776655',
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
        'Nirav patel',
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
