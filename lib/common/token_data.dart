import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/common/shared_pref_key.dart';

//setting access token
Future<void> setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(SharedPrefKey.bearerToken, token);
}

//getting access token
Future<String?> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(SharedPrefKey.bearerToken);
}

//getting refresh token
Future<String?> getRefreshToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(SharedPrefKey.refreshToken);
}

//setting refresh token
Future<void> setRefreshToken(String? token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(SharedPrefKey.refreshToken, token!);
}

//setting remember me
Future<void> setRememberMe(bool? session) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool(SharedPrefKey.rememberMe, session!);
}

//get remember me session
Future<bool?> getRememberMe() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool(SharedPrefKey.rememberMe);
}
