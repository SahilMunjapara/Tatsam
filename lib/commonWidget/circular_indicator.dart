import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';

class Indicator {
  static Widget screenProgressIndicator(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator(
          color: bottomBarColor,
        ),
      ),
    );
  }
}
