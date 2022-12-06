import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/dashboard_detail_response.dart';
import 'package:vms/networks/api_calls.dart';

import '../../helper/vms_session.dart';
import '../../routes/vms_app_routes.dart';

class DashboardController extends GetxController {
  var item = Get.arguments;
  RxBool isLoading = false.obs;
  RxList list = RxList();
  List<DashboardDetail> tempList = [];
  var searchController = TextEditingController();
  final box=GetStorage();

  @override
  void onInit() async {
    super.onInit();
    getDashDetails();
  }

  getDashDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await getDashboardDetail(item['companyId'],
          item['locationId'], item['gateId'], '${item['id']}');
      if (response != null) {
        if (response.status) {
          if (response.result != null && response.result!.isNotEmpty) {
            list(response.result!);
            tempList = response.result!;
          }
        }
      }
      isLoading(false);
    }
  }

  viewPass(String passlink) async {
    if (!await launchUrlString(
      passlink,
    )) {
      showToastMsg("Can't open pass");
    }
  }

  resend(DashboardDetail detail) async {
    bool? res = await showAlert(
        'are you sure you want to  resend sms to ${detail.firstname}',
        '',
        'Resend');
    if (res != null && res) {
      if (await isNetConnected()) {
        showLoader(title: 'Resend SMS');
        var response = await resendSms('${detail.customerspecid}',
            detail.barcoded, detail.phoneno, detail.firstname);
        if (response != null) {
          if (response['status']) {
            showToastMsg('Sms Send Successfully');
          } else {
            showToastMsg('${response['message']}');
          }
        }
        hideLoader();
      }
    }
  }

  void filterList() {
    try {
      String q = searchController.text.toLowerCase();
      if (q.isNotEmpty && tempList.isNotEmpty) {
        list(tempList
            .where((element) =>
                (element.firstname.contains(q)) ||
                (element.phoneno.contains(q)))
            .toList());
      } else {
        list(tempList);
      }
    } catch (e) {
      print(e);
      list(tempList);
    }
  }

  scanEntry(String barcode) async {
    if (await isNetConnected()) {
      showLoader();
      //api call
      var response = await getClientVisitorDetails(
        barcode,
      );
      hideLoader();
      if (response != null) {
        if (response.status!) {
          if ((response.returnData?.locationID ?? -1) ==
              int.parse(box.read(VMSSession.LOCID) ?? '-1')) {
            response.returnData?.qRCode = barcode;
            // go to show screen
            Get.toNamed(VMSRoutes.VISITOR_VIEW, arguments: response.returnData);
          } else {
            showToastMsg('Invalid Location');
          }
        } else {
          showToastMsg(response.message!);
        }
      }
    }
  }
}
