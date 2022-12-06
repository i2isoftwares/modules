import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:vms/helper/vms_session.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/login_response.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';

class LoginController extends GetxController {
  final box=GetStorage();
  RxBool isClient = false.obs;

  String email='',password='',token='';

  @override
  Future<void> onInit() async {
    super.onInit();

    email = box.read(VMSSession.USEREMAIL) ?? '';
    password = box.read(VMSSession.USERPASS) ?? '';
    token = box.read(VMSSession.fcmToken) ?? '';
    checkLogin();
  }

  checkLogin() async {
    Get.focusScope?.unfocus();

    if (isClient.value) {
      var response = await getClientLoginDetails(
          email, password, token);
      if (response == null) {
        hideLoader();
        return showToastMsg('Something went wrong');
      }

      if (!response['status']) {
        hideLoader();
        return showToastMsg(response['message']);
      }

      box.write(VMSSession.ISCLIENTLOGIN, true);
      box.write(VMSSession.ISLOGIN, false);

      box.write(
          VMSSession.USERID, response['result'][0]['Tenantloginid']);
      box.write(
          VMSSession.TENENTID, '${response['result'][0]['Tenantid']}');
      box.write(
          VMSSession.COMPID, '${response['result'][0]['companyId']}');
      box.write(
          VMSSession.LOCID, '${response['result'][0]['locationId']}');
      box.write(VMSSession.COMP, response['result'][0]['Tenantname']);
      box.write(VMSSession.COMP_LOGO,
          "https://ifazility.com/static/logo-company-snowaski.com/Android/${response['result'][0]['companyId']}.png");

      hideLoader();
      Get.offAndToNamed(VMSRoutes.CLIENT_VISITOR_VIEW);
    } else {
      LoginResponse? response = await getLoginDetails(
          email, password, token);
      if (response == null) {
        hideLoader();
        return showToastMsg('Something went wrong');
      }

      if (!response.status) {
        hideLoader();
        return showToastMsg(response.message);
      }

      box.write(VMSSession.ISLOGIN, true);
      box.write(VMSSession.ISCLIENTLOGIN, false);

      box.write(VMSSession.USERID, response.result[0].UserID);
      box.write(
          VMSSession.COMPID, response.result[0].companyId.toString());
      box.write(
          VMSSession.LOCID, response.result[0].locationId.toString());
      box.write(VMSSession.COMP, response.result[0].companyName);
      box.write(VMSSession.LOC, response.result[0].locationName);
      box.write(VMSSession.COMP_LOGO,
          "https://ifazility.com/static/logo-company-snowaski.com/Android/${response.result[0].companyId}.png");

      hideLoader();
      Get.offAndToNamed(VMSRoutes.HOME);
    }
  }

}
