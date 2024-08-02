import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPref;
  static cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertStringToCache(
      {required String key, required String value}) async {
    return await sharedPref.setString(key, value);
  }

  static Future<String?> getStringCacheData({required String key}) async {
    return sharedPref.getString(key) ?? '';
  }

  static Future<bool> insertIntToCache(
      {required String key, required int value}) async {
    return await sharedPref.setInt(key, value);
  }

  static Future<int?> getIntCacheData({required String key}) async {
    return sharedPref.getInt(key) ?? 0;
  }

  static Future<bool> deleteCacheData({required String key}) async {
    return await sharedPref.remove(key);
  }
}
