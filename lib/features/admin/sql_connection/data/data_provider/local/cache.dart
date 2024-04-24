import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCache {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putString(
      {required CacheKeys key, required String value}) async {
    return await preferences?.setString(key.name, value);
  }

  static dynamic? getString({
    required dynamic key,
  }) {
    return preferences?.getString(
      key.name,
    ) ??
        '';
  }

  static void putBoolean(
      {required CacheKeys key, required bool value}) async {
    await preferences?.setBool(key.name, value);
  }

  static bool getBoolean({
    required bool defaultValue,
    required CacheKeys key,
  }) {
    return preferences?.getBool(
      key.name,
    ) ??
        defaultValue;
  }

  static void putInt({required CacheKeys key, required int value}) async {
    await preferences?.setInt(key.name, value);
  }

  static int getInt({
    required CacheKeys key,
  }) {
    return preferences?.getInt(
      key.name,
    ) ??
        0;
  }

  static void putDouble(
      {required CacheKeys key, required double value}) async {
    await preferences?.setDouble(key.name, value);
  }

  static double getDouble({
    required CacheKeys key,
  }) {
    return preferences?.getDouble(
      key.name,
    ) ??
        0.0;
  }

  static Future<void> removeFromShared({
    required CacheKeys key,
  }) async {
    await preferences?.remove(key.name);
  }

  static Future<void> clearShared() async {
    await preferences?.clear();
  }
}