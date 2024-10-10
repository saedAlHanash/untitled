import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


import '../core/api_manager/api_url.dart';
import '../core/app/app_widget.dart';
import '../core/injection/injection_container.dart';
import '../core/strings/enum_manager.dart';
import '../firebase_options.dart';
import 'app_controller.dart';

class DependencyInjection {
  static Future<void> init() async {

    await Note.initialize();

    await initDio();

    Get.put(AppController(), permanent: true);

    initRepositories();

    await initGetStorage();

    await initFirebaseMessaging();

    await requestPermission();
  }
}

String userBaseUrl = 'https://$baseUrl/mobile/user';
String trainerBaseUrl = 'https://$baseUrl/mobile/trainer';

initRepositories() {
  Get.put(PlanRepository(), permanent: true);
  // Get.put(GetRepository(), permanent: true);
  // Get.put(VideoControllerRepository(), permanent: true);
}

Future<void> initGetStorage() async {
  //log('init GetStore');
  //log(storage.user);
  //log("lang");
  //log(storage.langCode);
  AppController appController = Get.find<AppController>();
  appController.theme = (ThemeColor.light).obs;
  //log('======================================================');
  //log(storage.notification);

  return;
}

Future<void> initDio() async {
  //log('init Dio');
  BaseOptions baseOptions = BaseOptions(
    baseUrl: 'https://$baseUrl',
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
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
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
  if (title.isEmpty && body.isEmpty) return;

  sl<AnalyticService>().receivedNotification(type: 'notification');

  Note.showBigTextNotification(title: title, body: body);
}

Future<void> initFirebaseMessaging() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    ignoreUndefinedProperties: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (AppProvider.isTrainer) {
    FirebaseMessaging.instance.subscribeToTopic('trainer');
  } else {
    FirebaseMessaging.instance.subscribeToTopic('users');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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

    if (title.isEmpty && body.isEmpty) return;
    sl<AnalyticService>().receivedNotification(type: 'notification');
    Note.showBigTextNotification(title: title, body: body);
    ctx?.read<NotificationsCubit>().getNotifications();
  });
}

Future<void> requestPermission() async {
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

// Future<void> getProfileForLoginChat() async {
//   if (loading) return;
//   loading = true;
//   if (AppProvider.token.isEmpty) return;
//
//   if (FirebaseChatCore.instance.firebaseUser != null) return;
//
//   final result = await Methods.get(
//     url:  AppProvider.isTrainer
//         ? TRAINERURLS.trainerPorile
//         : TRAINEEURLS.getUserProfile,
//     options: Utils.getOptions(accept: true, withToken: true),
//   );
//   loading = false;
//
//   if (result.type == ApiResultType.success) {
//     final profile = TrainerModel.fromJson(result.data);
//
//     try {
//       if (await isChatUserFound(profile.id.toString() ?? '')) {
//       await  loginChatUser(profile.id.toString(), profile.name);
//         return;
//       } else {
//         await createChatUser(profile);
//       }
//     } on Exception catch (e) {}
//   } else {}
// }

class Note {
  static Future initialize() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
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

    await flutterLocalNotificationsPlugin!.show(
        (DateTime.now().millisecondsSinceEpoch.toUnsigned(31)),
        title,
        body,
        not);
  }
}
