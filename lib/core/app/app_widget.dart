import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/bloc/logout/logout_cubit.dart';
import 'package:fitness_storm/features/profile/bloc/profile_cubit/profile_cubit.dart';
import 'package:fitness_storm/generated/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../Screen/Splash/splash_binding.dart';
import '../../Utils/Routes/app_pages.dart';
import '../../Utils/themes.dart';
import '../../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../features/appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/refresh_token_cubit/refresh_token_cubit.dart';
import '../../features/auth/bloc/survey_cubit/survey_cubit.dart';
import '../../features/bookmarked/bloc/bookmarked_cubit/bookmarked_cubit.dart';
import '../../features/coupon/coupon_cubit/coupon_cubit.dart';
import '../../features/plans/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/wallet/bloc/wallet_cubit/wallet_cubit.dart';
import '../../generated/l10n.dart';
import '../../helper/lang_helper.dart';
import '../injection/injection_container.dart';
import '../translations.dart';
import '../util/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> setLocale(BuildContext context, Locale newLocale) async {
    final state = context.findAncestorStateOfType<_MyAppState>();
    await state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));
    setImageMultiTypeErrorImage(
      const Opacity(
        opacity: 0.3,
        child: ImageMultiType(
          url: Assets.imagesLogo,
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
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
          headerSizeText: 28.0.sp,
          initialHeightText: 1.5.sp,
          titleSizeText: 20.0.sp,
          initialSize: 16.0.sp,
          selectable: false,
          initialFont: FontFamily.roboto.name,
          initialColor: AppColorManager.black,
        );

        return GetMaterialApp(
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
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return bloc.MultiBlocProvider(
              providers: [
                bloc.BlocProvider(create: (_) => sl<LogoutCubit>()),
                bloc.BlocProvider(create: (_) => sl<CouponCubit>()),
                bloc.BlocProvider(create: (_) => sl<SurveyCubit>()),
                bloc.BlocProvider(create: (_) => sl<BundlesCubit>()),
                bloc.BlocProvider(create: (_) => sl<AddFavoriteCubit>()),
                bloc.BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
                bloc.BlocProvider(
                    create: (_) => sl<WalletCubit>()..getWallet()),
                bloc.BlocProvider(
                    create: (_) => sl<RefreshTokenCubit>()..refreshToken()),
                bloc.BlocProvider(
                    create: (_) => sl<ProfileCubit>()..getProfile()),
                bloc.BlocProvider(
                  create: (_) => sl<BookmarkedCubit>()..getBookmarked(),
                ),
                bloc.BlocProvider(
                  create: (_) =>
                      sl<AvailableTimesCubit>()..getTrainerAvailableTimes(),
                ),
                bloc.BlocProvider(
                  create: (_) => sl<BookedAppointmentsCubit>(),
                ),
              ],
              child: child!,
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
