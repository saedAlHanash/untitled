import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_storm/Utils/themes.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import './../core/translations.dart';
import 'Screen/Splash/splash_binding.dart';
import 'Utils/Routes/app_pages.dart';
import 'Utils/dependency_injection.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Get.put(LanguagesController());
  await DependencyInjection.init();
  
  

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          return null;
        },
      ));
    }
  }

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
