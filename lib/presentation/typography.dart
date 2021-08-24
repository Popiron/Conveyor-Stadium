import 'dart:ui';

import 'package:conveyor_stadium/presentation/colors.dart';
import 'package:flutter/material.dart';

class TypographyUtil {
  TypographyUtil._();
  static TextStyle get baseTextStyle => const TextStyle(
        fontFamily: "Roboto",
        color: ColorsUtil.whiteTextColor,
        decoration: TextDecoration.none,
      );

  static TextStyle get title {
    const double fontSize = 18;
    return baseTextStyle.copyWith(
      fontSize: fontSize,
      height: 36 / fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get text {
    const double fontSize = 14;
    return baseTextStyle.copyWith(
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get blackTitle {
    const double fontSize = 16;
    return baseTextStyle.copyWith(
      fontSize: fontSize,
      //height: 20 / fontSize,
      fontWeight: FontWeight.w500,
      color: ColorsUtil.blackTextColor,
    );
  }

  static TextStyle get bigBlackTitle {
    const double fontSize = 14;
    return baseTextStyle.copyWith(
      fontSize: fontSize,
      //height: 20 / fontSize,
      fontWeight: FontWeight.w700,
      color: ColorsUtil.blackTextColor,
    );
  }
}
