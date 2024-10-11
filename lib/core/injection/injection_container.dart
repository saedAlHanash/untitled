import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/appointments/bloc/add_time_cubit/add_time_cubit.dart';
import '../../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../features/appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../features/appointments/bloc/create_bundle_cubit/create_bundle_cubit.dart';
import '../../features/appointments/bloc/create_session_cubit/create_session_cubit.dart';
import '../../features/appointments/bloc/rating_cubit/rating_cubit.dart';
import '../../features/appointments/bloc/remove_time_cubit/remove_time_cubit.dart';
import '../../features/auth/bloc/apply_cubit/apply_cubit.dart';
import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../../features/auth/bloc/logout/logout_cubit.dart';
import '../../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../features/auth/bloc/refresh_token_cubit/refresh_token_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/auth/bloc/survey_cubit/survey_cubit.dart';
import '../../features/bookmarked/bloc/add_favorite/add_favorite_cubit.dart';
import '../../features/bookmarked/bloc/bookmarked_cubit/bookmarked_cubit.dart';
import '../../features/coupon/coupon_cubit/coupon_cubit.dart';
import '../../features/diets/bloc/create_diet_cubit/create_diet_cubit.dart';
import '../../features/diets/bloc/delete_diet_cubit/delete_diet_cubit.dart';
import '../../features/diets/bloc/diet_cubit/diet_cubit.dart';
import '../../features/diets/bloc/diets_cubit/diets_cubit.dart';
import '../../features/fire_chat/messages_bloc/messages_cubit.dart';
import '../../features/fire_chat/open_room_cubit/open_room_cubit.dart';
import '../../features/fire_chat/rooms_bloc/rooms_cubit.dart';
import '../../features/fire_chat/userss_bloc/users_bloc.dart';
import '../../features/notifications/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/payments/bloc/payments_cubit/payments_cubit.dart';
import '../../features/payments/bloc/wallet_cubit/wallet_cubit.dart';
import '../../features/plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../features/plans/bloc/free_plans_cubit/free_plans_cubit.dart';
import '../../features/plans/bloc/plan_cubit/plan_cubit.dart';
import '../../features/plans/bloc/plan_workout_cubit/plan_workout_cubit.dart';
import '../../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../../features/plans/bloc/subscribe_plan_cubit/subscribe_plan_cubit.dart';
import '../../features/profile/bloc/profile_cubit/profile_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/search/bloc/temp_cubit/search_cubit.dart';
import '../../features/trainer/bloc/trainer_cubit/trainer_cubit.dart';
import '../../features/trainer/bloc/trainer_plans_cubit/trainer_plans_cubit.dart';
import '../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../features/trainer_files/bloc/create_trainer_file_cubit/create_trainer_file_cubit.dart';
import '../../features/trainer_files/bloc/delete_trainer_file_cubit/delete_trainer_file_cubit.dart';
import '../../features/trainer_files/bloc/trainer_files_cubit/trainer_files_cubit.dart';
import '../../features/training/bloc/exercise_cubit/exercise_cubit.dart';
import '../../features/training/bloc/temp_cubit/training_cubit.dart';
import '../../features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';
import '../../features/welcome_message/bloc/welcome_message_cubit/welcome_message_cubit.dart';
import '../../features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import '../util/firebase_analytics_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  sl.registerLazySingleton(() => AnalyticService());

  sl.registerLazySingleton(() => RoomsCubit());
  sl.registerLazySingleton(() => UsersCubit());
  sl.registerLazySingleton(() => OpenRoomCubit());
  sl.registerFactory(() => MessagesCubit());

  //endregion

  //region auth
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => LogoutCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => RefreshTokenCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => DeleteAccountCubit());
  sl.registerFactory(() => OtpPasswordCubit());
  sl.registerFactory(() => LoginSocialCubit());
  sl.registerFactory(() => SurveyCubit());
  sl.registerFactory(() => ApplyCubit());
  sl.registerFactory(() => CouponCubit());

  //endregion

  // region Appointments
  sl.registerFactory(() => BookedAppointmentsCubit());
  sl.registerFactory(() => AvailableTimesCubit());
  sl.registerFactory(() => CreateSessionCubit());
  sl.registerFactory(() => CreateBundleCubit());
  sl.registerFactory(() => AddTimeCubit());
  sl.registerFactory(() => RemoveTimeCubit());
  sl.registerFactory(() => RatingCubit());

  //endregion

  //region Trainer

  sl.registerFactory(() => TrainerCubit());
  sl.registerFactory(() => TrainersCubit());

  //endregion
  //region payments
  sl.registerFactory(() => WalletCubit());
  sl.registerFactory(() => PaymentsCubit());
  //endregion

  //region plans
  sl.registerFactory(() => TrainerPlansCubit());
  sl.registerFactory(() => PlanCubit());
  sl.registerFactory(() => PlansCubit());
  sl.registerFactory(() => SubscribePlanCubit());
  sl.registerFactory(() => PlanWorkoutsCubit());
  sl.registerFactory(() => AddFavoriteCubit());
  sl.registerFactory(() => BookmarkedCubit());
  sl.registerFactory(() => ActivePlansCubit());
  sl.registerFactory(() => FreePlansCubit());

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

  //region Governors

  //endregion

  //region product

  //endregion

  //region colors

  //endregion

  //region manufacturers

  //endregion

  //region WelcomeMessage
  sl.registerFactory(() => WelcomeMessageCubit());
  sl.registerFactory(() => WelcomeMessagesCubit());
  //endregion

  //region TrainerFiles
  sl.registerFactory(() => TrainerFilesCubit());
  sl.registerFactory(() => CreateTrainerFileCubit());
  sl.registerFactory(() => DeleteTrainerFileCubit());
  //endregion

  //region TrainingCubit
  sl.registerFactory(() => TrainingCubit());
  sl.registerFactory(() => ExercisesCubit());
  //endregion

  //region VimeoCubit
  sl.registerFactory(() => VimeoCubit());

  //endregion

  //region Diet
  sl.registerFactory(() => DietCubit());
  sl.registerFactory(() => DietsCubit());
  sl.registerFactory(() => CreateDietCubit());
  sl.registerFactory(() => DeleteDietCubit());
  //endregion

  //region Search
  sl.registerFactory(() => SearchCubit());
  //endregion

//! External
}
