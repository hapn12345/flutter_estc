import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const languageCodeId = "LANGUAGE_CODE_ID";
  static const accoutListId = "ACCOUNT_LIST_ID";
  static const keyToken = "KEY_TOKEN";
  static const fcmToken = "FCM_TOKEN";

  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  factory SharedPreferenceUtil() {
    return _instance;
  }

  SharedPreferenceUtil._internal();

  static late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> getLanguageCode() async {
    var languageCode = _prefs.getString(languageCodeId);
    return languageCode ?? 'en';
  }

  Future<void> setLanguageCode(String languageCode) async {
    _prefs.setString(languageCodeId, languageCode);
  }

  Future<List<String>> getAccountList() async {
    var accountList = _prefs.getStringList(accoutListId);
    return accountList ?? <String>['Admin', 'User1', 'User2', 'User3'];
  }

  Future<void> setAccountList(List<String> accountList) async {
    _prefs.setStringList(accoutListId, accountList);
  }

  Future<dynamic> setToken(String token) async {
    _prefs.setString(keyToken, token);
  }

  String getToken() {
    var token = _prefs.getString(keyToken);
    return token ?? '';
  }

  Future<void> setFcmToken(String token) async {
    _prefs.setString(fcmToken, token);
  }

  Future<String> getFcmToken() async {
    var token = _prefs.getString(fcmToken);
    return token ?? '';
  }
}
