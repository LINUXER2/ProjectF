import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static SharedPreferences? _prefs;

  Config._();

  static Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String get(String key, [String defValue = ""]) {
    String? res = _prefs?.getString(key);
    return res ?? defValue;
  }

  static int getInt(String key, [int defValue = 0]) {
    int? res = _prefs?.getInt(key);
    return res ?? defValue;
  }

  static bool getBool(String key, [bool defValue = false]) {
    bool? res = _prefs?.getBool(key);
    return res ?? defValue;
  }

  static Future<bool> set(String key, String value) {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  static Future<bool> setInt(String key, int value) {
    return _prefs?.setInt(key, value) ?? Future.value(false);
  }

  static Future<bool> setBool(String key, bool value) {
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  static delete(String key) {
    _prefs?.remove(key);
  }
}
