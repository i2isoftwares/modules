import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/network_utils.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseEmailVerification.dart';
import 'package:optdesk/widgets/shared/app_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerificationForSignInScreen extends StatefulWidget {
  final Map<String, String> data;

  VerificationForSignInScreen({@required this.data});

  @override
  _VerificationForSignInScreenState createState() => _VerificationForSignInScreenState();
}

class _VerificationForSignInScreenState extends State<VerificationForSignInScreen> {
  String pin = '';

  void _resendOtpTap(BuildContext context) async {
    Utils.showLoader(context);
    EmailVerification resGetOTP =
    await getOtpForSignIn(widget.data['email'], context);
    if(resGetOTP.status){
      this.pin = resGetOTP.returnData;
    }
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
              .apply(color: primary)
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
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                            .apply(color: Colors.black)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Please enter OTP sent to domain email',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .apply(color: Colors.black)
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
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
                                style: TextStyle(fontSize: 17),
                                onCompleted: (pin) async {
                                  print("Completed: " + pin + widget.data['pin']);
                                  if (pin == widget.data['pin'] ||
                                      pin == this.pin) {
                                    Utils.showLoader(context);
                                    EmailVerification response =
                                        await getInsertSignIn(widget.data['email'], widget.data['userId'], widget.data['roleId'], context);
                                    if(response.status){
                                      SharedPreferencesHelper.setPrefBool(
                                          SharedPreferencesHelper.IS_LOGIN, true);
                                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                                      Utils.showToastMsg(response.message, context);
                                    }else{
                                      Utils.showToastMsg(response.message, context);
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 17),
                            RaisedButton(
                              onPressed: () {
                                _resendOtpTap(context);
                              },
                              color: Colors.white,
                              child: Text(
                                'Resend OTP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: primary,
                                  width: 2,
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
