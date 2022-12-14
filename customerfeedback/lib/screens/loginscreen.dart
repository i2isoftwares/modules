import 'package:customerfeedback/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import '../api/customerfeedback_api_call.dart';
import '../database/database_helper.dart';
import '../helpers/shared_preferences_helper.dart';
import '../models/loginresponse.dart';
import '../routes/app_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  void checkAndPush() async {
    await SharedPreferencesHelper.getPrefBool(SharedPreferencesHelper.IS_LOGIN)
        .then((isLoggedIn) {
      if (isLoggedIn) {
        Get.toNamed(CFRoutes.download);
        // Navigator.popAndPushNamed(key.currentContext!, '/cf/home');
      } else {
        api();
      }
    });
  }

  //Get LoginDetails
  void api() async {
    // Utils.showLoader(context);

    //Take the user to login
    var email = Get.arguments['email'];
    var password = Get.arguments['password'];

    Loginresponse? response =
        await CustomerFeedbackApiCall().checkLogin(email, password);
    if (response != null) {
      showToastMsg(response.message);
      if (response.status) {
        // _showConfirmationDialog(context, "\nLogin Successfully");
        DatabaseHelper.instance.userinsert(response.returnData.userDetails);
        await SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_EMAIL,
            response.returnData.userDetails![0].emailID.toString());
        await SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_PASSWORD, password);
        await SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_ID,
            response.returnData.userDetails![0].userID.toString());
        await SharedPreferencesHelper.setPrefBool(
            SharedPreferencesHelper.IS_LOGIN, true);
        await SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_NAME,
            response.returnData.userDetails![0].userFirstName.toString());
        await SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.IS_FEEDBACK,
            response.isfeedback.toString());

        Get.toNamed(CFRoutes.download);

        // Navigator.popAndPushNamed(key.currentContext!, '/cf/download');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils().configLoading();
    checkAndPush();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
