import 'package:flutter/material.dart';


MaterialColor primarySwatch = const MaterialColor(0xFF74569D, {
  0: Color(0xFFFFFFFF),
  50: Color(0xFF74569D),
  100: Color(0xFF74569D),
  200: Color(0xFF74569D),
  300: Color(0xFF74569D),
  400: Color(0xFF74569D),
  500: Color(0xFF74569D),
  600: Color(0xFF74569D),
  700: Color(0xFF74569D),
  800: Color(0xFF74569D),
  900: Color(0xFF74569D),
});

Color lightBackgroundColor = const Color(0xFF74569D);
Color darkGrey = const Color(0xFF9D9D9D);
Color lightGray = const Color(0xFFF3F3F3);
ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: primarySwatch,
    scaffoldBackgroundColor: Colors.white,
    cardColor: primarySwatch,
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    ),
    shadowColor: Colors.grey.withOpacity(0.3),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        backgroundColor: lightBackgroundColor),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch)
        .copyWith(secondary: const Color(0xFF54BECA))
        .copyWith(background: lightBackgroundColor.withOpacity(0.75)));

ThemeData darkTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: primarySwatch,
    scaffoldBackgroundColor: const Color(0xFF2B2B2B),
    unselectedWidgetColor: primarySwatch,
    cardColor: primarySwatch,
    shadowColor: Colors.white.withOpacity(0.1),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF2B2B2B), //lightBackgroundColor.withOpacity(0.75),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch)
        .copyWith(
          secondary: Colors.black.withOpacity(0.5),
          brightness: Brightness.dark,
        )
        .copyWith(background: lightBackgroundColor.withOpacity(0.75)));
