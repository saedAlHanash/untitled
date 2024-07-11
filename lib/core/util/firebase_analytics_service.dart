import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fitness_storm/core/app/app_provider.dart';

import '../../features/appointments/data/request/create_bundle_request.dart';
import '../../features/auth/data/request/signup_request.dart';
import '../../features/auth/data/response/login_response.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../features/trainer/data/response/trainer.dart';

class FirebaseAnalyticService {
  final analytics = FirebaseAnalytics.instance;

  Future<void> initUser({required Profile user}) async {
    analytics.setUserId(id: user.id.toString());
    initSurvey(survey: user.fitnessSurvey);
    if (user.email!.isNotEmpty) {
      analytics.setUserProperty(name: "email", value: user.email);
    }
    if (user.mobile!.isNotEmpty) {
      analytics.setUserProperty(name: "phone", value: user.mobile);
    }
    if (user.name!.isNotEmpty) {
      analytics.setUserProperty(name: "fullName", value: user.name);
    }
    if (user.gender!.isNotEmpty) {
      analytics.setUserProperty(name: "gender", value: user.gender);
    }
    if (user.birthDate != null) {
      analytics.setUserProperty(
          name: "date_of_birth",
          value: user.birthDate?.toUtc().toIso8601String());
    }
  }

  Future<void> initSurvey({required FitnessSurvey survey}) async {
    if (survey.weight != 0) {
      analytics.setUserProperty(
          name: "weight", value: survey.weight.toString());
    }
    if (survey.height != 0) {
      analytics.setUserProperty(
          name: "height", value: survey.height.toString());
    }
    if (survey.dailyExercise != 0) {
      analytics.setUserProperty(
          name: "daily_exercise", value: survey.dailyExercise.toString());
    }
    if (survey.weeklyExercise != 0) {
      analytics.setUserProperty(
          name: "weekly_exercise", value: survey.weeklyExercise.toString());
    }
    if (survey.trainingGoal!.isNotEmpty) {
      analytics.setUserProperty(
          name: "training_goal", value: survey.trainingGoal);
    }
    if (survey.preferredWorkoutLocationId!.isNotEmpty) {
      analytics.setUserProperty(
          name: "preferred_location", value: survey.preferredWorkoutLocationId);
    }
    if (survey.trainingLevelId!.isNotEmpty) {
      analytics.setUserProperty(
          name: "training_level_id", value: survey.trainingLevelId);
    }
  }

  Future<void> signup({required SignupRequest request}) async {
    await analytics.logSignUp(
      signUpMethod: 'email_and_password',
      parameters: {
        'email': request.phoneOrEmail ?? '',
        'name': request.name ?? '',
      },
    );
  }

  Future<void> login(
      {required LoginData data, required String loginMethod}) async {
    await analytics.logLogin(
      loginMethod: loginMethod,
      parameters: {
        'user_id': data.id,
        'is_first_time': data.isFirstTime.toString(),
        'is_confirmed': data.isConfirmed.toString(),
        'user_type': AppProvider.isTrainer ? 'trainer' : 'user',
      },
    );
  }

  Future<void> logout() async {
    await analytics.logEvent(
      name: 'logout',
    );
  }

  Future<void> trainingSessionView(
      {required TrainerModel trainer, required int numberOfAvailable}) async {
    await analytics.logEvent(
      name: 'training_available',
      parameters: {
        'trainer_id': trainer.id,
        'trainer_name': trainer.name,
        'number_of_available': numberOfAvailable.toString(),
      },
    );
  }

  Future<void> trainingProfileView({required TrainerModel trainer}) async {
    await analytics.logEvent(
      name: 'training_profile_view',
      parameters: {
        'trainer_id': trainer.id,
        'trainer_name': trainer.name,
      },
    );
  }

  Future<void> contactTrainerOrUser(
      {required String name, required String method}) async {
    await analytics.logEvent(
      name: AppProvider.isTrainer
          ? 'trainer_contact_user'
          : 'user_contact_trainer',
      parameters: {
        'method': method,
        AppProvider.isTrainer ? 'trainer_name' : 'user_name': name,
      },
    );
  }

  Future<void> bookSession({required CreateBundleRequest request}) async {
    await analytics.logAddToCart(currency: 'SAR');
    await analytics.logEvent(
      name: 'book_sessions',
      parameters: {
        'bundle_name': request.bundle?.name ?? '',
        'trainer_name': request.bundle?.trainer.name ?? '',
        'trainer_id': request.bundle?.trainer.id ?? '',
        'times_count': request.timeIds.length,
      },
    );
  }

  Future<void> checkoutStart() async {
    await analytics.logBeginCheckout(
      currency: 'SAR',
    );
  }

  Future<void> receivedNotification({required type}) async {
    await analytics
        .logEvent(name: 'received_notification', parameters: {'type': type});
  }

  Future<void> initialApp() async {
    await analytics.logAppOpen();
  }

  Future<void> screenView({required String name}) async {
    await analytics.logScreenView(screenName: name);
  }
}
