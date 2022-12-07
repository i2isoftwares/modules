import 'package:get/get.dart';
import 'package:optdesk/screens/Auth/register_screen1.dart';
import 'package:optdesk/screens/SharedScreens/forgot_password.dart';
import 'package:optdesk/screens/SharedScreens/password_reset_screen.dart';
import 'package:optdesk/screens/SharedScreens/verification_for_signin_screen.dart';
import 'package:optdesk/screens/SharedScreens/verification_screen.dart';
import 'package:optdesk/screens/booking_details_screen.dart';
import 'package:optdesk/screens/calender_screen.dart';
import 'package:optdesk/screens/cancelled_bookings_screen.dart';
import 'package:optdesk/screens/covid_screen.dart';
import 'package:optdesk/screens/faqs_screen.dart';
import 'package:optdesk/screens/my_bookings_screen.dart';
import 'package:optdesk/screens/time_selection_screen.dart';
import 'package:optdesk/screens/view_floor_map_screen.dart';
import 'package:optdesk/screens/workstation_screen.dart';

import '../screens/Auth/login_screen.dart';
import '../screens/confirmation_screen.dart';
import '../screens/home_screen.dart';
import 'app_pages.dart';

class CFAppRoutes {
  static final routes = [

    GetPage(
      name: CFRoutes.login,
      page: () => LoginScreen(),
    ),
      GetPage(
      name: CFRoutes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: CFRoutes.forgotpwd,
      page: () => ForgotPasswordScreen(data: Get.arguments as Map<String, String>),
    ),
    GetPage(
      name: CFRoutes.register,
      page: () => RegisterScreen1(),
    ),
    GetPage(
      name: CFRoutes.verification,
      page: () => VerificationScreen(data: Get.arguments as Map<String, String>),
    ),
    GetPage(
      name: CFRoutes.verificationsignin,
      page: () => VerificationForSignInScreen(data: Get.arguments as Map<String, String>),
    ),
    GetPage(
      name: CFRoutes.bookingconfirmation,
      page: () => ConfirmationScreen(),
    ),
    GetPage(
      name: CFRoutes.timeselection,
      page: () => TimeSelectionScreen(events: Get.arguments,),
    ),
    GetPage(
      name: CFRoutes.workstation,
      page: () => WorkstationScreen(data: Get.arguments,),
    ),
    GetPage(
      name: CFRoutes.calenderscreen,
      page: () => CalenderScreen(),
    ),
    GetPage(
      name: CFRoutes.mybookingsscreen,
      page: () => MyBookings(),
    ),
    GetPage(
      name: CFRoutes.cancelledbookingsscreen,
      page: () => CancelledBookings(),
    ),
    GetPage(
      name: CFRoutes.passwordresetscreen,
      page: () => PasswordResetScreen(data: Get.arguments as Map<String, String>),
    ),
    GetPage(
      name: CFRoutes.bookingdetailscreen,
      page: () => BookingDetails(data: Get.arguments,),
    ),
    GetPage(
      name: CFRoutes.faqsscreen,
      page: () => FAQsScreen(),
    ),
    GetPage(
      name: CFRoutes.covidscreen,
      page: () => CovidScreen(companyId: Get.arguments),
    ),
    GetPage(
      name: CFRoutes.viewfloormapscreen,
      page: () => ViewFloorMapScreen(data: Get.arguments,),
    ),
  ];

}
