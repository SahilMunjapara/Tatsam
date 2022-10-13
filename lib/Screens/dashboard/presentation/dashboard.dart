import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/businessFormScreen/presentation/business_form_screen.dart';
import 'package:tatsam/Screens/businessScreen/presentation/business_screen.dart';
import 'package:tatsam/Screens/contactProfileScreen/presentation/contact_profile_screen.dart';
import 'package:tatsam/Screens/contactScreen/presentation/contact_screen.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';
import 'package:tatsam/Screens/dashboard/presentation/widget/bottomNavigationBar/circular_bottom_navigation.dart';
import 'package:tatsam/Screens/instantScreen/presentation/instant_screen.dart';
import 'package:tatsam/Screens/profileScreen/presentation/profile_screen.dart';
import 'package:tatsam/Screens/utilitiesScreen/presentation/utilities_screen.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

import 'widget/bottomNavigationBar/tab_item.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedPos = 0;

  List<TabItem> tabItems = List.of(
    [
      TabItem(Icons.home, "Home", Colors.transparent),
      TabItem(Icons.pedal_bike_rounded, "Search", Colors.transparent),
      TabItem(Icons.business_center_outlined, "Reports", Colors.transparent),
      TabItem(
          Icons.phone_enabled_outlined, "Notifications", Colors.transparent),
    ],
  );

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Stack(
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
                Padding(
                  child: Column(children: [
                    Expanded(
                      child: state is DashboardLandingScreenState
                          ? bodyContainer(state.appScreens)
                          : bodyContainer(
                              context.read<DashboardBloc>().appScreens),
                    ),
                    Container(
                      height: SizeUtils().hp(0.5),
                      color: bottomBarColor,
                    ),
                  ]),
                  padding: EdgeInsets.only(
                    bottom: SizeUtils().hp(8),
                  ),
                ),
                Align(alignment: Alignment.bottomCenter, child: bottomNav())
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bodyContainer(AppScreens currentScreen) {
    Color? selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        switch (currentScreen) {
          case AppScreens.profileScreen:
            return const ProfileScreen();

          case AppScreens.contactScreen:
            return const ContactScreen();

          case AppScreens.contactProfileScreen:
            return const ContactProfileScreen();

          case AppScreens.businessFormScreen:
            return const BusinessFormScreen();

          case AppScreens.utilitiesScreen:
            return const UtilitiesScreen();

          case AppScreens.instantScreen:
            return const InstantScreen();

          case AppScreens.businessScreen:
            return const BusinessScreen();
        }
      case 1:
      // slogan = "Log Out";
      // break;
      case 2:
      // slogan = "Log Out";
      // break;
      case 3:
      // slogan = "Log Out";
      // break;
      default:
        slogan = "";
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: selectedColor,
      child: Center(
        child: GestureDetector(
          onTap: () async {
            await AppPreference().clearSharedPreferences();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.loginScreen, (route) => false);
          },
          child: Text(
            slogan,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      normalIconColor: unActiveBottomNav,
      circleSize: SizeUtils().hp(7),
      iconsSize: SizeUtils().wp(6),
      barHeight: SizeUtils().hp(8),
      barBackgroundColor: backgroundColor,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(
            color: bottomBarColor, blurRadius: 6.0, offset: Offset(0, -1)),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
