import 'package:face_authentication/face/verify/face_verify.dart';
import 'package:get/route_manager.dart';
import '../face/register/face_register.dart';
import 'app_pages.dart';

class FRAppRoutes {
  static final routes = [

    GetPage(
      name: FRRoutes.register,
      page: () => FaceRegister(),
    ),
    GetPage(
      name: FRRoutes.verify,
      page: () => FaceVerify(),
    ),

  ];
}
