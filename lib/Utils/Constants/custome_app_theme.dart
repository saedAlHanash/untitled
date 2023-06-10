import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeAppTheme {
  /// font sized
  static const double fontSizeSmall = 10;
  static const double fontSizeDefault = 12;
  static const double fontSizeMedium = 14;
  static const double fontSizeLarge = 16;
  static const double fontSizeExtraLarge = 18;
  static const double fontSizeUltraLarge = 18;

  /// diminsion margin
  static const double marginSizeSmall = 10;
  static const double marginSizeDefault = 12;
  static const double marginSizeMedium = 14;
  static const double marginSizeLarge = 16;
  static const double marginSizeExtraLarge = 18;
  static const double marginSizeUltraLarge = 18;

  /// diminsion padding
  static const double paddingSizeSmall = 10;
  static const double paddingSizeDefault = 12;
  static const double paddingSizeMedium = 14;
  static const double paddingSizeLarge = 16;
  static const double paddingSizeExtraLarge = 18;
  static const double paddingSizeUltraLarge = 18;

  static TextStyle textStyleTitleInHomePage = TextStyle(
    color: Get.theme.primaryColor,
    fontSize: CustomeAppTheme.fontSizeExtraLarge,
    fontWeight: FontWeight.w500,
  );
}
