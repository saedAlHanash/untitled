import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:fitness_storm/services/caching_service/caching_service.dart';
import 'package:fitness_storm/services/server_time_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/Trainee Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'Utils/dependency_injection.dart';
import 'core/api_manager/api_service.dart';
import 'core/app/app_provider.dart';
import 'core/app/app_widget.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/injection/injection_container.dart';
import 'features/auth/bloc/refresh_token_cubit/refresh_token_cubit.dart';
import 'features/fire_chat/get_chats_rooms_bloc/get_rooms_cubit.dart';

late Box<String> roomsBox;
late Box<String> messageBox;
late Box<int> latestUpdateMessagesBox;
late Box<String> latestMessagesBox;

Future<void> initialHive() async {
  roomsBox = await Hive.openBox('rooms');
  latestUpdateMessagesBox = await Hive.openBox('messages');

  latestMessagesBox = await Hive.openBox('latestMessagesBox');
}

Future<void> reInitialHive() async {
  await roomsBox.close();
  await latestUpdateMessagesBox.close();

  await initialHive();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServerTimeService.initialServerDate(reInitial: true);
  try {
    await di.init();

    await SharedPreferences.getInstance().then((value) {
      AppSharedPreference.init(value);
    });

    await CachingService.initial();

    Get.put(LanguagesController());

    await DependencyInjection.init();

    saveFCM();

    setLastSeen();

    RefreshTokenCubit.refreshTokenApi();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    sl<FirebaseAnalyticService>().initialApp();
  } catch (e) {
    loggerObject.e(e);
  }

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RefreshHomePlanCubit()),
        BlocProvider(create: (_) => RoomsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> setLastSeen() async {
  if (AppProvider.isTrainer) return;
  final result = await APIService().patchApi(
    url: 'profile/last-seen',
    additional: additionalConstUser,
  );
  if (result.statusCode != 401) return;
  await AppProvider.logout();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> saveFCM() async {
  if (AppProvider.token.isEmpty) return;
  final token = await FirebaseMessaging.instance.getToken() ?? '';
  final response = await APIService().postApi(
    url: PostUrl.insertFcmToken,
    body: {'device_token': token},
  );
  if (response.statusCode != 200) {
    loggerObject.e('error with fcm');
  }
}
