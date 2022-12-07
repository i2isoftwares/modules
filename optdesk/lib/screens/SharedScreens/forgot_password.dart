import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';

import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseUserRegistrationSignin.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';
import 'package:optdesk/widgets/textfield.dart';

import '../../api/network_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final Map<String, String>? data;

  ForgotPasswordScreen({this.data});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  void _submitTap(BuildContext context) async {
    if (emailController.text.trim().isNotEmpty) {
      Utils.showLoader(context);
      UserRegistrationSignin response =
          await postForgetPasswordSignIn(emailController.text,context);
      showToastMsg(response.message);
      if (response.status) {
        Map<String, String> data = {
          'pin': response.returnData.toString(),
          'email': emailController.text.trim(),
          'token': response.id,
        };
        Navigator.of(context).pushNamed('/verification', arguments: data);
      }
//      if (widget.data != null) {
//        Utils.showLoader(context);
//        UserRegistrationSignin response =
//            await postForgetPasswordSignIn(emailController.text);
//        showToastMsg(response.message);
//        if (response.status) {
//          Map<String, String> newData = widget.data;
//          newData.addAll({
//            'pin': response.returnData.toString(),
//            'email': '${emailController.text.trim()}',
//          });
//          Navigator.of(context).pushNamed('/verification', arguments: newData);
//        }
//      } else {
//        Utils.showLoader(context);
//        EmailVerification response =
//            await postEmailVerification(emailController.text, '1');
//        showToastMsg(response.message);
//        if (response.status) {
//          Map<String, String> data = {
//            'pin': '${response.returnData.toString()}',
//            'email': '${emailController.text.trim()}'
//          };
//          Navigator.of(context).pushNamed('/verification', arguments: data);
//        }
//      }
    } else {
      showToastMsg('Please enter email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          widget.data != null ? 'Register Account' : 'Forgot Password',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
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
                              placeholder: "Email ID",
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
                            const SizedBox(height: 24),
                            CustomButton(
                              buttonText: 'SUBMIT',
                              onPressed: () {
                                _submitTap(context);
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
