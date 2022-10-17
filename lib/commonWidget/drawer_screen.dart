import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    animation = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));

    animationController!.forward();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [drawerStartColor, drawerEndColor],
            ),
          ),
          child: Stack(
            children: [
              Image.asset(ImageString.drawerTopLeft),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils().hp(5),
                  horizontal: SizeUtils().wp(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.appName,
                      style: size48Regular(),
                    ),
                    SizedBox(height: SizeUtils().hp(8)),
                    _drawerElementWidget(
                      ImageString.drawerHomeSvg,
                      Strings.drawerHome,
                      currentScreen: AppScreens.profileScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerContactSvg,
                      Strings.drawerContacts,
                      currentScreen: AppScreens.contactScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerBagSvg,
                      Strings.drawerBusiness,
                      currentScreen: AppScreens.businessScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerCallSvg,
                      Strings.drawerUtilities,
                      currentScreen: AppScreens.utilitiesScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerCallSvg,
                      Strings.drawerInstant,
                      currentScreen: AppScreens.instantScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerBellSvg,
                      Strings.drawerNotification,
                      currentScreen: AppScreens.contactProfileScreen,
                    ),
                    _drawerElementWidget(
                      ImageString.drawerBagSvg,
                      Strings.drawerLogout,
                      tapOff: true,
                      onTap: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerElementWidget(String imageName, String pageName,
      {AppScreens? currentScreen, VoidCallback? onTap, bool tapOff = false}) {
    return Column(
      children: [
        GestureDetector(
          onTap: tapOff
              ? onTap
              : () {
                  if (context.read<DashboardBloc>().appScreens ==
                      currentScreen) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    context.read<DashboardBloc>().add(
                        DashboardLandingScreenEvent(appScreens: currentScreen));
                  }
                },
          child: AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.translationValues(
                    animation!.value * SizeUtils().screenWidth / 2, 0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeUtils().hp(1.2),
                      horizontal: SizeUtils().wp(2)),
                  child: Row(
                    children: [
                      SizedBox(
                        height: SizeUtils().hp(3),
                        width: SizeUtils().wp(6),
                        child: SvgPicture.asset(imageName),
                      ),
                      SizedBox(width: SizeUtils().wp(2.5)),
                      Text(
                        pageName,
                        style: size18Regular().copyWith(
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Divider(thickness: 2, color: whiteColor.withOpacity(0.32)),
      ],
    );
  }
}
