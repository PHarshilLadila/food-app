import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xff53E88B),
      Color(0xff15BE77),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.clamp,
    transform: GradientRotation(0.0),
  );
  static const Color lightGreen = Color(0xff53E88B);
  static const Color extraLightGreen = Color.fromARGB(108, 207, 255, 209);

  static const Color darkGreen = Color(0xff15BE77);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);
  static const Color darkOrange = Color(0xffDA6317);
  static const Color lightOrange = Color.fromARGB(255, 255, 232, 205);

  static const Color lightGrey = Color.fromARGB(255, 226, 255, 218);
}
