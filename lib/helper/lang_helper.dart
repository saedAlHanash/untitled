import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/app/app_widget.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';

class LanguagesController extends GetxController {
  String get selectedLanguage => AppSharedPreference.getLocal;

  Future<void> setLanguage(String language, {bool fromAuthPage = false}) async {
    await AppSharedPreference.cashLocal(language);

    Get.updateLocale(Locale(language));
    if (fromAuthPage) {
      startLogin();
    } else {
      if (AppProvider.isLogin) {
        ctx?.readOrNull<NotificationsCubit>()?.getNotifications(newData: true);
        startHome(true);
      }
    }
  }
}
