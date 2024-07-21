// import 'dart:async';
// import 'dart:ui';
// import '../../Utils/dependency_injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../notifications_service.dart';
//
// const notificationChannelId = 'fitness';
// const notificationId = 888;
//
// var dis = 0.0;
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   const channel = AndroidNotificationChannel(
//     notificationChannelId, // id
//     'MY FOREGROUND SERVICE', // title
//     description: 'This channel is used for important notifications.',
//     // description
//     importance: Importance.low, // importance must be at low or higher level
//   );
//
//   if (flutterLocalNotificationsPlugin == null) {
//     await Note.initialize();
//   }
//   await flutterLocalNotificationsPlugin!
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       // auto start service
//       autoStart: false,
//       isForegroundMode: true,
//       notificationChannelId: notificationChannelId,
//       initialNotificationTitle: 'مكالمة فيديو',
//       initialNotificationContent: 'يتم الآن إجراء مكالمة فيديو',
//       foregroundServiceNotificationId: 95412,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: false,
//
//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,
//
//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   return true;
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) async {
//     if (flutterLocalNotificationsPlugin == null) {
//       await Note.initialize();
//     }
//     flutterLocalNotificationsPlugin?.cancel(95412);
//     service.stopSelf();
//   });
//
//   if (service is AndroidServiceInstance) {
//     if (await service.isForegroundService()) {
//       if (flutterLocalNotificationsPlugin == null) {
//         await Note.initialize();
//       }
//
//       flutterLocalNotificationsPlugin?.show(
//         95412,
//         'مكالمة فيديو جارية',
//         'الاتصال تم',
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             notificationChannelId,
//             'videoCall',
//             ongoing: true,
//           ),
//         ),
//       );
//     }
//   }
// }
//
// Future<void> startLocationService() async {
//   final service = FlutterBackgroundService();
//   try {
//     service.startService();
//   } catch (e) {}
// }
//
// Future<void> stopLocationService() async {
//   final service = FlutterBackgroundService();
//   try {
//     service.invoke("stopService");
//   } catch (e) {}
// }
