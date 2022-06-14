import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppSizes {
  static late double height10, width10;

  static void mediaQueryHeightWidth() {
    height10 = Get.mediaQuery.size.height * 0.0118;
    width10 = Get.mediaQuery.size.width * 0.0118 * 2.1;
  }

  static EdgeInsets padding20 =
      EdgeInsets.symmetric(horizontal: width10 * 2, vertical: height10 * 2);

  static EdgeInsets horizontalPadding20 =
      EdgeInsets.symmetric(horizontal: width10 * 2);
}
