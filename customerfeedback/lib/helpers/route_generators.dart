/*
import 'package:customerfeedback/screens/categoryscreen.dart';
import 'package:customerfeedback/screens/downloadscreen.dart';
import 'package:customerfeedback/screens/offlinedatascreen.dart';
import 'package:customerfeedback/screens/otpverifyscreen.dart';
import 'package:customerfeedback/screens/questionscreen.dart';
import 'package:customerfeedback/screens/submitscreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/scorescreen.dart';
// import '../screens/splashscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, context) {
    final args = settings.arguments;
    switch (settings.name) {

      case '/cf/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );

      case '/cf/download':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const DownloadScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/home':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const HomeScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/category':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: CategoryScreen(data: args as Map<String, String>),
            type: PageTransitionType.rightToLeft);

      case '/cf/question':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const QuestionScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/score':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const ScoreScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/otp':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const OTPVerifyScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/submit':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const SubmitScreen(),
            type: PageTransitionType.rightToLeft);

      case '/cf/offline':
        return PageTransition(
          // duration: const Duration(seconds: 1),
            child: const OfflineDataScreen(),
            type: PageTransitionType.rightToLeft);
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
*/
