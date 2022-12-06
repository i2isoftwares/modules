import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:i2iutils/widgets/spinner.dart';
import 'package:intl/intl.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/building.dart';
import 'package:vms/model/invite_visitor_list_response.dart';
import 'package:vms/model/purpose.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';

import '../../../helper/vms_session.dart';

class ClientVisitorEntryController extends GetxController {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var personController = TextEditingController();

  var purpose = ''.obs;
  RxList<Map<String, String>> purposeLists = RxList();

  var building = ''.obs;
  RxList<Map<String, String>> buildingList = RxList();

  DateTime selectedDate = DateTime.now();

  String tenId = '-1', locId = '-1', compId = '-1';
  int userId = -1;
  RxBool isLoading = false.obs;

  TimeOfDay initialTime = TimeOfDay.now();

  InviteVisitors? visitor = Get.arguments;

  final box=GetStorage();

  @override
  void onInit() async {
    super.onInit();
    
    tenId = box.read(VMSSession.TENENTID) ?? '-1';
    compId = box.read(VMSSession.COMPID) ?? '-1';
    locId = box.read(VMSSession.LOCID) ?? '-1';
    userId = box.read(VMSSession.USERID) ?? -1;

    if (visitor != null) {
      // selectedDate=DateFormat('MMM dd yyyy').parse(visitor!.visitDate);
      dateController.text = DateFormat('dd MMM yyyy').format(selectedDate);
      timeController.text = visitor!.startTime ?? '';
      fNameController.text = visitor!.visitorFName;
      lNameController.text = visitor!.visitorLName;
      emailController.text = visitor!.emailID ?? '';
      personController.text = visitor!.whomToVisit;
      mobileController.text = visitor!.contactNo;
    }

    _getBuildingList();
  }

  submitMobileNo() async {
    if (await isNetConnected()) {
      if (mobileController.text.length == 10) {
        showLoader(title: 'Fetching Details');
        //check if already visitor
        try {
          var response = await checkVisitor(mobileController.text, locId);
          if (response['Status']) {
            Visitor visitor = Visitor.fromJson(response['ReturnData']);

            fNameController.text = visitor.visitorName ?? '';
            personController.text = visitor.visitPersonName ?? '';
            if ((visitor.visitPurposeId ?? '').isNotEmpty) {
              purpose(visitor.visitPurposeId);
            }
          }
        } catch (e) {
          debugPrint('exe $e');
        }
        hideLoader();
      } else {
        showToastMsg('Invalid Mobile Number');
      }
    }
  }

  _getBuildingList() async {
    if (await isNetConnected()) {
      isLoading(true);
      Building? buildingResponse = await getBuildingList(
        tenId,
        locId,
      );
      if (buildingResponse != null && buildingResponse.status) {
        if (buildingResponse.result.isNotEmpty) {
          buildingList.clear();
          building.value = '';
          for (BuildingList list in buildingResponse.result) {
            buildingList.add(
                {'id': '${list.buildingid}', 'value': list.buildingshortname});
          }

          if (visitor != null) {
            building(visitor!.buildingID.toString());
          } else if (buildingList.isNotEmpty) {
            building(buildingList.first['id']);
          }
        }
      }
      _getPurposeList();
    }
  }

  _getPurposeList() async {
    Purpose? purposeres = await getPurposeList();
    if (purposeres != null && purposeres.status) {
      if (purposeres.result.isNotEmpty) {
        purposeLists.clear();
        for (PurposeList list in purposeres.result) {
          purposeLists
              .add({'id': '${list.purposeid}', 'value': list.purposename});
        }

        if (visitor != null && visitor!.purposeOfVisitID != null) {
          purpose(visitor!.purposeOfVisitID.toString());
        } else if (purposeLists.isNotEmpty) {
          purpose(purposeLists.first['id']);
        }
      }
    }
    isLoading(false);
  }

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('dd MMM yyyy').format(selectedDate);
    }
  }

  selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      initialTime = pickedTime;
      timeController.text = initialTime.format(Get.context!);
    }
  }

  create() async {
    if (fNameController.text.isEmpty) {
      showToastMsg('Enter Visitor Name');
    } else if (mobileController.text.isEmpty) {
      showToastMsg('Enter Visitor Mobile Number');
    } else if (dateController.text.isEmpty) {
      showToastMsg('Select Visiting Date');
    } else if (personController.text.isEmpty) {
      showToastMsg('Enter Meeting Person');
    } else {
      if (await isNetConnected()) {
        isLoading(true);

        var params = {
          "ClientVisitorID": visitor?.clientVisitorID ?? 0,
          //edit visitorid
          "TenantID": tenId,
          "TenantName": '',
          "LocationID": locId,
          "LocationName": '',
          //spinner
          "BuildingID": building.value,
          //spinner
          "Visitor_FName": fNameController.text,
          "Visitor_LName": lNameController.text,
          "Contact_No": mobileController.text,
          "Email_ID": emailController.text,
          "Visit_Date": DateFormat('MM/dd/yyyy')
              .format(DateFormat('dd MMM yyyy').parse(dateController.text)),
          //MM/dd/yyyy
          "Start_Time": timeController.text, // hh:mm a
          "Whom_To_Visit": personController.text,
          "Purpose_Of_Visit":
              getMapItem(purposeLists.value, purpose.value)['value'],
          //dropdown
          "CUser": userId,
          "QRCode":visitor?.qRCode ?? "",
          //Tenantloginid
        };

        var response = await saveClient(params);
        if (response != null) {
          showToastMsg(response['message']);
          if (response['status']) {
            Get.offAllNamed(
              VMSRoutes.CLIENT_VISITOR_VIEW,
            );
          }
        } else {
          showToastMsg('Something wrong');
        }

        isLoading(false);
      }
    }
  }

  getNumber() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    var number = contact.phoneNumber?.number ?? '';
    if (number.length == 12) {
      number = number.substring(2, number.length);
    }
    mobileController.text = number;
    if (mobileController.text.length == 10) {
      submitMobileNo();
    }
  }
}
