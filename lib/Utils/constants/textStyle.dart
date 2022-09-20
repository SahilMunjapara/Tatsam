import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

/// 1px = sp(1 * 0.8 = 0.8)
/// 1px = sp(1 * 0.76 = 0.76)

TextStyle size12Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(9.12),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size15Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(11.4),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size16Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(12.16),
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
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(13.68),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size19Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(14.44),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size20Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(15.2),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size21Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(15.96),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );

TextStyle size24Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(18.24),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
      decoration: decoration,
    );

TextStyle size30Regular({
  Color? textColor,
  double? letterSpacing = 0.0,
  TextDecoration? decoration = TextDecoration.none,
}) =>
    TextStyle(
      fontFamily: Strings.secondFontFamily,
      color: textColor ?? whiteColor,
      fontSize: SizeUtils().sp(22.8),
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
      fontSize: SizeUtils().sp(36.48),
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
      fontSize: SizeUtils().sp(28.88),
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );
