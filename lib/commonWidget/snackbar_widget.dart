import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';

class SnackbarWidget {
  static showSnackbar({
    String? message,
    BuildContext? context,
    int duration = 800,
  }) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message!, style: size15Regular(textColor: blackColor)),
        backgroundColor: whiteColor,
        duration: Duration(milliseconds: duration),
      ),
    );
  }
}
