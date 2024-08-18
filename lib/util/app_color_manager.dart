import 'package:flutter/material.dart';

class AppColorManager {
  static const mainColor = Color(0xFF74569D);
  static const mainColorDark = Color(0xFF604781);
  static const topBarColor = Color(0xFF9F86C1);

  static const mainColorLight = Color(0xFF2CADB6);
  static const textColor = Color(0xFF606060);
  static const black = Color(0xFF000000);
  static const ampere = Color(0xFFFFC107);
  static const gray = Color(0xFF848484);
  static const lightGray = Color(0xFFFBFBFB);
  static const lightGrayEd = Color(0xFFEDEDED);
  static const offWhit = Color(0x4D777988);
  static const whit = Color(0xFFFFFFFF);
  static const red = Color(0xFFC60000);
  static const redPrice = Color(0xFF9C2121);
  static const cardColor = Color(0xFFEFEFEF);
  static const blue = Color(0xFF0D479E);

  static const dividerColor = Color(0xFFCFCFCF);
  static const f1 = Color(0xFFf1f1f1);
  static const a0 = Color(0xFFA0A0A0);
  static const f6 = Color(0xFFf6f6f6);
  static const e4 = Color(0xFF4E5053);
  static const ac = Color(0xFFACACAC);
  static const ee = Color(0xFFEEEEEE);
  static const d9 = Color(0xFFD9D9D9);

  static const fc = Color(0xFFFCFCFC);

  static const f8 = Color(0xFFF8F8F8);

  static const c36 = Color(0xFF36455A);
  static const c67 = Color(0xFF676767);
  static const f7 = Color(0xFFF7F7F7);
  static const c99 = Color(0xFF999999);

  static const priceColor =  Color(0xFF20889B);

  static const darkBluGry=  Color(0xFF565C63);





}

Color getColorFromHex(String hexColor) {
  String formattedHexColor =
      hexColor.replaceAll("#", ""); // Remove the '#' character if present
  if (formattedHexColor.length == 6) {
    formattedHexColor = "FF$formattedHexColor"; // Add the alpha value if it's missing
  }
  int colorValue = int.parse(formattedHexColor, radix: 16); // Parse the hex color string
  return Color(colorValue);
}

bool isColorDark(Color color) {
  final luminance =
      (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue) / 255;
  return luminance < 0.5;
}

Color getCheckColor(Color color) {
  if (isColorDark(color)) {
    return Colors.white;
  } else {
    return AppColorManager.gray;
  }
}

/*
    <color name="purple_200">#8BB93E</color>
    <color name="purple_500">#4CA243</color>
    <color name="purple_700">#008543</color>
    <color name="teal_200">#FFC107</color>
    <color name="teal_700">#A17A05</color>
    <color name="black">#000000</color>
    <color name="white">#FFFFFFFF</color>
    <color name="TRANSPARENT">#00000000</color>
    <color name="back_fill_F6">#F6F6F6</color>
    <color name="back_fill_F1">#F1F1F1</color>
    <color name="back_fill_F5">#F5F5F5</color>
    <color name="ampere">#FFC107</color>
    <color name="dark_ampere">#A17A05</color>
    <color name="light_ampere">#45FFD24C</color>
    <color name="ampere_bg">#EDB100</color>
    <color name="red">#F10303</color>
    <color name="light_gray">#F5F5F5</color>
    <color name="light_gray_alpha">#CCF1F1F1</color>
    <color name="light_bg">#E8E3E3</color>
    <color name="transparency_gray">#CCF1F1F1</color>
    <color name="orange">#EDB100</color>
    <color name="blur">#F1F1F1</color>
    <color name="gray">#FF8F8F8F</color>
    <color name="off_white">#F1F1F1</color>
    <color name="dark_green">#008543</color>
    <color name="green">#4CA243</color>
    <color name="light_green">#8BB93E</color>
    <color name="light_green_2">#D9FF9A</color>

 */
