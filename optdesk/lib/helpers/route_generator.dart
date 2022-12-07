import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:optdesk/screens/Auth/login_screen.dart';
import 'package:optdesk/screens/Auth/register_screen1.dart';
import 'package:optdesk/screens/SharedScreens/password_reset_screen.dart';
import 'package:optdesk/screens/SharedScreens/verification_for_signin_screen.dart';
import 'package:optdesk/screens/SharedScreens/verification_screen.dart';
import 'package:optdesk/screens/booking_details_screen.dart';
import 'package:optdesk/screens/calender_screen.dart';
import 'package:optdesk/screens/cancelled_bookings_screen.dart';
import 'package:optdesk/screens/confirmation_screen.dart';
import 'package:optdesk/screens/SharedScreens/forgot_password.dart';
import 'package:optdesk/screens/covid_screen.dart';
import 'package:optdesk/screens/faqs_screen.dart';
import 'package:optdesk/screens/home_screen.dart';
import 'package:optdesk/screens/my_bookings_screen.dart';
import 'package:optdesk/screens/splash_screen.dart';
import 'package:optdesk/screens/time_selection_screen.dart';
import 'package:optdesk/screens/view_floor_map_screen.dart';
import 'package:optdesk/screens/workstation_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, context) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return platformPageRoute(
          context: context,
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case '/login':
        return platformPageRoute(
          context: context,
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case '/home':
        return platformPageRoute(
          context: context,
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case '/forgot_password':
        return platformPageRoute(
          context: context,
          builder: (_) => ForgotPasswordScreen(data: args),
          settings: settings,
        );
      case '/register1':
        return platformPageRoute(
          context: context,
          builder: (_) => RegisterScreen1(),
          settings: settings,
        );
      case '/verification':
        return platformPageRoute(
          context: context,
          builder: (_) => VerificationScreen(data: args),
          settings: settings,
        );
      case '/verification_for_sign_in':
        return platformPageRoute(
          context: context,
          builder: (_) => VerificationForSignInScreen(data: args),
          settings: settings,
        );
      case '/booking_confirmation':
        return platformPageRoute(
          context: context,
          builder: (_) => ConfirmationScreen(),
          settings: settings,
        );
      case '/time_selection':
        return platformPageRoute(
          context: context,
          builder: (_) => TimeSelectionScreen(events: args),
          settings: settings,
        );
      case '/workstation':
        return platformPageRoute(
          context: context,
          builder: (_) => WorkstationScreen(data: args),
          settings: settings,
        );
      case '/calender_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => CalenderScreen(),
          settings: settings,
        );
      case '/my_bookings_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => MyBookings(),
          settings: settings,
        );
      case '/cancelled_bookings_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => CancelledBookings(),
          settings: settings,
        );
      case '/password_reset_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => PasswordResetScreen(data: args),
          settings: settings,
        );
      case '/booking_detail_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => BookingDetails(data: args),
          settings: settings,
        );
      case '/faqs_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => FAQsScreen(),
          settings: settings,
        );
      case '/covid_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => CovidScreen(companyId: args),
          settings: settings,
        );
        case '/view_floor_map_screen':
        return platformPageRoute(
          context: context,
          builder: (_) => ViewFloorMapScreen(data: args),
          settings: settings,
        );
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
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