import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/widgets/button.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: primary,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'AWESOME',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.white)
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your Booking has been Successfully Confirmed. Check your email for more details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.white)
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      onPressed: (){
                        Navigator.of(context).popUntil((route) {
                          return route.settings.name == '/home';
                        });
                      },
                      smallText: true,
                      buttonText: 'OK',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
