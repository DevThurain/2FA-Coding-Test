import 'package:flutter/material.dart';
import 'package:two_fa/core/constants/app_fonts.dart';
import 'package:two_fa/core/constants/app_values.dart';

class TextStyles {
  const TextStyles._();

  static TextStyle inter10() {
    return const TextStyle(fontFamily: AppFonts.inter, fontSize: AppValues.p_10);
  }

  static TextStyle inter12() {
    return const TextStyle(fontFamily: AppFonts.inter, fontSize: AppValues.p_12);
  }

  static TextStyle inter14() {
    return const TextStyle(fontFamily: AppFonts.inter, fontSize: AppValues.p_14);
  }

  static TextStyle inter16() {
    return const TextStyle(fontFamily: AppFonts.inter, fontSize: AppValues.p_16);
  }
}
