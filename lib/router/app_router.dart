import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/features/appointments/bloc/rating_cubit/rating_cubit.dart';
import 'package:fitness_storm/features/notifications/ui/pages/notifications_page.dart';
import 'package:fitness_storm/features/plans/ui/pages/plan_page.dart';
import 'package:fitness_storm/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:fitness_storm/features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:fitness_storm/features/trainer_files/bloc/create_trainer_file_cubit/create_trainer_file_cubit.dart';
import 'package:fitness_storm/features/training/bloc/temp_cubit/training_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';

import '../Screen/video/video.dart';
import '../Utils/Routes/app_pages.dart';
import '../core/app/app_widget.dart';
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
import '../features/bookmarked/ui/pages/bookmarked_page.dart';
import '../features/diets/bloc/create_diet_cubit/create_diet_cubit.dart';
import '../features/diets/bloc/delete_diet_cubit/delete_diet_cubit.dart';
import '../features/diets/ui/pages/diets_page.dart';
import '../features/fire_chat/chat.dart';
import '../features/fire_chat/messages_bloc/messages_cubit.dart';
import '../features/plans/bloc/plan_cubit/plan_cubit.dart';
import '../features/plans/bloc/plan_workout_cubit/plan_workout_cubit.dart';
import '../features/plans/bloc/subscribe_plan_cubit/subscribe_plan_cubit.dart';
import '../features/plans/data/response/plan_workout_response.dart';
import '../features/profile/ui/pages/pdf_viewer_page.dart';
import '../features/profile/ui/pages/update_profile_page.dart';
import '../features/trainer/ui/pages/available_time_page.dart';
import '../features/trainer/ui/pages/trainers_page.dart';
import '../features/trainer_files/bloc/delete_trainer_file_cubit/delete_trainer_file_cubit.dart';
import '../features/trainer_files/ui/pages/trainer_files_page.dart';
import '../features/training/ui/pages/training_page.dart';
import '../features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';
import '../features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../features/welcome_message/ui/pages/welcome_page.dart';
import '../services/chat_service/chat_service_core.dart';

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

  return MaterialPageRoute(
      builder: (_) => const Scaffold(backgroundColor: Colors.red));
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
  sl<AnalyticService>().screenView(name: 'signup');
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
  sl<AnalyticService>().screenView(name: 'login');
}

void startForgetPass(BuildContext context) {
  final phoneOrEmail = context.read<LoginCubit>().state.request.phoneOrEmail;

  final providers = [
    BlocProvider(
        create: (_) =>
            sl<ForgetPasswordCubit>()..setPhoneOrEmail = phoneOrEmail),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ForgetPasswordPage(),
  );

  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'forget_password');
}

void startAppointment() {
  final providers = [
    BlocProvider(
        create: (_) => sl<BookedAppointmentsCubit>()..getBookedAppointments()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const AppointmentsPage(),
  );
  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'appointment');
}

void startTrainerFiles() {
  final providers = [
    BlocProvider(create: (_) => sl<CreateTrainerFileCubit>()),
    BlocProvider(create: (_) => sl<DeleteTrainerFileCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const TrainerFilesPage(),
  );

  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'trainer_files');
}

void startDietsPage() {
  final providers = [
    BlocProvider(create: (_) => sl<CreateDietCubit>()),
    BlocProvider(create: (_) => sl<DeleteDietCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const DietsPage(),
  );

  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'diets_page');
}

void startRestPass() {
  final providers = [
    BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const ResetPasswordPage(),
  );

  Get.to(page);
  sl<AnalyticService>().screenView(name: 'rest_password');
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

  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'apply_as_trainer');
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
  sl<AnalyticService>().screenView(name: 'confirm_code_account');
}

void startHome() {
  ChatServiceCore.initFirebaseChat();

  Get.offAllNamed(
      AppProvider.isTrainer ? AppRoutes.trainerHomePage : AppRoutes.mainHome);
  sl<AnalyticService>().screenView(name: 'home');
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
  sl<AnalyticService>().screenView(name: 'update_profile');
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
      create: (_) => sl<BundlesCubit>()
        ..getBundles(request: BundlesRequest(trainerId: trainer.id)),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const BookPrivateSessionScreen(),
  );

  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'book_privet_session');
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
  sl<AnalyticService>().screenView(name: 'available_time');
}

void startBookMarked() {
  sl<AnalyticService>().screenView(name: 'bookmarked');

  const Widget page = BookmarkedPage();

  Get.to(() => page);
}

void startWelcomePage() {
  final providers = [
    BlocProvider(
      create: (_) => sl<WelcomeMessagesCubit>()..getWelcomeMessages(),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const WelcomePage(),
  );

  Get.to(() => page);
}

void startNotificationsPage() {
  const Widget page = NotificationsPage();

  Get.to(() => page);
}

void startCreateBundle(Bundle bundle) {
  final providers = [
    BlocProvider(
        create: (_) => sl<CreateBundleCubit>()..setData(bundle: bundle)),
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
    child: CreateBundlePage(bundle: bundle),
  );
  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'create_bundle');
  sl<AnalyticService>().startCheckoutBundle(bundle: bundle);
}

void startTrainersPage() {
  final providers = [
    BlocProvider(create: (_) => sl<TrainersCubit>()..getTrainers()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const TrainersPage(),
  );
  Get.to(() => page);
  sl<AnalyticService>().screenView(name: 'your_trainer');
}

void startChatPage(Room room) async {
  Navigator.push(ctx!, MaterialPageRoute(
    builder: (context) {
      return BlocProvider(
        create: (_) => sl<MessagesCubit>(),
        child: ChatPage(room: room),
      );
    },
  )).then(
    (value) {
      ChatServiceCore.latestSeenRoom(room.id);
    },
  );
}

void startPlanPage(String id) async {
  final providers = [
    BlocProvider(create: (_) => sl<SubscribePlanCubit>()),
    BlocProvider(create: (_) => sl<VimeoCubit>()),
    BlocProvider(
      create: (_) => sl<PlanCubit>()..getPlan(planId: int.parse(id)),
    ),
    BlocProvider(
      create: (_) =>
          sl<PlanWorkoutsCubit>()..getPlanWorkouts(id: int.parse(id)),
    ),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const PlanPage(),
  );

  Navigator.push(ctx!, MaterialPageRoute(builder: (context) => page));
}

void startTrainingPage(PlanWorkout planWorkout,bool complete) async {
  final providers = [
    BlocProvider(create: (_) => sl<TrainingCubit>()..initial(planWorkout,complete)),
    BlocProvider(create: (_) => sl<VimeoCubit>()),
  ];

  final Widget page = MultiBlocProvider(
    providers: providers,
    child: const TrainingPage(),
  );

  Navigator.push(ctx!, MaterialPageRoute(builder: (context) => page));
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

Future<void> startVideoCall(Appointment appointment) async {
  final Widget page = Video1(appointment: appointment);
  Get.to(page)?.then((value) {
    if (value == true) {
      startRating(appointment);
    }
  });
}

void startPdf(String url, String name) {
  final Widget page = PdfViewerWidget(
    url: url,
    title: name,
  );
  Get.to(page);
}
