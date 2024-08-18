import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api_manager/api_service.dart';
import '../go_route_pages.dart';

class AppSharedPreference {
  static const _metta = '13';

  static SharedPreferences? _prefs;

  static MetaQuery get myMetta {
    final json = _prefs?.getString(_metta) ?? '{}';

    final meta = MetaQuery.fromJson(jsonDecode(json));

    return meta;
  }

  static bool cashMetta(MetaQuery meta) {
    final oldMeta = myMetta;
    var needUpdate = false;
    if (oldMeta.userId != meta.userId ||
        oldMeta.userType != meta.userType ||
        oldMeta.domain != meta.domain ||
        oldMeta.userFcm != meta.userFcm ||
        oldMeta.userToken != meta.userToken) {
      needUpdate = true;
    }
    _prefs?.setString(_metta, jsonEncode(meta.toJson()));
    return needUpdate;
  }

  static init(SharedPreferences preferences) {
    _prefs = preferences;
  }

  static bool isInit() {
    return _prefs != null;
  }

  static void clear() {
    _prefs?.clear();
  }

  static void logout() {
    _prefs?.remove(_metta);
  }

  static Future<void> reload() async => await _prefs?.reload();
}

bool get isAdmin => AppSharedPreference.myMetta.userType == 'a';

bool get isStudent => AppSharedPreference.myMetta.userType == 's';

bool get isTeacher => AppSharedPreference.myMetta.userType == 't';
