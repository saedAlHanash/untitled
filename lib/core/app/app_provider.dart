import 'dart:async';
import 'dart:io';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/auth/data/response/login_response.dart';
import 'package:fitness_storm/services/chat_service/chat_service_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';
import '../../features/profile/bloc/profile_cubit/profile_cubit.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../strings/app_color_manager.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';
import 'app_widget.dart';

class AppProvider {
  static LoginData _loginData = AppSharedPreference.getLoginDate;

  static UserType _userType = AppSharedPreference.getUserType;

  static Profile profile = AppSharedPreference.profile;

  static SettingResult systemParams = SettingResult.fromJson([]);

  //region user and auth

  static int? _myId;

  static bool get isTestMode => baseUrl == test;

  static bool isAr = Get.locale?.languageCode == 'ar';

  static String get myId {
    if (_myId == 0) _myId = _loginData.id;
    if (_myId == 0 || _myId == null) _myId = AppSharedPreference.getMyId;
    return _myId == 0 ? '' : '${AppProvider.isTestMode ? 'test' : ''}${_myId.toString()}';
  }

  static String get token {
    return _loginData.accessToken;
  }

  static bool get isLogin => token.isNotEmpty && (isConfirmed || isTrainer);

  static String get refreshToken {
    return _loginData.refreshToken;
  }

  static bool get isConfirmed => _loginData.isConfirmed;

  static bool get isTrainer => _userType == UserType.trainer;

  static bool get isGuest => _userType == UserType.guest;

  //endregion

  static _refreshLoginData() {
    _loginData = AppSharedPreference.getLoginDate;
    _userType = AppSharedPreference.getUserType;
  }

  static cashLoginData(LoginData data,
      {UserType? userType, bool refreshToken = false}) async {
    await AppSharedPreference.cashMyId(data.id);
    await AppSharedPreference.cashLoginData(data);
    await AppSharedPreference.cashUserType(userType);
    if (!refreshToken && data.isConfirmed) {
      ctx!.read<ProfileCubit>().getProfile(newData: true);
    }
    _refreshLoginData();
  }

  static Future<void> cashProfile(Profile data) async {
    await AppSharedPreference.cashProfile(data);

    await AppSharedPreference.cashMyId(data.id);

    profile = data;

    await ChatServiceCore.updateChatUser(data);
  }

  static confirmAccountInCache() async {
    await AppSharedPreference.cashLoginData(_loginData.copyWith(isConfirmed: true));
    await AppSharedPreference.removeEmail();
    _refreshLoginData();
  }

  static Future<void> logout() async {
    await AppSharedPreference.logout();
    _loginData = AppSharedPreference.getLoginDate;
    await ChatServiceCore.logoutChatUser();
    _myId = null;
    startLogin();
  }

  static void showLoginDialog() {
    NoteMessage.showCheckDialog(
      ctx!,
      text: S.of(ctx!).needLogin,
      textButton: S.of(ctx!).login,
      image: Assets.imagesLogo,
      color: AppColorManager.mainColor,
      onConfirm: (b) {
        if (!b) return;
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
      (AppProvider.systemParams.buildNumber > AppProvider.systemParams.minAppleVersion);

  static bool get isAppleAccount => AppSharedPreference.getMyId == 262;
}
