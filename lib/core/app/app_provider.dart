import 'dart:async';
import 'dart:io';

import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/data/response/login_response.dart';
import 'package:fitness_storm/services/chat_service/chat_service_core.dart';

import '../../Utils/utils.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../strings/app_color_manager.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';
import 'app_widget.dart';

class AppProvider {
  static LoginData _loginData = AppSharedPreference.loginDate;

  static UserType _userType = AppSharedPreference.getUserType;

  static Profile _profile = AppSharedPreference.profile;

  static SettingResult _systemParams = SettingResult.fromJson([]);

  static int _myId = 0;

  static int get myId {
    if (_myId == 0) _myId = _loginData.id;
    return _myId;
  }

  // static Profile get profile => _profile ;

  static Profile get profile => _profile;

  static SettingResult get systemParams => _systemParams;

  static String get token {
    return _loginData.accessToken;
  }

  static String get refreshToken {
    return _loginData.refreshToken;
  }

  static bool get isConfirmed => _loginData.isConfirmed;

  static bool get isFirstTime => _loginData.isFirstTime;

  static bool get isTrainer => _userType == UserType.trainer;

  static bool get isGuest => _userType == UserType.guest;

  static _setLoginData() {
    _loginData = AppSharedPreference.loginDate;
    _userType = AppSharedPreference.getUserType;
  }

  static cashLoginData(LoginData data, {UserType? userType}) async {
    await AppSharedPreference.cashLoginData(data);
    if (userType != null) {
      await AppSharedPreference.cashUserType(userType);
    }

    _setLoginData();
  }

  static cashProfile(Profile data) async {
    await AppSharedPreference.cashProfile(data);
    _profile = data;

    await ChatServiceCore.updateChatUser();
  }

  static cashSetting(
    SettingResult data,
  ) async {
    _systemParams = data;
  }

  static cashSetConfirmAccount() async {
    await AppSharedPreference.cashLoginData(
        _loginData.copyWith(isConfirmed: true));
    _setLoginData();
  }

  static Future<void> logout() async {
    await AppSharedPreference.logout();

    _loginData = AppSharedPreference.loginDate;
    await ChatServiceCore.logoutChatUser();
    _myId = 0;
    startLogin();
  }

  static void showLoginDialog() {
    NoteMessage.showCheckDialog(
      ctx!,
      text: S.of(ctx!).needLogin,
      textButton: S.of(ctx!).login,
      image: Assets.imagesLogo,
      color: AppColorManager.mainColor,
      onConfirm: () {
        AppSharedPreference.logout();
        startLogin();
      },
    );
  }
}

class AppControl {
  //التحكم في إظهار وإخفاء زر تسجيل الدخول ب غوغل
  static bool get hideGoogleBtn =>
      Platform.isIOS &&
      AppProvider.systemParams.isIosTest &&
      (AppProvider.systemParams.buildNumber >
          AppProvider.systemParams.minAppleVersion);

  static bool get isAppleAccount => AppProvider.myId == 262;
}
