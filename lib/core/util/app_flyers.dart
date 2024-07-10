// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
// import 'package:fitness_storm/core/app/app_provider.dart';
//
// import '../../features/appointments/data/request/create_bundle_request.dart';
// import '../../features/auth/data/request/signup_request.dart';
// import '../../features/auth/data/response/login_response.dart';
// import '../../features/profile/data/response/profile_response.dart';
// import '../../features/trainer/data/response/trainer.dart';
// import '../api_manager/api_service.dart';
//
// class AppFlyerAnalyticService {
//
//   final appsFlyerOptions = AppsFlyerOptions(
//     afDevKey: 'kdSh9oEtSmmaVtcn3Drtzf',
//     appId: '6463420120',
//     showDebug: true,
//     timeToWaitForATTUserAuthorization: 50,
//     // for iOS 14.5
//     disableAdvertisingIdentifier: false,
//     // Optional field
//     disableCollectASA: false,
//     //Optional field
//     manualStart: true,
//   ); // Optional field
//
//   Future<AppsflyerSdk> initialAppFlyer() async {
//
//     final appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
//
//     await appsflyerSdk.initSdk(
//       registerConversionDataCallback: true,
//       registerOnAppOpenAttributionCallback: true,
//       registerOnDeepLinkingCallback: true,
//     );
//     appsflyerSdk.startSDK(
//       onSuccess: () {
//         loggerObject.f("AppsFlyer SDK initialized successfully.");
//       },
//       onError: (int errorCode, String errorMessage) {
//         loggerObject.e(
//             "Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage");
//       },
//     );
//     return appsflyerSdk;
//   }
//
//   Future<void> initUser({required Profile user}) async {
//     appsFlyerOptions.setUserId(id: user.id.toString());
//     initSurvey(survey: user.fitnessSurvey);
//     if (user.email!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(name: "email", value: user.email);
//     }
//     if (user.mobile!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(name: "phone", value: user.mobile);
//     }
//     if (user.name!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(name: "fullName", value: user.name);
//     }
//     if (user.gender!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(name: "gender", value: user.gender);
//     }
//     if (user.birthDate != null) {
//       appsFlyerOptions.setUserProperty(
//           name: "date_of_birth",
//           value: user.birthDate?.toUtc().toIso8601String());
//     }
//   }
//
//   Future<void> initSurvey({required FitnessSurvey survey}) async {
//     if (survey.weight != 0) {
//       appsFlyerOptions.setUserProperty(
//           name: "weight", value: survey.weight.toString());
//     }
//     if (survey.height != 0) {
//       appsFlyerOptions.setUserProperty(
//           name: "height", value: survey.height.toString());
//     }
//     if (survey.dailyExercise != 0) {
//       appsFlyerOptions.setUserProperty(
//           name: "daily_exercise", value: survey.dailyExercise.toString());
//     }
//     if (survey.weeklyExercise != 0) {
//       appsFlyerOptions.setUserProperty(
//           name: "weekly_exercise", value: survey.weeklyExercise.toString());
//     }
//     if (survey.trainingGoal!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(
//           name: "training_goal", value: survey.trainingGoal);
//     }
//     if (survey.preferredWorkoutLocationId!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(
//           name: "preferred_workout_location_id",
//           value: survey.preferredWorkoutLocationId);
//     }
//     if (survey.trainingLevelId!.isNotEmpty) {
//       appsFlyerOptions.setUserProperty(
//           name: "training_level_id", value: survey.trainingLevelId);
//     }
//   }
//
//   Future<void> signup({required SignupRequest request}) async {
//     await appsFlyerOptions.logSignUp(
//       signUpMethod: 'email_and_password',
//       parameters: {
//         'email': request.phoneOrEmail,
//         'name': request.name,
//       },
//     );
//   }
//
//   Future<void> login(
//       {required LoginData data, required String loginMethod}) async {
//     await appsFlyerOptions.logLogin(
//       loginMethod: loginMethod,
//       parameters: {
//         'user_id': data.id,
//         'is_first_time': data.isFirstTime.toString(),
//         'is_confirmed': data.isConfirmed.toString(),
//         'user_type': AppProvider.isTrainer ? 'trainer' : 'user',
//       },
//     );
//   }
//
//   Future<void> logout() async {
//     await appsFlyerOptions.logEvent(
//       name: 'logout',
//     );
//   }
//
//   Future<void> trainingSessionView(
//       {required TrainerModel trainer, required int numberOfAvailable}) async {
//     await appsFlyerOptions.logEvent(
//       name: 'training_available_times_view',
//       parameters: {
//         'trainer_id': trainer.id,
//         'trainer_name': trainer.name,
//         'number_of_available': numberOfAvailable.toString(),
//       },
//     );
//   }
//
//   Future<void> trainingProfileView({required TrainerModel trainer}) async {
//     await appsFlyerOptions.logEvent(
//       name: 'training_profile_view',
//       parameters: {
//         'trainer_id': trainer.id,
//         'trainer_name': trainer.name,
//       },
//     );
//   }
//
//   Future<void> contactTrainerOrUser(
//       {required String name, required String method}) async {
//     await appsFlyerOptions.logEvent(
//       name: AppProvider.isTrainer
//           ? 'trainer_contact_user'
//           : 'user_contact_trainer',
//       parameters: {
//         'method': method,
//         AppProvider.isTrainer ? 'trainer_name' : 'user_name': name,
//       },
//     );
//   }
//
//   Future<void> bookSession({required CreateBundleRequest request}) async {
//     await appsFlyerOptions.logAddToCart(currency: 'SAR');
//     await appsFlyerOptions.logEvent(
//       name: 'book_sessions',
//       parameters: {
//         'bundle_name': request.bundle?.name,
//         'trainer_name': request.bundle?.trainer.name,
//         'trainer_id': request.bundle?.trainer.id,
//         'times_count': request.timeIds.length,
//       },
//     );
//   }
//
//   Future<void> checkoutStart() async {
//     await appsFlyerOptions.logBeginCheckout(
//       currency: 'SAR',
//     );
//   }
//
//   Future<void> receivedNotification({required type}) async {
//     await analytics
//         .logEvent(name: 'received_notification', parameters: {'type': type});
//   }
//
//   Future<void> initialApp() async {
//     await appsFlyerOptions.logAppOpen();
//   }
//
//   Future<void> screenView({required String name}) async {
//     await appsFlyerOptions.logScreenView(screenName: name);
//   }
// }
