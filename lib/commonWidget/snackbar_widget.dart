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
        content: Text(message!, style: size15Regular()),
        backgroundColor: blackColor,
        duration: Duration(milliseconds: duration),
      ),
    );
  }
}
