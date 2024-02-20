import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../features/appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../features/appointments/bloc/create_bundle_cubit/create_bundle_cubit.dart';
import '../../features/appointments/bloc/create_session_cubit/create_session_cubit.dart';
import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../../features/auth/bloc/logout/logout_cubit.dart';
import '../../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/auth/bloc/survey_cubit/survey_cubit.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/plans/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../../features/profile/bloc/profile_cubit/profile_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/trainer/bloc/trainer_cubit/trainer_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion

  //region auth
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => LogoutCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => GetMeCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => DeleteAccountCubit());
  sl.registerFactory(() => OtpPasswordCubit());
  sl.registerFactory(() => LoginSocialCubit());
  sl.registerFactory(() => SurveyCubit());

  //endregion

  // region Appointments
  sl.registerFactory(() => BookedAppointmentsCubit());
  sl.registerFactory(() => AvailableTimesCubit());
  sl.registerFactory(() => CreateSessionCubit());
  sl.registerFactory(() => CreateBundleCubit());

  //endregion

  //region Trainer

  sl.registerFactory(() => TrainerCubit());

  //endregion

  //region plans
  sl.registerFactory(() => PlansCubit());
  sl.registerFactory(() => AddFavoriteCubit());

  //endregion

  //region Notifications
  sl.registerFactory(() => NotificationsCubit());

  //endregion

  //region profile
  sl.registerFactory(() => ProfileCubit());
  sl.registerFactory(() => UpdateProfileCubit());

  //endregion

  //region bundles
  sl.registerFactory(() => BundlesCubit());
  //endregion

  //region Cart

  //endregion

  //region category

  //endregion

  //region Governors

  //endregion

  //region product

  //endregion

  //region colors

  //endregion

  //region manufacturers

  //endregion

  //region order

  //endregion

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
