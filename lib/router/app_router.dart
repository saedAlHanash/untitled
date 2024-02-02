import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitness_storm/core/strings/enum_manager.dart';

import '../core/injection/injection_container.dart';
import '../core/widgets/web_view.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/logout/logout_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';

Route<dynamic> routes(RouteSettings settings) {
  var screenName = settings.name;

  loggerObject.w(screenName);
  switch (screenName) {
    //region auth
    case RouteName.signup:
      //region
      {
        return MaterialPageRoute(
          builder: (_) {
            final providers = [
              BlocProvider(create: (_) => sl<SignupCubit>()),
            ];
            return MultiBlocProvider(
              providers: providers,
              child: const SignupPage(),
            );
          },
        );
      }
    //endregion
    case RouteName.login:
      //region
      {
        final providers = [
          BlocProvider(create: (_) => sl<LoginCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const LoginPage(),
            );
          },
        );
      }
    //endregion
    case RouteName.forgetPassword:
      //region
      {
        final providers = [
          BlocProvider(create: (_) => sl<ForgetPasswordCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ForgetPasswordPage(),
            );
          },
        );
      }
    //endregion
    case RouteName.resetPasswordPage:
      //region
      {
        final providers = [
          BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ResetPasswordPage(),
            );
          },
        );
      }
    //endregion
    case RouteName.confirmCode:
      //region
      {
        final providers = [
          BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
          BlocProvider(create: (_) => sl<ResendCodeCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ConfirmCodePage(),
            );
          },
        );
      }
    //endregion
    case RouteName.otpPassword:
      //region
      {
        final providers = [
          BlocProvider(create: (_) => sl<OtpPasswordCubit>()),
          BlocProvider(create: (_) => sl<ResendCodeCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const OtpPasswordPage(),
            );
          },
        );
      }
    //endregion

    //endregion
  }

  return MaterialPageRoute(builder: (_) => const Scaffold(backgroundColor: Colors.red));
}

class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/1';
  static const home = '/2';
  static const forgetPassword = '/3';
  static const resetPasswordPage = '/4';
  static const login = '/5';
  static const signup = '/6';
  static const confirmCode = '/7';

  static const product = '/9';
  static const myInfo = '/10';

  // static const searchResult = '/11';
  static const update = '/12';
  static const updateChoice = '/13';
  static const notifications = '/14';
  static const offers = '/15';
  static const bestSeller = '/16';
  static const myOrders = '/17';
  static const about = '/18';
  static const privacy = '/19';
  static const category = '/20';
  static const otpPassword = '/21';
  static const donePage = '/22';
  static const products = '/23';
  static const orderInfo = '/24';
  static const productOptions = '/25';
  static const webView = '/26';
  static const trackingOrder = '/27';
  static const map = '/28';
  static const chat = '/29';

  // static const supportRooms = '/30';
  static const supportRoom = '/31';
  static const faq = '/32';
}
