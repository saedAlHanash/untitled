import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
    AppSharedPreference.init(_pref!);
  }

  static Future<void> clearData() async => await _pref?.clear();

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _pref!.setString(key, value);
    if (value is int) return await _pref!.setInt(key, value);
    if (value is bool) return await _pref!.setBool(key, value);
    return await _pref!.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return _pref!.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _pref!.remove(key);
  }
}
