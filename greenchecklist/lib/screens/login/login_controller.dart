import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greenchecklist/api/api_calls.dart';
import 'package:greenchecklist/database/dao/user_dao.dart';
import 'package:greenchecklist/database/database.dart';
import 'package:greenchecklist/helpers/gc_session.dart';
import 'package:greenchecklist/model/user_response.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import '../../routes/gc_app_pages.dart';

class LoginController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  String userEmail='';
  String password='';

  @override
  void onInit() {
    super.onInit();
    userEmail=_box.read(GCSession.userEmail);
    password=_box.read(GCSession.userPassword);
    checkLogin();
  }

  checkLogin() async {
    //check storage permissions
      isLoading(true);

      var userDao = UserDao(Get.find<GCAppDb>());
      String token = _box.read(GCSession.appToken) ?? '';
      var userId = _box.read(GCSession.userId);

      //check database user already login offline
      var user = await userDao.getUser(userEmail, password);

      if (user != null && token.isNotEmpty) {
        //add session
        applySession(ApiUser(
            user.userID,
            user.CompanyID,
            user.locationID,
            user.companyName,
            user.companylogo,
            user.locationame,
            user.ischecklist,
            user.isadmin,
            user.ishelpdesk,
            user.islogsheet,
            user.name,
            user.emailid,
            user.mobileno,
            user.RoleShortName,
            user.Language,
            user.ProductID,
            user.AppTypes,
            '',
            user.Department,
            token));

        Get.offAndToNamed(GCRoutes.home,arguments: true);
      } else {
        //check internet
        if (await isNetConnected()) {

          if((_box.read(GCSession.key) ?? '').toString().isEmpty){
            String key=(await ApiCall().getSecureKey())['key'];
            _box.write(GCSession.key, key);
          }


          //check offline count and alert user
          var response = await ApiCall().checkLogin(userEmail, password);

          if (response != null) {
            if (response.status) {
              await userDao.deleteUsers();
              await userDao.insertUser(response.result[0],password);

              //unregister token for old user in server

              if (userId != null && token.isNotEmpty) {
                await ApiCall().logout(token, userId);
              }

              //add session
              applySession(response.result[0]);

              Get.offAndToNamed(GCRoutes.download);
            } else {
              //show alert
              showToastMsg(response.message, longToast: true);
            }
          }
        }
      }

      isLoading(false);

  }

  applySession(ApiUser user) {
    _box.write(GCSession.userEmail, user.emailid);
    _box.write(GCSession.userPassword, password);
    _box.write(GCSession.userName, user.name);
    _box.write(GCSession.userId, user.userID);
    _box.write(GCSession.userCompanyLogo,
        user.companylogo.replaceAll("http:", "https:"));
    _box.write(GCSession.userCompanyId, user.companyID);
    _box.write(GCSession.userLocationId, user.locationID);
    _box.write(GCSession.userCompanyName, user.companyName);
    _box.write(GCSession.userLocationName, user.locationame);
    _box.write(GCSession.isChecklist, user.ischecklist);
    _box.write(GCSession.isLogsheet, user.islogsheet);
    _box.write(GCSession.isHelpdesk, user.isHelpdesk);
    _box.write(GCSession.isAdmin, user.isAdmin);
    _box.write(GCSession.appToken, user.token);
    _box.write(GCSession.userDepartments, user.department);
    _box.write(GCSession.isLogin, true);
  }
}
