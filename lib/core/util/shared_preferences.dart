import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _restPassEmail = '3';
  static const _toScreen = '4';
  static const _policy = '5';

  static const _fireToken = '8';
  static const _notificationCount = '9';
  static const _social = '10';
  static const _activeNoti = '11';
  static const _myId = '12';
  static const _cart = '13';
  static const _lang = '14';
  static const _phoneNumberPassword = '15';
  static const _otpPassword = '16';
  static const _currency = '17';
  static const _loginData = '19';
  static const _profile = '0';
  static const _latestRefreshToken = '20';

  static late SharedPreferences _prefs;

  static init(SharedPreferences preferences) async {
    _prefs = preferences;
  }

  static cashToken(String? token) async {
    if (token == null) return;
    await _prefs.setString(_token, token);
  }

  static String get getToken {
    return _prefs.getString(_token) ?? '';
  }

  static cashRestPassEmail(String? email) async {
    if (email == null) return;
    await _prefs.setString(_restPassEmail, email);
  }

  static String get getRestPassEmail {
    return _prefs.getString(_restPassEmail) ?? '';
  }

  static cashPhoneOrEmailPassword(String? phone) async {
    if (phone == null) return;
    await _prefs.setString(_phoneNumberPassword, phone);
  }

  static String get getPhoneOrEmailPassword {
    return _prefs.getString(_phoneNumberPassword) ?? '';
  }

  static cashOtpPassword(String? otp) async {
    if (otp == null) return;
    await _prefs.setString(_otpPassword, otp);
  }

  static String get getOtpPassword {
    return _prefs.getString(_otpPassword) ?? '';
  }

  static Future<void> removePhoneOrEmail() async {
    await _prefs.remove(_phoneNumberPassword);
    await _prefs.remove(_otpPassword);
  }

  static cashUserType(UserType appState) async {
    await _prefs.setInt(_toScreen, appState.index);
  }

  static UserType get getUserType {
    final index = _prefs.getInt(_toScreen) ?? 0;
    return UserType.values[index];
  }

  static bool isAcceptPolicy() {
    return _prefs.getBool(_policy) ?? false;
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> logout() async {
    await _prefs.clear();
  }

  static bool get isLogin => getToken.isNotEmpty;

  static void cashFireToken(String token) {
    _prefs.setString(_fireToken, token);
  }

  static String getFireToken() {
    return _prefs.getString(_fireToken) ?? '';
  }

  static void addNotificationCount() {
    var count = getNotificationCount() + 1;
    _prefs.setInt(_notificationCount, count);
  }

  static int getNotificationCount() {
    return _prefs.getInt(_notificationCount) ?? 0;
  }

  static void clearNotificationCount() {
    _prefs.setInt(_notificationCount, 0);
  }

  static bool isCachedSocial() {
    return (_prefs.getString(_social) ?? '').length > 10;
  }

  static void cashActiveNotification(bool val) {
    _prefs.setBool(_activeNoti, val);
  }

  static bool getActiveNotification() {
    return _prefs.getBool(_activeNoti) ?? true;
  }

  static void cashMyId(int id) {
    _prefs.setInt(_myId, id);
  }

  static void updateCart(List<String> jsonCart) {
    _prefs.setStringList(_cart, jsonCart);
  }

  static List<String> getJsonListCart() => _prefs.getStringList(_cart) ?? <String>[];

  static int get getMyId => _prefs.getInt(_myId) ?? 0;

  static void cashLocal(String langCode) {
    _prefs.setString(_lang, langCode);
  }

  static String get getLocal => _prefs.getString(_lang) ?? 'ar';

  static void cashLatestRefreshToken() {
    _prefs.setString(_latestRefreshToken, DateTime.now().toIso8601String());
  }

  static DateTime get getLatestRefreshToken {
    final stringDate = _prefs.getString(_latestRefreshToken);
    return DateTime.tryParse(stringDate.toString()) ??
        DateTime.now().copyWith(year: DateTime.now().year - 1);
  }

  static set setCurrency(String langCode) => _prefs.setString(_currency, langCode);

  static String get currency => _prefs.getString(_currency) ?? '\$';

  static cashLoginData(LoginData loginData) async {
    await _prefs.setString(_loginData, jsonEncode(loginData.toJson()));
  }

  static LoginData get loginDate {
    return LoginData.fromJson(jsonDecode(_prefs.getString(_loginData) ?? '{}'));
  }

  static cashProfile(Profile profile) async {
    await _prefs.setString(_profile, jsonEncode(profile.toJson()));
  }

  static Profile get profile {
    return Profile.fromJson(jsonDecode(_prefs.getString(_profile) ?? '{}'));
  }
}
