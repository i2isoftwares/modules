import 'package:customerfeedback/screens/downloadscreen.dart';
import 'package:get/route_manager.dart';

import '../screens/categoryscreen.dart';
import '../screens/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/offlinedatascreen.dart';
import '../screens/otpverifyscreen.dart';
import '../screens/questionscreen.dart';
import '../screens/scorescreen.dart';
import '../screens/submitscreen.dart';
import 'app_pages.dart';

class CFAppRoutes {
  static final routes = [

    GetPage(
      name: CFRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: CFRoutes.download,
      page: () => DownloadScreen(),
    ),
    GetPage(
      name: CFRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: CFRoutes.category,
      page: () => CategoryScreen(data: Get.arguments as Map<String, String>),
    ),
    GetPage(
      name: CFRoutes.question,
      page: () => const QuestionScreen(),
    ),
    GetPage(
      name: CFRoutes.score,
      page: () => const ScoreScreen(),
    ),
    GetPage(
      name: CFRoutes.otp,
      page: () => const OTPVerifyScreen(),
    ),
    GetPage(
      name: CFRoutes.submit,
      page: () => const SubmitScreen(),
    ),
    GetPage(
      name: CFRoutes.offline,
      page: () => const OfflineDataScreen(),
    ),
  ];
}
