import 'package:flutter/material.dart';

const Color primary = Color(0xFF140432);
const Color isDark = Color(0xFF303030);
const Color isLight = Color(0xFFFFFFFF);
const Color blue = Color(0xFF2196f3);
const Color green = Color(0xFF2DF27C);
const Color yellow = Color(0xFFffeb3b);
const Color grey = Color(0xFF9E9E9E);
const Color black = Color(0xFF000000);

const primarySwatches = <int, Color>{
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
};

class CustomColor {
  static const MaterialColor kToDark = MaterialColor(
    0xff2DF27C, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
}
