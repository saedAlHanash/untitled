import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/helper/cache_helper.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../Data/Api/api_result.dart';
import '../Data/Api/methods.dart';
import '../Data/Api/urls.dart';
import '../Model/trainer.dart';
import '../Screen/chat/util.dart';
import '../firebase_options.dart';
import '../main.dart';
import 'Constants/constants.dart';
import 'Constants/enums.dart';
import 'app_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await initFirebaseMessaging();

    await Hive.initFlutter();
    initialHive();

    await Note.initialize();

    await CacheHelper.init();

    await initDio();

    Get.put(AppController(), permanent: true);
    initRepositories();

    await initGetStorage();

    await initFirebaseMessaging();

    await initFirebaseChat();

    await requestPermission();
  }
}

initRepositories() {
  Get.put(PlanRepository(), permanent: true);
  // Get.put(GetRepository(), permanent: true);
  // Get.put(VideoControllerRepository(), permanent: true);
}

Future<void> initGetStorage() async {
  //log('init GetStore');
  await GetStorage.init();
  StorageController storage = StorageController();
  //log(storage.user);
  //log("lang");
  //log(storage.langCode);
  AppController appController = Get.find<AppController>();
  appController.theme =
      (storage.theme == "dark" ? ThemeColor.dark : ThemeColor.light).obs;
  //log('======================================================');
  //log(storage.notification);

  return;
}

Future<void> initDio() async {
  //log('init Dio');
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
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      return true;
    };
    return null;
  };
  Get.put(dio, permanent: true);
  return;
}

const channel = AndroidNotificationChannel(
  'fitness_notification_channel',
  'fitness notification channel',
  playSound: true,
  sound: RawResourceAndroidNotificationSound('notification'),
  enableLights: true,
  importance: Importance.high,
);

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (flutterLocalNotificationsPlugin == null) {
    await Note.initialize();
  }

  final notification = message.notification;

  String title = '';
  String body = '';

  if (notification != null) {
    title = notification.title ?? '';
    body = notification.body ?? '';
  } else {
    title = message.data['title'] ?? '';
    body = message.data['body'] ?? '';
  }

  Note.showBigTextNotification(title: title, body: body);
}

initFirebaseMessaging() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance.subscribeToTopic(Constants.topicUserNotification);
  FirebaseMessaging.instance.subscribeToTopic(Constants.topicTrainerNotification);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;

    String title = '';
    String body = '';

    if (notification != null) {
      title = notification.title ?? '';
      body = notification.body ?? '';
    } else {
      title = message.data['title'] ?? '';
      body = message.data['body'] ?? '';
    }

    Note.showBigTextNotification(title: title, body: body);
  });
}

requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}

Future<void> initFirebaseChat() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {});
}

var loading = false;

Future<void> getProfileForLoginChat() async {
  if (loading) return;
  loading = true;
  if (StorageController().token.isEmpty) return;

  if (FirebaseChatCore.instance.firebaseUser != null) return;

  final result = await Methods.get(
    url: StorageController().userType == 'trainer'
        ? TRAINERURLS.trainerPorile
        : TRAINEEURLS.getUserProfile,
    options: Utils.getOptions(accept: true, withToken: true),
  );
  loading = false;

  if (result.type == ApiResultType.success) {
    final profile = Trainer.fromJson(result.data);

    try {
      if (await isChatUserFound(profile.id ?? '')) {
      await  loginChatUser(profile.id!, profile.name!);
        return;
      } else {
        await createChatUser(profile);
      }
    } on Exception catch (e) {}
  } else {}
}

class Note {
  static Future initialize() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidInitialize = const AndroidInitializationSettings('mipmap/launcher_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await flutterLocalNotificationsPlugin!.initialize(initializationsSettings);
  }

  static const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'Fitness',
    'Fitness Storm',
    playSound: true,
    enableVibration: true,
    styleInformation: BigTextStyleInformation(''),
    importance: Importance.max,
    priority: Priority.max,
  );

  static Future showBigTextNotification({
    required String title,
    required String body,
  }) async {
    var not = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin!
        .show((DateTime.now().millisecondsSinceEpoch.toUnsigned(31)), title, body, not);
  }
}
