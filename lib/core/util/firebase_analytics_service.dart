// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/models/plan_model.dart';

import '../../features/appointments/data/request/create_bundle_request.dart';
import '../../features/appointments/data/response/bundles_response.dart';
import '../../features/auth/data/request/signup_request.dart';
import '../../features/auth/data/response/login_response.dart';
import '../../features/coupon/data/request/pay_request.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../features/trainer/data/response/trainer.dart';

class AnalyticService {
  // final appsflyer = AppsflyerSdk(AppsFlyerOptions(
  //   afDevKey: 'kdSh9oEtSmmaVtcn3Drtzf',
  //   appId: '6463420120',
  //   showDebug: true,
  //   timeToWaitForATTUserAuthorization: 50,
  //   // for iOS 14.5
  //   disableAdvertisingIdentifier: false,
  //   // Optional field
  //   disableCollectASA: false,
  //   //Optional field
  //   manualStart: true,
  // ));

  Future<void> initialAppFlyer() async {
    // await appsflyer.initSdk(
    //   registerConversionDataCallback: true,
    //   registerOnAppOpenAttributionCallback: true,
    //   registerOnDeepLinkingCallback: true,
    // );
    //
    // appsflyer.startSDK(
    //   onSuccess: () {
    //     loggerObject.f("AppsFlyer SDK initialized successfully.");
    //   },
    //   onError: (int errorCode, String errorMessage) {
    //     loggerObject.e(
    //         "Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage");
    //   },
    // );
  }

  final analytics = FirebaseAnalytics.instance;

  Future<void> initUser({required Profile user}) async {
    analytics.setUserId(id: user.id.toString());
    initSurvey(survey: user.fitnessSurvey);
    // appsflyer.setCustomerUserId(user.id?.toString() ?? '');

    if (user.email!.isNotEmpty) {
      analytics.setUserProperty(name: "email", value: user.email);
      // appsflyer.setUserEmails([user.email!]);
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
    // appsflyer.setAdditionalData({
    //   'Sign_Up': {
    //     'email': request.phoneOrEmail ?? '',
    //     'name': request.name ?? '',
    //   }
    // });
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

    // appsflyer.setAdditionalData({
    //   'Login': {
    //     'User_Id': data.id,
    //     'Is_First_Time': data.isFirstTime.toString(),
    //     'Is_Confirmed': data.isConfirmed.toString(),
    //     'User_Type': AppProvider.isTrainer ? 'trainer' : 'user',
    //   }
    // });
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

  Future<void> startCheckoutBundle({required Bundle bundle}) async {
    // appsflyer.setCurrencyCode('SAR');
    // appsflyer.setAdditionalData({
    //   'Start_Checkout': {
    //     'Bundle_Id': bundle.id,
    //     'Bundle_Name': bundle.name,
    //     'Bundle_Price': bundle.price,
    //   }
    // });
  }

  Future<void> addToWishlist({required String id}) async {
    // appsflyer.setAdditionalData({
    //   'Add_To_Wishlist': {'plan_Id': id}
    // });
  }

  Future<void> startCheckout({required CreateSubscriptionRequest request}) async {
    // appsflyer.setCurrencyCode('SAR');
    // appsflyer.setAdditionalData({'Start_Checkout': request.toJson()});
  }

  Future<void> checkoutStart() async {
    await analytics.logBeginCheckout(currency: 'SAR');
  }

  Future<void> receivedNotification({required type}) async {
    await analytics
        .logEvent(name: 'received_notification', parameters: {'type': type});
  }

  Future<void> initialApp() async {
    await analytics.logAppOpen();
    // appsflyer.setAdditionalData({'App_Open': {}});
  }

  Future<void> screenView({required String name}) async {
    try {
      await analytics.logScreenView(screenName: name);
      // appsflyer.setAdditionalData({'View_Content': name});
    } catch (e) {
      loggerObject.e(e);
    }
  }

  void subscribePlan(Plan plan) {
    // appsflyer.setAdditionalData({
    //   'Subscribe': {
    //     'Plan_Id': plan.id,
    //     'Plan_Name': plan.name,
    //   }
    // });
  }

  void subscribeApp(Plan plan) {
    // appsflyer.setAdditionalData({
    //   'Subscribe': {
    //     'Plan_Id': plan.id,
    //     'Plan_Name': plan.name,
    //   }
    // });
  }
}
