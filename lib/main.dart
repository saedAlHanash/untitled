import 'dart:io';

import 'package:fitness_storm/Utils/themes.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import './../core/translations.dart';
import 'Screen/Splash/splash_binding.dart';
import 'Utils/Routes/app_pages.dart';
import 'Utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LanguagesController());

  await DependencyInjection.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    GetMaterialApp(
      color: Colors.white,
      title: "Fitness Storm",
      initialBinding: SplashBinding(),
      initialRoute: AppRoutes.splash,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      getPages: AppPages().getPages(),
      theme: lightTheme,
      translations: LocaleString(),
      locale: Locale(Get.find<LanguagesController>().selectedLanguage),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}