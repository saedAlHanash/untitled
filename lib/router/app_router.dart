import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/features/appointments/bloc/rating_cubit/rating_cubit.dart';
import 'package:fitness_storm/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Utils/Routes/app_pages.dart';
import '../core/injection/injection_container.dart';
import '../core/models/booked_appointments.dart';
import '../core/util/firebase_analytics_service.dart';
import '../features/appointments/bloc/add_time_cubit/add_time_cubit.dart';
import '../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../features/appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../features/appointments/bloc/create_bundle_cubit/create_bundle_cubit.dart';
import '../features/appointments/bloc/create_session_cubit/create_session_cubit.dart';
import '../features/appointments/bloc/remove_time_cubit/remove_time_cubit.dart';
import '../features/appointments/data/request/available_times_request.dart';
import '../features/appointments/data/request/bundles_request.dart';
import '../features/appointments/data/response/bundles_response.dart';
import '../features/appointments/ui/pages/appointments_page.dart';
import '../features/appointments/ui/pages/book_session_page.dart';
import '../features/appointments/ui/pages/create_bundle_page.dart';
import '../features/appointments/ui/pages/rating_page.dart';
import '../features/auth/bloc/apply_cubit/apply_cubit.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/apply_page.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/forget_password_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/profile/ui/pages/pdf_viewer_page.dart';
import '../features/profile/ui/pages/update_profile_page.dart';
import '../features/trainer/ui/pages/available_time_page.dart';

Route<dynamic> routes(RouteSettings settings) {
  var screenName = settings.name;

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

void startSignup() {
  final providers = [
    BlocProvider(create: (_) => sl<SignupCubit>()),
    BlocProvider(create: (_) => sl<LoginSocialCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const SignupPage(),
  );

  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'signup');
}

void startLogin() {
  final Widget page = MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<LoginCubit>()),
      BlocProvider(create: (_) => sl<LoginSocialCubit>()),
    ],
    child: const LoginPage(),
  );
  Get.offAll(page);
  sl<FirebaseAnalyticService>().screenView(name: 'login');
}

void startForgetPass(BuildContext context) {
  final phoneOrEmail = context.read<LoginCubit>().state.request.phoneOrEmail;

  final providers = [
    BlocProvider(
        create: (_) => sl<ForgetPasswordCubit>()..setPhoneOrEmail = phoneOrEmail),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ForgetPasswordPage(),
  );

  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'forget_password');
}

void startAppointment() {
  final providers = [
    BlocProvider(create: (_) => sl<BookedAppointmentsCubit>()..getBookedAppointments()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const AppointmentsPage(),
  );
  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'appointment');
}

void startRestPass() {
  final providers = [
    BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ResetPasswordPage(),
  );

  //loggerObject.w('startForgetPass');

  Get.to(page);
  sl<FirebaseAnalyticService>().screenView(name: 'rest_password');
  //endregion
}

void startApply() {
  final providers = [
    BlocProvider(create: (_) => sl<ApplyCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ApplyPage(),
  );

  //loggerObject.w('startApply');

  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'apply_as_trainer');
  //endregion
}

void startConfirmCodeAccount(BuildContext context) {
  final providers = [
    BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
    BlocProvider(create: (_) => sl<ResendCodeCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ConfirmCodePage(),
  );
  Get.offAll(page);
  sl<FirebaseAnalyticService>().screenView(name: 'confirm_code_account');
}

void startHome() {
  //loggerObject.w(AppProvider.isTrainer);
  Get.offAllNamed(AppProvider.isTrainer ? AppRoutes.trainerHomePage : AppRoutes.mainHome);
  sl<FirebaseAnalyticService>().screenView(name: 'home');
}

void startUpdateProfile() {
  final providers = [
    BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
  ];
  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const TraineeProfileInfoScreen(),
  );
  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'update_profile');
}

void startBookPrivetSession(TrainerModel trainer) {
  final providers = [
    BlocProvider(create: (_) => sl<CreateSessionCubit>()),
    BlocProvider(
      create: (_) => sl<AvailableTimesCubit>()
        ..getAvailableTimes(
          request: AvailableTimesRequest(),
          trainer: trainer,
        ),
    ),
    BlocProvider(
      create: (_) =>
          sl<BundlesCubit>()..getBundles(request: BundlesRequest(trainerId: trainer.id)),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const BookPrivateSessionScreen(),
  );

  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'book_privet_session');
}

void startAvailableTimePage() {
  final providers = [
    BlocProvider(create: (_) => sl<AddTimeCubit>()),
    BlocProvider(create: (_) => sl<RemoveTimeCubit>()),
    BlocProvider(
      create: (_) => sl<AvailableTimesCubit>()
        ..getTrainerAvailableTimes(
          request: AvailableTimesRequest(isBooked: 0),
        ),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const AvailableTimePage(),
  );

  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'available_time');
}

void startCreateBundle(Bundle bundle) {
  final providers = [
    BlocProvider(create: (_) => sl<CreateBundleCubit>()..setData(bundle: bundle)),
    BlocProvider(
      create: (_) => sl<AvailableTimesCubit>()
        ..getAvailableTimes(
          request: AvailableTimesRequest(),
          trainer: bundle.trainer,
        ),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const CreateBundlePage(),
  );
  Get.to(() => page);
  sl<FirebaseAnalyticService>().screenView(name: 'create_bundle');
}

Future<bool> startRating(Appointment appointment) async {
  final providers = [
    BlocProvider(create: (_) => sl<RatingCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: RatingPage(appointment: appointment),
  );
  final b = await Get.to(page);
  return b is bool;
}

void startPdf(String url, String name) {
  final Widget page = PdfViewerWidget(
    url: url,
    title: name,
  );
  Get.to(page);
}
