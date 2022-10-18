import 'package:flutter/material.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class CustomDialog {
  static displayDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => await Future<bool>.value(false),
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: SizeUtils().hp(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Strings.logout,
                        style: size18Regular(),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Strings.logoutSubtitle,
                        style: size15Regular(),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils().hp(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style:
                            ElevatedButton.styleFrom(primary: bottomBarColor),
                        child: Text(Strings.no, style: size15Regular()),
                      ),
                      SizedBox(width: SizeUtils().wp(4)),
                      ElevatedButton(
                        onPressed: () async {
                          await AppPreference().clearSharedPreferences();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.loginScreen, (route) => false);
                        },
                        style:
                            ElevatedButton.styleFrom(primary: bottomBarColor),
                        child: Text(Strings.yes, style: size15Regular()),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showSessionExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => Future<bool>.value(false),
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: SizeUtils().hp(2)),
                  Text(
                    Strings.sessionExpireTitle,
                    style: size19Regular(),
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                  Text(
                    Strings.sessionExpireSubtitle,
                    textAlign: TextAlign.center,
                    style: size14Regular(
                      textColor: whiteColor.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                  ElevatedButton(
                    onPressed: () async {
                      await AppPreference().clearSharedPreferences();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginScreen,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(primary: bottomBarColor),
                    child: Text(
                      Strings.login,
                      style: size15Regular(),
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(1)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
