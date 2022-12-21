

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static const String USER_EMAIL = "user";
  static const String USER_PASSWORD = "cf_USER_PASSWORD";

  static const String IS_LOGIN = "cf_is_login";
  static const String IS_FEEDBACK = "cf_is_feedback";
  static const String COMPANY_LOGO = "comp_logo";
  static const String LOGIN_RESPONSE = "cf_login_response";

  static const String USER_ID = "cf_USER_ID";
  static const String USER_NAME = "cf_USER_NAME";
  static const String COMPANY_ID = "cf_COMPANY_ID";
  static const String COMPANY_NAME = "cf_COMPANY_NAME";
  static const String SBU_ID = "cf_SBU_ID";
  static const String SBU_NAME = "cf_SBU_NAME";
  static const String LOCATION_ID = "cf_LOCATION_ID";
  static const String LOCATION_NAME = "cf_LOCATION_NAME";
  static const String FEEDBACK_ID = "cf_FEEDBACK_ID";
  static const String FEEDBACK_NAME = "cf_FEEDBACK_NAME";
  static const String SECTOR_ID = "cf_SECTOR_ID";
  static const String CATEGORY_ID = "cf_CATEGORY_ID";
  static const String AUDIT_ID = "cf_AUDIT_ID";
  static const String TOTAL_SCORE = "cf_TOTAL_SCORE";
  static const String CATEGORY_NAME = "CATEGORY_NAME";

  static const String SETTING_DETAILS = "cf_SETTING_DETAILS";

  static const String DEPARTMENTID = "cf_DEPARTMENT_ID";
  static const String DEPARTMENTNAME = "cf_DEPARTMENT_NAME";

  static const String selectedCompany = "cf_SelectedCompany";
  static const String selectedLocation = "cf_SelectedLocation";
  static const String selectedBuilding = "cf_SelectedBuilding";
  static const String selectedFloor = "cf_SelectedFloor";



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
