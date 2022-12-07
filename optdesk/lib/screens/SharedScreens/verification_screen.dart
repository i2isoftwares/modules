import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';

import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseEmailVerification.dart';
import 'package:optdesk/models/ResponseUserRegistrationSignin.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../api/network_utils.dart';

class VerificationScreen extends StatefulWidget {
  final Map<String, String> data;

  VerificationScreen({required this.data});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String pin = '';

  void _resendOtpTap(BuildContext context) async {

    Utils.showLoader(context);
    UserRegistrationSignin response =
    await postForgetPasswordSignIn(widget.data['email']!,context);
    showToastMsg(response.message);
    if (response.status) {
      this.pin = response.returnData;
      widget.data['token'] = response.id;
    }
//    if (widget.data.containsKey('isFromRegister')) {
//      if (widget.data.containsKey('isEmailConfirmation')) {
//        Utils.showLoader(context);
//        EmailVerification response =
//            await postEmailVerification(widget.data['email'], '0');
//        showToastMsg(response.message);
//        if (response.status) {
//          this.pin = response.returnData;
//        }
//      } else {
//        String userName =
//            '${widget.data['firstName']} ${widget.data['lastName']}';
//        EmailVerification response =
//            await postOtpRequest(widget.data['mobile'], userName);
//        showToastMsg(response.message);
//        if (response.status) {
//          this.pin = response.returnData;
//        }
//      }
//    } else {
//      EmailVerification response =
//          await postEmailVerification(widget.data['email'], '1');
//      showToastMsg(response.message);
//      if (response.status) {
//        this.pin = response.returnData;
//      }
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'Verification',
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
          child: SizedBox(
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
                    color: Colors.transparent,
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
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: OTPTextField(
                                length: 6,
                                onChanged: (v){},
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 30,
                                fieldStyle: FieldStyle.underline,
                                style: const TextStyle(fontSize: 17),
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                  if (pin == widget.data['pin'] ||
                                  pin == this.pin) {
                                    Navigator.of(context).pushNamed(
                                        '/password_reset_screen',
                                        arguments: widget.data);
                                  }else{
                                    showToastMsg(
                                          'OTP not valid');
                                  }

//                                  if (widget.data
//                                      .containsKey('isFromRegister')) {
//                                    if (pin == widget.data['pin'] ||
//                                        pin == this.pin) {
////                                      if (widget.data.containsKey(
////                                          'isEmailConfirmation')) {
////                                        Navigator.of(context).pushNamed(
////                                            '/password_reset_screen',
////                                            arguments: widget.data);
////                                      }else{
////                                        Navigator.of(context).pushNamed(
////                                            '/forgot_password',
////                                            arguments: widget.data);
////                                      }
//                                      Navigator.of(context).pushNamed(
//                                          '/password_reset_screen',
//                                          arguments: widget.data);
//                                    } else {
//                                      showToastMsg(
//                                          'OTP not valid');
//                                    }
//                                  } else {
//                                    if (pin == widget.data['pin'] ||
//                                        pin == this.pin) {
//                                      Navigator.of(context).pushNamed(
//                                          '/password_reset_screen',
//                                          arguments: widget.data);
//                                    } else {
//                                      showToastMsg(
//                                          'OTP not valid');
//                                    }
//                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 17),
                            ElevatedButton(
                              onPressed: () {
                                _resendOtpTap(context);
                              },
                              // color: Colors.white,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: new BorderRadius.circular(10.0),
                              //   side: const BorderSide(
                              //     color: primary,
                              //     width: 2,
                              //   ),
                              // ),
                              child: Text(
                                'Resend OTP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                              ),
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
