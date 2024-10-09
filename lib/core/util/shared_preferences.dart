import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _toScreen = '4';
  static const _myId = '12';
  static const _lang = '14';
  static const _loginData = '19';
  static const _profile = '0';
  static const _notificationsRead = '20';
  static const _isLoginToChatApp = '_23';
  static const _currentPlan = '22';
  static const _email = 'email';
  static const _isShowIntro = 'isShowIntro';

  static SharedPreferences? _prefs;

  static init(SharedPreferences preferences) async {
    _prefs = preferences;
  }

  static cashLoginToChatApp(bool b) {
    _prefs?.setBool(_isLoginToChatApp, b);
  }

  static bool get getIsLoginToChatApp => _prefs?.getBool(_isLoginToChatApp) ?? false;

  static serCurrentPlanId(String b) async {
    await _prefs?.setString(_currentPlan, b);
  }

  static String get getCurrentPlanId => _prefs?.getString(_currentPlan) ?? '';

  static int get getNotificationsRead => _prefs?.getInt(_notificationsRead) ?? 0;

  static Future<void> setNotificationsRead(int n) async =>
      await _prefs?.setInt(_notificationsRead, n);


  static cashUserType(UserType? userType) async {
    if (userType == null) return;
    await _prefs?.setInt(_toScreen, userType.index);
  }

  static UserType get getUserType {
    final index = _prefs?.getInt(_toScreen) ?? 0;
    return UserType.values[index];
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }

  static Future<void> logout() async {
    await _prefs?.clear();
  }

  static Future<void> cashMyId(int? id) async {
    if (id == null || id == 0) return;
    await _prefs?.setInt(_myId, id);
  }

  static int get getMyId => _prefs?.getInt(_myId) ?? 0;

  static Future<void> cashLocal(String langCode) async {
    _prefs?.setString(_lang, langCode);
  }

  static String get getLocal => _prefs?.getString(_lang) ?? 'ar';

  static cashLoginData(LoginData loginData) async {
    await _prefs?.setString(_loginData, jsonEncode(loginData.toJson()));
  }

  static LoginData get getLoginDate {
    return LoginData.fromJson(jsonDecode(_prefs?.getString(_loginData) ?? '{}'));
  }

  static Future<void> cashProfile(Profile profile) async {
    await _prefs?.setString(_profile, jsonEncode(profile));
  }

  static Profile get profile {
    return Profile.fromJson(jsonDecode(_prefs?.getString(_profile) ?? '{}'));
  }

  static Future<void> cacheEmail(String? email, EmailType type) async {
    _prefs?.setString(_email, '${type.index}_${email ?? ''}');
  }

  static Future<void> removeEmail() async => _prefs?.remove(_email);

  static String get getRestPassEmail {
    final data = _prefs?.getString(_email) ?? '0_';

    final list = data.split('_');

    if (list.firstOrNull != '${EmailType.password.index}' ||
        list.lastOrNull == null ||
        list.last.isEmpty) {
      return '';
    }

    return list.last;
  }

  static String get getConfirmEmail {
    final data = _prefs?.getString(_email) ?? '0_';

    final list = data.split('_');

    if (list.firstOrNull != '${EmailType.confirm.index}' ||
        list.lastOrNull == null ||
        list.last.isEmpty) {
      return '';
    }

    return list.last;
  }

 static bool get haveConfirm => getRestPassEmail.isNotEmpty || getConfirmEmail.isNotEmpty;

  static Future<void> cashShowIntro() async {
    await _prefs?.setBool(_isShowIntro, true);
  }

  static bool get isShowIntro {
    return _prefs?.getBool(_isShowIntro) ?? false;
  }
}
