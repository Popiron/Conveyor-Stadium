import 'dart:ui';

import 'package:conveyor_stadium/presentation/colors.dart';
import 'package:flutter/material.dart';

class TypographyUtil {
  TypographyUtil._();
  static TextStyle get baseTextStyle => const TextStyle(
      fontFamily: "Rubik",
      color: ColorsUtil.textColor,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      letterSpacing: -1.5);

  static TextStyle get smallText {
    const double fontSize = 18;
    return baseTextStyle.copyWith(
      fontSize: fontSize,
    );
  }
}

extension TypographyUtilX on TextStyle {
  TextStyle highlighted() {
    return copyWith(color: ColorsUtil.highlightedColor);
  }
}
