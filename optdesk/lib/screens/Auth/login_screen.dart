import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/network_utils.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseEmailVerification.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/widgets/shared/button.dart';
import 'package:optdesk/widgets/shared/textfield.dart';

import '../../helpers/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRememberMeSelected = true;

  late ResponseLogin resLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.USER_EMAIL, '')
        .then((value) => {
              if (value != '' && value != null) {emailController.text = value}
            });
    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.USER_PASSWORD, '')
        .then((value) => {
              if (value != '' && value != null)
                {passwordController.text = value}
            });
  }

  void _signInWithEmailAndPassword(BuildContext context) async {
    Utils.showLoader(context);
    FocusScope.of(context).unfocus();
    ResponseLogin response =
        await getLoginDetail(emailController.text, passwordController.text, context);
    if (response.returnData.userDetails != null) {
      resLogin = response;
      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.LOGIN_RESPONSE,
          responseLoginToJson(response));
      Utils.responseLogin = response;
      Utils.userDetail = response.returnData.userDetails[0];
      print(response.returnData.userDetails[0].DepartmentID);
      print(response.returnData.userDetails[0].DepartmentName);

      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.DEPARTMENTID, response.returnData.userDetails[0].DepartmentID.toString());
      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.DEPARTMENTNAME, response.returnData.userDetails[0].DepartmentName);
      if (isRememberMeSelected) {
        SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_EMAIL, emailController.text);
        SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_PASSWORD, passwordController.text);
      } else {
        SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_EMAIL, '');
        SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.USER_PASSWORD, '');
      }

      if(response.isOTP == "0"){
        SharedPreferencesHelper.setPrefBool(
            SharedPreferencesHelper.IS_LOGIN, true);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        Utils.showToastMsg(response.message, context);
      }else{
        Utils.showLoader(context);
        EmailVerification resGetOTP =
        await getOtpForSignIn(resLogin.returnData.userDetails[0].emailId, context);
        if(resGetOTP.status){
          Map<String, String> data = {
            'pin': resGetOTP.returnData.toString(),
            'email': '${emailController.text.trim()}',
            'userId': resLogin.returnData.userDetails[0].userId.toString(),
            'roleId': resLogin.returnData.userDetails[0].roleformshowid.toString(),
          };
          print(resGetOTP.returnData.toString());
          Navigator.of(context).pushNamed('/verification_for_sign_in', arguments: data);
        }else{
          Utils.showToastMsg(resGetOTP.message, context);
        }
      }
      Utils.hideLoader();

//      if(resLogin.isshow == "1"){
//        Navigator.of(context).pushNamed('/covid_screen');
//      }else if (resLogin.isshow == "-1"){
//        Utils.showContactAdminDialog(context);
//      }else if (resLogin.isshow == "0"){
//        SharedPreferencesHelper.setPrefBool(
//            SharedPreferencesHelper.IS_LOGIN, true);
//        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
//        Utils.showToastMsg(response.message, context);
//      }
    } else {
      Utils.showToastMsg(response.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => {
          FocusScope.of(context).requestFocus(new FocusNode()),
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/optdesk/banner.png',
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                transform: Matrix4.translationValues(0, -10, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      transform: Matrix4.translationValues(0, -15, 0),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/optdesk/logo-8.png',
                        height: 65,
                        width: 65,
                      ),
                    ),
                    Text(
                      'optDesk',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.black)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            placeholder: "User name/Email ID",
                            //validator: (text) => ValidationUtils.validateEmail(text),
                            controller: emailController,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/username-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            placeholder: "Password",
                            controller: passwordController,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/password-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                            obscureText: true,
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: isRememberMeSelected,
                                      activeColor: primary,
                                      onChanged: (val) {
                                        setState(() {
                                          isRememberMeSelected = val!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isRememberMeSelected =
                                              !isRememberMeSelected;
                                        });
                                      },
                                      child: Text(
                                        'Remember me',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgot_password');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 7),
                                    child: AutoSizeText(
                                      'Forgot password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(fontSize: 13),
                                      maxLines: 1,
                                      minFontSize: 7,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          CustomButton(
                            buttonText: 'LOGIN',
                            onPressed: () =>
                                this._signInWithEmailAndPassword(context),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Register a  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register1');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'New Account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.apply(color: primary)
                                          .copyWith(fontSize: 13),
                                    ),
                                    Container(
                                      color: primary,
                                      height: 1,
                                      width: 100,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Version 2.1',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 12),
                          ),
                          Text(
                            'Release Date: 7-Jan-2022',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 12),
                          ),
                          Text(
                            'www.ifazig.com',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 12),
                          ),
//                            Text(
//                              '©2020. All rights reserved.',
//                              style: Theme.of(context)
//                                  .textTheme
//                                  .bodyText1
//                                  .copyWith(fontSize: 12),
//                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
