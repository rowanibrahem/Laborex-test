import 'package:secure_shared_preferences/secure_shared_preferences.dart';

class LocalRepo {
  final SecureSharedPref secureSharedPreferences;

  LocalRepo({required this.secureSharedPreferences});

  Future<void> addToken(String token) async {
  final  result = await secureSharedPreferences.putString('token', token, isEncrypted: true);
  result;
  }

  Future<void> deleteToken() async {
    await secureSharedPreferences.clearAll();
  }

  Future<void> changeToken(String newToken) async {

    await secureSharedPreferences.putString('token', newToken,
        isEncrypted: true);
  }

  Future<String?> getToken() async {
   final token = await secureSharedPreferences.getString('token', isEncrypted: true);
   return token;}
}
