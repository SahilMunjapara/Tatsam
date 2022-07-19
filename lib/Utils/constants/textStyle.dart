import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

/// 1px = sp(1 * 0.8 = 0.8)
///

TextStyle size16Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(12.8),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size18Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(14.4),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size48Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(38.4),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size38Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(29),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );
