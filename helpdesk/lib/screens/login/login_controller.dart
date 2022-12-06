import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helpdesk/api/helpdesk_api_calls.dart';
import 'package:helpdesk/helpers/strings.dart';
import 'package:helpdesk/model/login_response.dart';
import 'package:helpdesk/routes/hd_app_routes.dart';
import 'package:i2iutils/helpers/common_functions.dart';

class LoginController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  String userEmail = '';
  String password = '';
  String? fcmToken;

  @override
  void onInit() {
    super.onInit();
    userEmail = _box.read(USER_EMAIL);
    password = _box.read(USER_PASSWORD);
    fcmToken = _box.read(USER_TOKEN);
    checkLogin();
  }

  checkLogin() async {
    if (await isNetConnected()) {
      try {
        LoginResponse? response =
            await HelpdeskApiCall().checkLogin(userEmail, password);

        if (response == null) {
          showToastMsg('Something went wrong');
          return;
        }

        if (!(response.status ?? false)) {
          showToastMsg(response.message ?? '');
          return;
        }

        response.companydetails?.forEach((element) {
          if (element.company != null) {
            element.company =
                element.company!.substring(0, element.company!.indexOf('('));
          }
        });

        bool isB2c = false;
        if (response.locationdetails?.isNotEmpty ?? false) {
          isB2c = response.locationdetails?.first.business2Consumer ?? false;
        }

        _box.write(IS_LOGIN, true);

        _box.write(USER_ID, response.userID);
        _box.write(LOGO, response.logopath);
        _box.write(EMP_EMAIL, response.emailID);
        _box.write(EMP_PHONE, response.contactNo);
        _box.write(EMP_NAME, response.firstName);
        _box.write(COMP_NAME, response.companyName);
        _box.write(EMP_ID, response.requestorID);
        _box.write(GROUP_ID, response.groupID);
        _box.write(COMP_ID, response.companyID);
        _box.write(ROLE_ID, response.roleID);
        _box.write(IS_ADMIN, response.isAdmin);
        _box.write(IS_SA, response.isSuperAdmin);
        _box.write(IS_SE, response.isServiceEngineer);
        _box.write(IS_EMP, response.isEmployee);
        _box.write(IS_TENENT, response.isTenant);
        _box.write(IS_B2C, isB2c);
        _box.write(COMP_LIST, jsonEncode(response.companydetails ?? []));
        _box.write(LOC_LIST, jsonEncode(response.locationdetails ?? []));
        _box.write(BUILDING_LIST, jsonEncode(response.buildingdetails ?? []));
        _box.write(FLOOR_LIST, jsonEncode(response.floordetails ?? []));
        _box.write(WING_LIST, jsonEncode(response.wingdetails ?? []));

        if (fcmToken != null) {
          HelpdeskApiCall().updateToken({
            'userid': response.userID,
            'notificationid': fcmToken,
          });
        }

        if (isB2c) {
          Get.offAndToNamed(HDRoutes.B2C_HOME, arguments: true);
        } else {
          Get.offAndToNamed(HDRoutes.HOME, arguments: true);
        }
      } catch (e) {
        //ignored
      }
    }
  }
}
