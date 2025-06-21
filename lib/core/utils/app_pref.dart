import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_me_with_you/core/utils/language_manger.dart';

const String googleApiKey = "googleApiKey";
const String userToken = "user_token";
const String onBoarding = "onBoarding";
const String prefsLang = "language";
const String fullNamePrefs = 'full_name_key';
const String phoneNumberPrefs = 'phone_number';
const String userId = 'user_id';
const String userPassword = 'user_password';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserToken(
      String token, String fullName, String phoneNumber, int id) async {
    await _sharedPreferences.setString(userToken, token);
    await _sharedPreferences.setString(fullNamePrefs, fullName);
    await _sharedPreferences.setString(phoneNumberPrefs, phoneNumber);
    await _sharedPreferences.setInt(userId, id);
  }

  String? getUserToken() {
    print('user token  :   ${_sharedPreferences.getString(userToken)}');

    return _sharedPreferences.getString(userToken);
  }

  String? getUserName() {
    return _sharedPreferences.getString(fullNamePrefs);
  }

  int? getUserId() {
    return _sharedPreferences.getInt(userId);
  }

  String? getUserPhoneNumber() {
    return _sharedPreferences.getString(phoneNumberPrefs);
  }

  Future<bool> removeUserToken() {
    return _sharedPreferences.remove(userToken);
  }

  Future<void> setOnBoarding() async {
    await _sharedPreferences.setBool(onBoarding, true);
  }

  bool? getOnBoarding() {
    return _sharedPreferences.getBool(onBoarding);
  }

  Future<void> setGoogleMapKey(String value) async {
    await _sharedPreferences.setString(googleApiKey, value);
  }

  String? getGoogleMapKey() {
    return _sharedPreferences.getString(googleApiKey);
  }

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(prefsLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.arabic.getValue();
    }
  }

  Future<Locale> getLocale() async {
    String? currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<void> setUserPassword(String password) async {
    await _sharedPreferences.setString(userPassword, password);
  }

  String? getUserPassword() {
    return _sharedPreferences.getString(userPassword);
  }
}
