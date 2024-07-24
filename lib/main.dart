import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/error/error_manager.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/features/fire_chat/open_room_cubit/open_room_cubit.dart';
import 'package:fitness_storm/helper/lang_helper.dart';
import 'package:fitness_storm/services/caching_service/caching_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/Trainee Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'Screen/Trainee Screens/User Training/change_video_cubit/change_video_cubit.dart';
import 'Utils/dependency_injection.dart';
import 'core/api_manager/api_service.dart';
import 'core/app/app_provider.dart';
import 'core/app/app_widget.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/injection/injection_container.dart';
import 'core/strings/enum_manager.dart';
import 'features/auth/bloc/refresh_token_cubit/refresh_token_cubit.dart';
import 'features/fire_chat/messages_bloc/messages_cubit.dart';
import 'features/fire_chat/rooms_bloc/rooms_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        BlocProvider(create: (_) => sl<OpenRoomCubit>()),
        BlocProvider(create: (_) => sl<RoomsCubit>()..getChatRooms(false)),
        BlocProvider(create: (context) => ChangeVideoCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> setLastSeen() async {
  if (AppProvider.isTrainer) return;
  final result = await APIService().callApi(
    type: ApiType.patch,
    url: 'profile/last-seen',
    additional: additionalConstUser,
  );
  if (result.statusCode != 401) return;
  await AppProvider.logout();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> saveFCM() async {
  if (AppProvider.token.isEmpty) return;
  final token = await FirebaseMessaging.instance.getToken() ?? '';
  final response = await APIService().callApi(
    type: ApiType.post,
    url: PostUrl.insertFcmToken,
    body: {'device_token': token},
  );
  if (response.statusCode != 200) {
    loggerObject.e('error with fcm');
    ErrorManager.getApiError(response);
  }
}
