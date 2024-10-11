import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/app/app_widget.dart';
import '../features/bookmarked/bloc/bookmarked_cubit/bookmarked_cubit.dart';
import '../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../features/plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../features/plans/bloc/trending_plans_cubit/trending_plans_cubit.dart';
import '../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';

class LanguagesController extends GetxController {
  String get selectedLanguage => AppSharedPreference.getLocal;

  Future<void> setLanguage(String language, {bool fromAuthPage = false}) async {
    await AppSharedPreference.cashLocal(language);

    Get.updateLocale(Locale(language));
    if (fromAuthPage) {
      startLogin();
    } else {
      ctx?.readOrNull<BookmarkedCubit>()?.getBookmarked();
      ctx?.readOrNull<TrainersCubit>()?.getTrainers(newData: true);
      ctx?.readOrNull<PlansCubit>()?.getPlans(newData: true);
      ctx?.readOrNull<ActivePlansCubit>()?.getActivePlans(newData: true);
      ctx?.readOrNull<TrendingPlansCubit>()?.getTrendingPlans(newData: true);
      ctx?.readOrNull<NotificationsCubit>()?.getNotifications();
      startHome();
    }
  }
}
