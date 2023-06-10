import 'dart:developer';
import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/main_home_controller.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:fitness_storm/helper/cache_helper.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Constants/constants.dart';
import 'Constants/enums.dart';
import 'app_controller.dart';



class DependencyInjection {
  static Future<void> init() async {
     // WidgetsFlutterBinding.ensureInitialized();
    // await initFirebaseMessaging();

    await CacheHelper.init();
    // await requestPermission();
    await initDio();

    Get.put(AppController(), permanent: true);
    initRepositories();

    await initGetStorage();
  }
}

initRepositories() {
  Get.put(PlanRepository(), permanent: true);
  // Get.put(GetRepository(), permanent: true);
  // Get.put(VideoControllerRepository(), permanent: true);
}

Future<void> initGetStorage() async {
  log('init GetStore');
  await GetStorage.init();
  StorageController storage = StorageController();
  log(storage.user);
  log("lang");
  log(storage.langCode);
  AppController appController = Get.find<AppController>();
  appController.theme =
      (storage.theme == "dark" ? ThemeColor.dark : ThemeColor.light).obs;
  log('======================================================');
  log(storage.notification);

  return;
}

Future<void> initDio() async {
  log('init Dio');
  BaseOptions baseOptions = BaseOptions(
    baseUrl: Constants.baseUrl,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 60 * 1000),
    receiveTimeout: const Duration(seconds: 60 * 1000),
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
    headers: {
      Headers.acceptHeader: "application/json",
      'lang': Get.find<LanguagesController>().selectedLanguage
    },
  );
  Dio dio = Dio(baseOptions);
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return true;
    };
    return null;
  };
  Get.put(dio, permanent: true);
  return;
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background Message Jsut Showed Up: ${message.messageId}');
}

initFirebaseMessaging() async {
  FirebaseMessaging.instance.subscribeToTopic(Constants.topicUserNotification);
  FirebaseMessaging.instance
      .subscribeToTopic(Constants.topicTrainerNotification);
  var androidInitialize =
       const AndroidInitializationSettings('');
  var iOSInitialize = const DarwinInitializationSettings();
  var initializationsSettings =  InitializationSettings(
      android: androidInitialize, iOS: iOSInitialize);
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'fitness_notification_channel',
    'fitness notification channel',
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification'),
    enableLights: true,
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    RemoteNotification notification = message.notification!;
    AndroidNotification android = message.notification!.android!;

    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: Get.theme.primaryColor,
            playSound: true,
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/launcher_icon.png',
            ticker: 'ticker',
          ),
        ),
      );
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    bool isSupportedFlutterAppBadger =
        await FlutterAppBadger.isAppBadgeSupported();
    if (isSupportedFlutterAppBadger) {
      if(!Get.isRegistered<MainHomeController>()){
        Get.put(MainHomeController());
      }
      await Get.find<MainHomeController>().getAllNotifications();
      if (Get.find<MainHomeController>().numberOfNotification != 0) {
        FlutterAppBadger.updateBadgeCount(1);
      } else {
        FlutterAppBadger.removeBadge();
      }

    }
    RemoteNotification notification = message.notification!;
    AndroidNotification android = message.notification!.android!;
    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: Get.theme.primaryColor,
            playSound: true,
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/launcher_icon.png',
            ticker: 'ticker',
          ),
        ),
      );
    }
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification notification = message.notification!;
  //   AndroidNotification android = message.notification!.android!;
  //   flutterLocalNotificationsPlugin.show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(channel.id, channel.name,
  //           color: Colors.blue,
  //           playSound: true,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           icon: '@mipmap/launcher_icon'),
  //     ),
  //   );
  // });

  var scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('you open notification');
  });
}

requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User Granted Permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User Granted Provisional Permission');
  } else {
    log('User Declined Or Has Not Accepted Permission');
  }
}
