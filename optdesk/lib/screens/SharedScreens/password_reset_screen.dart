import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/models/ResponseUserRegistrationSignin.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';
import 'package:optdesk/widgets/textfield.dart';

import '../../api/network_utils.dart';

class PasswordResetScreen extends StatefulWidget {
  final Map<String, String> data;

  PasswordResetScreen({required this.data});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _resetTap(BuildContext context) async {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text == confirmPasswordController.text) {
        UserRegistrationSignin response = await postSaveRegPassword(
            widget.data['token']!, passwordController.text,context);
        showToastMsg(response.message);
        Future.delayed(const Duration(seconds: 1));
        if (response.status) {
          Navigator.of(context).popUntil((route) {
            return route.settings.name == '/login';
          });
        }
//        if(widget.data.containsKey('isFromRegister')){
//          UserRegistrationSignin response = await postSaveRegPassword(widget.data['token'], passwordController.text);
//          showToastMsg(response.message);
//          Future.delayed(Duration(seconds: 1));
//          if(response.status){
//            Navigator.of(context).popUntil((route) {
//              return route.settings.name == '/login';
//            });
//          }
//        }else{
//          ResetPassword response = await postResetPassword(widget.data['email'], passwordController.text);
//          showToastMsg(response.message);
//          Future.delayed(Duration(seconds: 1));
//          if(response.status){
//            Navigator.of(context).popUntil((route) {
//              return route.settings.name == '/login';
//            });
//          }
//        }
      } else {
        showToastMsg('Password does not match');
      }
    } else {
      showToastMsg('Please enter password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          widget.data.containsKey('isFromRegister')
              ? 'New User Registration'
              : 'Reset Password',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/optdesk/banner.png',
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  transform: Matrix4.translationValues(0, -10, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        transform: Matrix4.translationValues(0, -15, 0),
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
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
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              placeholder: widget.data.isNotEmpty
                                  ? "Password"
                                  : "New Password",
                              obscureText: true,
                              controller: passwordController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/optdesk/username-8.png',
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              onSubmitted: (val) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              placeholder: widget.data.isNotEmpty
                                  ? "Confirm Password"
                                  : "Confirm New Password",
                              obscureText: true,
                              controller: confirmPasswordController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/optdesk/username-8.png',
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              onSubmitted: (val) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            const SizedBox(height: 24),
                            CustomButton(
                              buttonText:
                                  widget.data.isNotEmpty ? 'Submit' : 'Reset',
                              onPressed: () {
                                this._resetTap(context);
                              },
                            ),
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
      ),
    );
  }
}
