import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:i2iutils/widgets/spinner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/company_response.dart';
import 'package:vms/model/location_response.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';

import '../../helper/vms_session.dart';


class HomeController extends GetxController {
  Visitor visitor = Visitor();
  final mobileController = TextEditingController();
  RxList list = RxList();
  final box=GetStorage();

  RxString company = ''.obs;
  RxList<Map<String, String>> companylists = RxList();

  RxString location = ''.obs;
  RxList<Map<String, String>> locationlists = RxList();

  RxString gate = ''.obs;
  RxList<Map<String, String>> gatelists = RxList();

  int _userId = -1;
  RxString compLogo = "".obs;
  RxBool isLoading = false.obs;
  bool canGoBack = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    
    _userId = box.read(VMSSession.USERID) ?? -1;
    compLogo(box.read(VMSSession.COMP_LOGO) ?? "");
    _getCompanyList();
    // checkAppVersion();

    // var newVersion=NewVersion();
    // newVersion.showAlertIfNecessary(context: Get.context!);
  }

/*  checkAppVersion() async {
    if (await isNetConnected()) {
      try {
        var response = await getAppVersion();
        if (response != null && response['vms']!=null) {
          var result = response['vms'];
          int currentVersionCode =
          int.parse((await PackageInfo.fromPlatform()).buildNumber);
          int versionCode = result['versionCode'];
          bool forceUpdate = result['forceUpdate'];
          if (versionCode > currentVersionCode) {
            Get.bottomSheet(
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text(
                        'Update Available!',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Divider(),
                      Text(
                          '${result['message']}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        buttonText: 'Update',
                        onPressed: () {
                          if (Platform.isAndroid) {
                            launchUrlString(
                                '${result['androidUrl']}',
                                mode: LaunchMode.externalApplication);
                          } else {
                            launchUrlString(
                                '${result['iosUrl']}',
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        width: 100,
                        height: 32,
                        smallText: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                enableDrag: !forceUpdate,
                isDismissible: !forceUpdate);
          }
        }
      }catch(e){
        //ignored
      }
    }
  }*/

  _getCompanyList() async {
    if (await isNetConnected()) {
      CompanyResponse? response = await getCompanyDetails(_userId);
      if (response != null && response.status) {
        if (response.result.isNotEmpty) {
          for (CompanyResult company in response.result) {
            companylists.add(
                {'id': '${company.CompanyId}', 'value': company.CompanyName});
          }
          if (box.read(VMSSession.COMP) == null) {
            box.write(
                VMSSession.COMPID, companylists.first['id'].toString());
            box.write(
                VMSSession.COMP, companylists.first['value'].toString());
          }
          company(box.read(VMSSession.COMPID));
          _getLocationList(company.value);
        }
      }
    }
  }

  changeCompany(val) {
    if (val != company.value) {
      company(val);
      box.write(VMSSession.COMPID, val);
      box.write(VMSSession.COMP,
          getMapItem(companylists.value, company.value)['value'].toString());
      _getLocationList(company.value);
    }
  }

  _getLocationList(String cid) async {
    if (await isNetConnected()) {
      isLoading(true);
      LocationResponse? response = await getLocationDetails('$_userId', cid);
      locationlists.clear();
      box.remove(VMSSession.LOCID);
      if (response != null && response.status) {
        if (response.result.isNotEmpty) {
          for (LocationResult location in response.result) {
            locationlists.add({
              'id': '${location.LocationId}',
              'value': location.LocationName,
            });
          }

          if (box.read(VMSSession.LOCID) == null) {
            box.write(
                VMSSession.LOCID, locationlists.first['id'].toString());
            box.write(
                VMSSession.LOC, locationlists.first['value'].toString());
          }
          location(box.read(VMSSession.LOCID));
          _getGateList();
        }
      }
      isLoading(false);
    }
  }

  changeLocation(val) {
    if (val != location.value) {
      location(val);
      box.write(VMSSession.LOCID, val);
      box.write(VMSSession.LOC,
          getMapItem(locationlists.value, location.value)['value'].toString());
      _getGateList();
    }
  }

  _getGateList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await getGateDetails(location.value);
      gatelists.clear();
      box.remove(VMSSession.GATEID);
      if (response != null && response['status']) {
        if (response['result'].isNotEmpty) {
          for (var g in response['result']) {
            gatelists.add({'id': '${g['GateId']}', 'value': '${g['Gate']}'});
          }
          if (box.read(VMSSession.GATEID) == null) {
            box.write(
                VMSSession.GATEID, gatelists.first['id'].toString());
            box.write(
                VMSSession.GATE, gatelists.first['value'].toString());
          }
          gate(box.read(VMSSession.GATEID));
          getDashboardInfo();
        }
      } else {
        list.clear();
      }
      isLoading(false);
    }
  }

  changeGate(val) {
    if (val != gate.value) {
      gate(val);
      box.write(VMSSession.GATE,
          getMapItem(gatelists.value, gate.value)['value'].toString());
      box.write(VMSSession.GATEID, val);
      getDashboardInfo();
    }
  }

  getDashboardInfo() async {
    if (await isNetConnected()) {
      Map<String, dynamic> response =
          await getDashboard(company.value, location.value, gate.value);
      print(response);
      if (response['status']) {
        if (response['result'] != null && response['result'].isNotEmpty) {
          list(response['result']);
        }
      }
    }
  }

  submitMobileNo() async {
    if (gatelists.isEmpty) {
      showToastMsg('Please Select Gate');
      return;
    }

    if (await isNetConnected()) {
      print(mobileController.text);
      if (mobileController.text.length == 10) {
        showLoader(title: 'Fetching Details');
        visitor.mobileNo = mobileController.text;
        //check if already visitor
        try {
          var response =
              await checkVisitor(mobileController.text, location.value);
          if (response['Status']) {
            visitor = Visitor.fromJson(response['ReturnData']);
          }
        } catch (e) {
          print('exe $e');
        }
        hideLoader();
        Get.toNamed(VMSRoutes.PERSONAL, arguments: visitor);
      } else {
        showToastMsg('Invalid Mobile Number');
      }
    }
  }

  scanEntry() async {
    if (gatelists.isEmpty) {
      showToastMsg('Please Select Gate');
      return;
    }

    if (await isNetConnected()) {
      // String barcode = await FlutterBarcodeScanner.scanBarcode(
      //     '#ab1100', 'Back', true, ScanMode.DEFAULT);

      //http://ifazility.com/clientvms/Home/ActionQrCode?qrCode=78101312
      var barcode = await qrScan();
      // var barcode = "http://ifazility.com/clientvms/home/selfRegv1?key=186628";

      if (barcode != null && barcode != "-1") {
        if (barcode.contains('ifazility.com/clientvms')){
          bool? res=await showAlert('Self Registration!', 'Open self registration through web browser?', 'Open',isDismiss: true);
          if(res!=null && res){
            launchUrlString(barcode,mode: LaunchMode.externalApplication);
          }
          return;
        }

        showLoader();
        print('barcode string : $barcode');
        //api call
        var response = await getClientVisitorDetails(
          barcode,
        );
        hideLoader();
        if (response != null) {
          if (response.status!) {
            if ((response.returnData?.locationID ?? -1) ==
                int.parse(location.value)) {
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

  scanExit() async {
    if (gatelists.isEmpty) {
      showToastMsg('Please Select Gate');
      return;
    }

    if (await isNetConnected()) {
      // String barcode = await FlutterBarcodeScanner.scanBarcode(
      //     '#ab1100', 'Back', true, ScanMode.DEFAULT);
      var barcode = await qrScan();

      if (barcode != null && barcode != "-1") {

        if (barcode.contains('ifazility.com/clientvms')){
          bool? res=await showAlert('Self Registration!', 'Open self registration through web browser?', 'Open',isDismiss: true);
          if(res!=null && res){
            launchUrlString(barcode,mode: LaunchMode.externalApplication);
          }
          return;
        }


        showLoader();
        print('barcode string : $barcode');
        //api call
        var response = await passOut(barcode, location.value);
        hideLoader();
        if (response != null) showToastMsg('${response['message']}');
      }
    }
  }


  onCardClicked(item) {
    if (gatelists.isNotEmpty) {
      item['companyId'] = company.value;
      item['locationId'] = location.value;
      item['gateId'] = gate.value;
      Get.toNamed(VMSRoutes.DASHBOARD_DETAILS, arguments: item);
    } else {
      showToastMsg('Please Select Gate');
    }
  }


}
