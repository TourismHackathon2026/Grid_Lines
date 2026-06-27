import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  bool getBool(String key) => _prefs.getBool(key) ?? false;

  Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  // App specific keys
  static const String isLoggedIn = 'is_logged_in';
  static const String userId = 'user_id';
  static const String userToken = 'user_token';
  static const String isDarkMode = 'is_dark_mode';
  static const String isFirstLaunch = 'is_first_launch';
  static const String languageCode = 'language_code';
}
