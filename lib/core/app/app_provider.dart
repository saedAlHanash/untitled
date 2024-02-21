import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/data/response/login_response.dart';

import '../../features/profile/data/response/profile_response.dart';
import '../util/shared_preferences.dart';

class AppProvider {
  static LoginData _loginData = AppSharedPreference.loginDate;

  static UserType _userType = AppSharedPreference.getUserType;

  static Profile _profile = AppSharedPreference.profile;

  static int get myId => _loginData.id;

  static Profile get profile => _profile;

  static String get token {
    return _loginData.accessToken;
  }
  static String get refreshToken {
    return _loginData.refreshToken;
  }

  static bool get isConfirmed => _loginData.isConfirmed;

  static bool get isFirstTime => _loginData.isFirstTime;

  static bool get isTrainer => _userType == UserType.trainer;

  static _setLoginData() {
    _loginData = AppSharedPreference.loginDate;
    _userType = AppSharedPreference.getUserType;
  }

  static cashLoginData(LoginData data, {required bool isTrainer}) async {
    await AppSharedPreference.cashLoginData(data);

    if (isTrainer ) {
      await AppSharedPreference.cashUserType(UserType.trainer);
    } else {
      await AppSharedPreference.cashUserType(UserType.user);
    }

    _setLoginData();
  }

  static cashProfile(Profile data, {bool? isTrainer}) async {
    await AppSharedPreference.cashProfile(data);
    _profile = data;
  }

  static cashSetConfirmAccount() async {
    await AppSharedPreference.cashLoginData(_loginData.copyWith(isConfirmed: true));
    _setLoginData();
  }

  static Future<void> logout() async {
    await AppSharedPreference.logout();
    _loginData = AppSharedPreference.loginDate;
  }

}

class AppControl {
  //التحكم في إظهار وإخفاء زر تسجيل الدخول ب غوغل
  static bool get hideGoogleBtn => DateTime.now().isAfter(DateTime(2025, 1, 18));

  static bool get isAppleAccount => AppProvider.myId == 262;
}
