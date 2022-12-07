import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseUserRegistrationSignin.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';
import 'package:optdesk/widgets/textfield.dart';

import '../../api/network_utils.dart';

class RegisterScreen1 extends StatefulWidget {
  @override
  _RegisterScreen1State createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _submitTap(BuildContext context) async{
    if(fNameController.text.trim().isNotEmpty && lNameController.text.trim().isNotEmpty && mobileController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty){

      // if(ValidationUtils.validateEmail(emailController.text)){
        Utils.showLoader(context);
        UserRegistrationSignin response = await postUserRegistrationSignin(fNameController.text, lNameController.text, mobileController.text, emailController.text,context);
        showToastMsg(response.message);
        if(response.status){
          Map<String, String> data = {
            'pin': response.returnData.toString(),
            'email': emailController.text.trim(),
            'firstName': fNameController.text.trim(),
            'lastName': lNameController.text.trim(),
            'mobile': mobileController.text.trim(),
            'token': response.id,
            'isFromRegister': 'true',
          };
          Navigator.of(context).pushNamed('/verification', arguments: data);
        }
      }else{
        showToastMsg('Invalid Email');
      }


    // }else{
    //   showToastMsg('Please enter details');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'New User Registration',
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
                              placeholder: "First Name",
                              controller: fNameController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/optdesk/username-8.png',
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              placeholder: "Last Name",
                              controller: lNameController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/optdesk/username-8.png',
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              placeholder: "Email ID",
                              controller: emailController,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              placeholder: "Mobile Number",
                              controller: mobileController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/optdesk/password-8.png',
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
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Do you have account?  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).popUntil((route) {
                                      return route.settings.name == '/login';
                                    });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1?.apply(color: primary)
                                            .copyWith(fontSize: 13),
                                      ),
                                      Container(color: primary, height: 1, width: 50,)
                                    ],
                                  ),
                                ),
                              ],
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
