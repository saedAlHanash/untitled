import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/bloc/logout/logout_cubit.dart';
import 'package:fitness_storm/features/profile/bloc/profile_cubit/profile_cubit.dart';
import 'package:fitness_storm/generated/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as b;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../Utils/Routes/app_pages.dart';
import '../../Utils/themes.dart';
import '../../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../features/appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/refresh_token_cubit/refresh_token_cubit.dart';
import '../../features/auth/bloc/survey_cubit/survey_cubit.dart';
import '../../features/bookmarked/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/bookmarked/bloc/bookmarked_cubit/bookmarked_cubit.dart';
import '../../features/coupon/coupon_cubit/coupon_cubit.dart';
import '../../features/diets/bloc/diets_cubit/diets_cubit.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/payments/bloc/payments_cubit/payments_cubit.dart';
import '../../features/payments/bloc/wallet_cubit/wallet_cubit.dart';
import '../../features/plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../features/plans/bloc/free_plans_cubit/free_plans_cubit.dart';
import '../../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../../features/plans/bloc/trainer_my_plans_cubit/trainer_my_plans_cubit.dart';
import '../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../features/trainer_files/bloc/trainer_files_cubit/trainer_files_cubit.dart';
import '../../features/training/bloc/exercise_cubit/exercise_cubit.dart';
import '../../features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../../generated/l10n.dart';
import '../../helper/lang_helper.dart';
import '../injection/injection_container.dart';
import '../translations.dart';
import '../util/shared_preferences.dart';
import 'app_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));
    setImageMultiTypeErrorImage(Assets.imagesLogo);
    super.initState();
  }

  Future<void> setLocale(Locale locale) async {
    AppSharedPreference.cashLocal(locale.languageCode);
    await S.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          initialHeightText: 1.5.sp,
          initialSize: 16.0.sp,
          selectable: false,
          initialFont: FontManager.semeBold.name,
          initialColor: AppColorManager.black,
        );

        return GetMaterialApp(
          color: Colors.white,
          title: "Fitness Storm",
          initialRoute: AppRoutes.splash,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fade,
          getPages: AppPages().getPages(),
          theme: lightTheme,
          translations: LocaleString(),
          locale: Locale(Get.find<LanguagesController>().selectedLanguage),
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return b.MultiBlocProvider(
              providers: [
                b.BlocProvider(create: (_) => sl<LogoutCubit>()),
                b.BlocProvider(create: (_) => sl<CouponCubit>()),
                b.BlocProvider(create: (_) => sl<SurveyCubit>()),
                b.BlocProvider(create: (_) => sl<ExercisesCubit>()),
                b.BlocProvider(create: (_) => sl<BundlesCubit>()),
                b.BlocProvider(create: (_) => sl<AddFavoriteCubit>()),
                b.BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
                b.BlocProvider(create: (_) => sl<PlansCubit>()..getPlans()),
                b.BlocProvider(create: (_) => sl<DietsCubit>()..getDiets()),
                b.BlocProvider(create: (_) => sl<BookedAppointmentsCubit>()),
                b.BlocProvider(create: (_) => sl<PaymentsCubit>()..getPayments()),
                b.BlocProvider(create: (_) => sl<WalletCubit>()..getWallet()),
                b.BlocProvider(create: (_) => sl<TrainersCubit>()..getTrainers()),
                b.BlocProvider(create: (_) => sl<ActivePlansCubit>()..getActivePlans()),
                b.BlocProvider(create: (_) => sl<RefreshTokenCubit>()..refreshToken()),
                b.BlocProvider(create: (_) => sl<BookmarkedCubit>()..getBookmarked()),
                b.BlocProvider(create: (_) => sl<TrainerFilesCubit>()..getTrainerFiles()),
                b.BlocProvider(
                  create: (_) => sl<FreePlansCubit>()..getTrendingPlans(),
                ),
                b.BlocProvider(
                  create: (_) => sl<TrainerMyPlansCubit>()..getTrainerMyPlans(),
                ),
                b.BlocProvider(
                  create: (_) => sl<ProfileCubit>()..getProfile(),
                  lazy: AppProvider.isLogin && (!AppProvider.isGuest),
                ),
                b.BlocProvider(
                    create: (_) => sl<WelcomeMessagesCubit>()..getWelcomeMessages()),
                b.BlocProvider(
                    create: (_) => sl<NotificationsCubit>()..getNotifications()),
                b.BlocProvider(
                    create: (_) => sl<AvailableTimesCubit>()..getTrainerAvailableTimes()),
              ],
              child: GestureDetector(
                onTap: () {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: AppProvider.isTestMode
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          child!,
                          IgnorePointer(
                            child: ImageMultiType(
                              height: 100.0.h,
                              width: 100.0.w,
                              color: Colors.grey,
                              url: Assets.imagesTestMode,
                            ),
                          ),
                        ],
                      )
                    : child!,
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          // onGenerateRoute: routes,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

BuildContext? get ctx => sl<GlobalKey<NavigatorState>>().currentContext;
