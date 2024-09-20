import 'package:fitness_storm/core/api_manager/helpers_api/log_api.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/app/app_widget.dart';
import '../features/bookmarked/bloc/bookmarked_cubit/bookmarked_cubit.dart';
import '../features/diets/bloc/diets_cubit/diets_cubit.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../features/trainer_files/bloc/trainer_files_cubit/trainer_files_cubit.dart';
import '../features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';

class LanguagesController extends GetxController {
  String get selectedLanguage => AppSharedPreference.getLocal;

  Future<void> setLanguage(String language, {bool fromAuthPage = false}) async {
    await AppSharedPreference.cashLocal(language);

    Get.updateLocale(Locale(language));
    if (fromAuthPage) {
      startLogin();
    } else {
      ctx?.readOrNull<DietsCubit>()?.getDiets();
      ctx?.readOrNull<BookmarkedCubit>()?.getBookmarked();
      ctx?.readOrNull<TrainerFilesCubit>()?.getTrainerFiles();
      ctx?.readOrNull<WelcomeMessagesCubit>()?.getWelcomeMessages();
      ctx?.readOrNull<NotificationsCubit>()?.getNotifications();
      startHome();
    }
  }
}
