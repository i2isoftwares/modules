

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static const String USER_EMAIL = "USER_EMAIL";
  static const String USER_PASSWORD = "USER_PASSWORD";

  static const String IS_LOGIN = "od_is_login";
  static const String LOGIN_RESPONSE = "od_login_response";
  static const String SETTING_DETAILS = "od_SETTING_DETAILS";
  static const String DEPARTMENTID = "od_DEPARTMENT_ID";
  static const String DEPARTMENTNAME = "od_DEPARTMENT_NAME";
  static const String selectedCompany = "od_SelectedCompany";
  static const String selectedLocation = "od_SelectedLocation";
  static const String selectedBuilding = "od_SelectedBuilding";
  static const String selectedFloor = "od_SelectedFloor";



  static String selectedUser = "";

  static Future<String> getPrefString(String key, String defaultVal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultVal;
  }

  static Future<bool> setPrefString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }


  static Future<bool> getPrefBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setPrefBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> logoutPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
