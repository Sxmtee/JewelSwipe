import 'package:flutter/material.dart';

class Sizes {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double sWidth;
  static late double sHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    sWidth = screenWidth / 100;
    sHeight = screenHeight / 100;
  }
}
