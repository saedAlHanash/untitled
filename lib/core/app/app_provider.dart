import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/data/response/login_response.dart';

import '../util/shared_preferences.dart';

class AppProvider {
  static var _loginData = AppSharedPreference.loginDate;

  static var _userType = AppSharedPreference.getUserType;

  static int get myId => _loginData.id;

  static String get token {

    return _loginData.accessToken;
  }

  static bool get isConfirmed => _loginData.isConfirmed;

  static bool get isFirstTime => _loginData.isFirstTime;

  static bool get isTrainer => _userType == UserType.trainer;

  static _setLoginData() {
    _loginData = AppSharedPreference.loginDate;
    _userType = AppSharedPreference.getUserType;
  }

  static cashLoginData(LoginData data, {bool? isTrainer}) async {
    await AppSharedPreference.cashLoginData(data);
    if (isTrainer != null) {
      await AppSharedPreference.cashUserType(UserType.trainer);
    }
    _setLoginData();
  }

  static cashSetConfirmAccount() async {
    await AppSharedPreference.cashLoginData(_loginData.copyWith(isConfirmed: true));
    _setLoginData();
  }
}

class AppControl {
  //التحكم في إظهار وإخفاء زر تسجيل الدخول ب غوغل
  static bool get hideGoogleBtn => DateTime.now().isAfter(DateTime(2025, 1, 18));

  static bool get isAppleAccount => AppProvider.myId == 262;
}
