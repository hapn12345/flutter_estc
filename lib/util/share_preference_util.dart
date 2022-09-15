import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const LANGUAGE_CODE_ID = "LANGUAGE_CODE_ID";
  static const ACCOUNT_LIST_ID = "ACCOUNT_LIST_ID";

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
    var languageCode = _prefs.getString(LANGUAGE_CODE_ID);
    return languageCode ?? 'en';
  }

  Future<void> setLanguageCode(String languageCode) async {
    _prefs.setString(LANGUAGE_CODE_ID, languageCode);
  }

  Future<List<String>> getAccountList() async {
    var accountList = _prefs.getStringList(ACCOUNT_LIST_ID);
    return accountList ?? <String>['Admin', 'User1', 'User2', 'User3'];
  }

  Future<void> setAccountList(List<String> accountList) async {
    _prefs.setStringList(ACCOUNT_LIST_ID, accountList);
  }
}
