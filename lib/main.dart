import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Utils/themes.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:saed_http/api_manager/api_service.dart';

import './../core/translations.dart';
import 'Data/Api/methods.dart';
import 'Data/Api/urls.dart';
import 'Screen/Splash/splash_binding.dart';
import 'Screen/Trainee Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'Screen/chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import 'Utils/Routes/app_pages.dart';
import 'Utils/dependency_injection.dart';
import 'Utils/storage_controller.dart';
import 'Utils/utils.dart';

late Box<String> roomsBox;
late Box usersBox;
late Box<String> roomMessage;
late Box<int> latestUpdateMessagesBox;

Future<void> initialHive() async {
  roomsBox = await Hive.openBox('rooms');
  latestUpdateMessagesBox = await Hive.openBox('messages');
  usersBox = await Hive.openBox('users');
}

Future<void> reInitialHive() async {
  await roomsBox.close();
  await latestUpdateMessagesBox.close();
  await usersBox.close();
  await initialHive();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(LanguagesController());

  await DependencyInjection.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();

  ///send FCM to server
  saveFCM();

  APIService().initBaseUrl(baseUrl: 'api.fitnessstorm.org');
  setLastSeen();
  runApp(
    bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider(create: (_) => RefreshHomePlanCubit()),
        bloc.BlocProvider(create: (_) => GetRoomsCubit()),
      ],
      child: GetMaterialApp(
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
    ),
  );
}

void setLastSeen() {
  if (StorageController().token.isEmpty) return;

  APIService().initHeader(
    header: {
      'authorization': 'Bearer ${StorageController().token}',
    },
  );
  APIService().patchApi(
    url: 'mobile/user/profile/last-seen',
    body: {},
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

Future<void> saveFCM() async {
  if (StorageController().token.isEmpty) return;
  final token = await FirebaseMessaging.instance.getToken() ?? '';
  final option = Utils.getOptions(accept: true, withToken: true);
  Map<String, String> map = {'device_token': token};
  await Methods.post(url: TRAINEEURLS.saveFcm, options: option, data: map);
}
