import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const primaryColor = AppColorManager.black;
const secondaryColor = AppColorManager.mainColorDark;

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
        primary: primaryColor, secondary: secondaryColor, surface: Colors.white),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      iconSize: 30.0.r,
      smallSizeConstraints: BoxConstraints(
        maxWidth: 30.0.r,
        maxHeight: 30.0.r,
      ),
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        padding: WidgetStatePropertyAll(EdgeInsets.all(50.0.r)),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColorManager.mainColor.withOpacity(0.8);
            }
            return AppColorManager.mainColor; // Use the component's default.
          },
        ),
        surfaceTintColor: const WidgetStatePropertyAll(AppColorManager.mainColor),
        shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) => secondaryColor,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColorManager.dividerColor,
      endIndent: 36.0.w,
      indent: 36.0.w,
      space: 40.0.h,
      thickness: 1.0.h,
    ),
    iconButtonTheme: IconButtonThemeData(
        style:
            ButtonStyle(padding: WidgetStatePropertyAll(const EdgeInsets.all(2.0).r))),
    checkboxTheme: const CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColorManager.mainColor),
    ),
    scaffoldBackgroundColor: AppColorManager.whit);
