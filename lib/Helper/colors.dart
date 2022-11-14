// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';

extension colors on ColorScheme {
  static MaterialColor primaryApp = const MaterialColor(
    0xffFFFFFF,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color primary = Color(0xffFFFFFF);
  static const Color secondary = Color(0xff4B86B4);
  static const Color third = Color(0xffADCBE3);
  static const Color four = Color(0xffE7EFF6);
  static const Color background = Color(0xFFF9FAFD);

  static const Color white = Color(0xffffffff);
  static const Color lightWhite = Color(0xffe2e3ea);

  static const Color fontColor = Color(0xff000000);
  static const Color green = Color(0xff03ab51);
  static const Color darkGreen = Color(0xff064b25);
  static const Color blue = Color(0xff0099f8);
  static const Color maroon = Color(0xffc04f6a);

}
