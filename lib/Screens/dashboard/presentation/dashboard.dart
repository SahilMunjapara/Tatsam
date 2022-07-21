import 'package:flutter/material.dart';
import 'package:tatsam/Screens/dashboard/presentation/widget/bottomNavigationBar/circular_bottom_navigation.dart';
import 'package:tatsam/Screens/profileScreen/presentation/profile_screen.dart';
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
            Padding(
              child: Column(children: [
                Expanded(
                  child: bodyContainer(),
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
        ),
      ),
    );
  }

  Widget bodyContainer() {
    Color? selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        return const ProfileScreen();
      case 1:
        slogan = "Search";
        break;
      case 2:
        slogan = "Reports";
        break;
      case 3:
        slogan = "Notification";
        break;
      default:
        slogan = "";
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: selectedColor,
      child: Center(
        child: Text(
          slogan,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
      circleSize: SizeUtils().hp(8),
      iconsSize: SizeUtils().wp(5),
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
