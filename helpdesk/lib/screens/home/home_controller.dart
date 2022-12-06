import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helpdesk/api/helpdesk_api_calls.dart';
import 'package:helpdesk/helpers/color.dart';
import 'package:helpdesk/helpers/strings.dart';
import 'package:helpdesk/helpers/utils.dart';
import 'package:helpdesk/model/feedback_tickets_response.dart';
import 'package:helpdesk/model/helpdesk_login_response.dart';
import 'package:helpdesk/routes/hd_app_routes.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:i2iutils/widgets/button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../helpers/notification.dart';

class HomeController extends GetxController {
  RxString image = "".obs;
  RxBool isLoading = false.obs;
  RxBool isServiceEng = false.obs;
  RxBool isAdmin = false.obs;
  RxBool isSuperAdmin = false.obs;

  int userId = -1;

  RxMap<String, int> companyList = RxMap();
  RxMap<String, int> locationList = RxMap();
  RxList<Buildingdetails> buildingList = RxList();
  List<Buildingdetails> buildings = [];
  RxMap<String, int> ticketTypeList = RxMap();

  RxString selectedCompany = "".obs;
  RxString selectedLocation = "".obs;
  RxList<Buildingdetails> selectedBuildingList = RxList();
  var allBuildingDetails = Buildingdetails(0, 0, "All Building", "AB");
  RxString selectedTicketType = "All".obs;

  RxString todayDate = "".obs;
  RxString yesterday = "".obs;
  RxString lastSevenDays = "".obs;
  RxString lastThirtyDays = "".obs;
  RxString customRange = "".obs;

  RxString selectedDateType = "1".obs;
  RxString selectStartDate = ''.obs;
  RxString selectEndDate = ''.obs;
  String label = '';
  DateTimeRange? dateRange;
  bool isShowFeedback = Get.arguments ?? false;
  RxBool canShowType = false.obs;

  //for feedback
  Rx<FeedbackTicketData?> fData = Rx(null);

  final box = GetStorage();
  bool canExit = false;

  bool isB2c = false;
  RxString viewTicketLabel = "View Ticket".obs, myTicketLabel = "My Ticket".obs;

  @override
  void onInit() async {
    super.onInit();
    userId = box.read(USER_ID) ?? -1;
    isAdmin(box.read(IS_ADMIN) ?? false);
    isSuperAdmin(box.read(IS_ADMIN) ?? false);
    isServiceEng(box.read(IS_SE) ?? false);
    isB2c = box.read(IS_B2C) ?? false;
    setupCompany();
    getSettings();
  }

  @override
  void onReady() async {
    super.onReady();
    todayDate(getTodayDate());
    yesterday(getYesterdayDate());
    lastSevenDays(getLastSevenDays());
    lastThirtyDays(getLastThirtyDays());
    label = 'Today ${todayDate.value}';

    selectStartDate(getPastDay(0));
    selectEndDate(getPastDay(0));

    if (!isB2c) {
      getFeedbackTickets();

/*      var newVersion = NewVersion();
      newVersion.showAlertIfNecessary(context: Get.context!);*/

      // checkAppVersion();
    }

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      // showToastMsg('Payload ${notificationAppLaunchDetails.payload}');
      if (notificationAppLaunchDetails.notificationResponse?.payload != null) {
        Get.toNamed(HDRoutes.TICKET_DETAIL,
            arguments: {'complaintId': notificationAppLaunchDetails.notificationResponse?.payload});
      }
    }
  }

  getFeedbackTickets() async {
    if (await isNetConnected()) {
      var response = await HelpdeskApiCall()
          .getFeedbackTickets('${box.read(COMP_ID)}', '${box.read(USER_ID)}');
      if (response != null && response.status) {
        fData(response.returnData);
        if (response.returnData.feedbackdetails?.isNotEmpty ?? false) {
          if (isShowFeedback) {
            showFeedbackDialog();
          }
        }
      }
    }
  }

  getSettings() async {
    if (await isNetConnected()) {
      var response = await HelpdeskApiCall().getSettings('$userId');
      if (response != null) {
        box.write(IS_COST_REQ, response['CostIncurred']);
        box.write(IS_CUST_REF, response['CustRefNo']);
        box.write(IS_REQ_TYPE, response['RequestType'] ?? false);
        box.write(CAN_SHOW_GAL_OPT, response['GalleryOption'] ?? false);
        canShowType(response['ComplaintType'] ?? false);
        box.write(CAN_SHOW_COMP_TYPE, canShowType.value);
        box.write(EMP_ID, response['RequestorID']);

        box.write(CAN_SHOW_REQ_BY,
            response['CanShowReqBy'] ?? (isAdmin.value || isSuperAdmin.value));

        int compid = getId(companyList.value, selectedCompany.value);
        if (canShowType.value) getTicketType('$compid');
      }
    }
  }

  setupCompany() {
    var temp = jsonDecode(box.read(COMP_LIST) ?? '[]') as List;
    log(temp.toString());
    List<Companydetails> companies =
        temp.map((e) => Companydetails.fromJson(e)).toList();
    companyList.clear();
    if (companies.length > 1 || companies.isEmpty) {
      companyList.addAll({'All Company': 0});
    }
    if (companies.isNotEmpty) {
      companyList.addAll({for (var e in companies) e.company: e.companyId});
    }
    selectedCompany(companyList.keys.elementAt(companyList.length > 1 ? 1 : 0));
    setupLocation();
  }

  setupLocation() {
    int compid = getId(companyList.value, selectedCompany.value);

    var temp = jsonDecode(box.read(LOC_LIST) ?? '[]') as List;
    List<Locationdetails> locations =
        temp.map((e) => Locationdetails.fromJson(e)).toList();

    if (compid != 0) {
      locations.removeWhere((element) => element.companyId != compid);
    }

    locationList.clear();
    if (locations.length > 1 || locations.isEmpty) {
      locationList.addAll({'All Location': 0});
    }
    if (locations.isNotEmpty) {
      locationList.addAll({for (var e in locations) e.location: e.locationId});
    }
    selectedLocation(
        locationList.keys.elementAt(locationList.length > 1 ? 1 : 0));
    setupBuilding();
  }

  setupBuilding() {
    int locId = getId(locationList.value, selectedLocation.value);

    buildingList.clear();
    var temp = jsonDecode(box.read(BUILDING_LIST) ?? '[]') as List;
    buildings = temp.map((e) => Buildingdetails.fromJson(e)).toList();

    if (locId != 0) {
      buildings.removeWhere((element) => element.locationId != locId);
    }

    buildingList.addAll(buildings);
    selectedBuildingList(buildingList);
  }

  void showBuilding() async {
    await showDialog(
      context: Get.context!,
      builder: (ctx) {
        return MultiSelectDialog(
          items:
              buildingList.map((e) => MultiSelectItem(e, e.building)).toList(),
          initialValue: selectedBuildingList,
          onConfirm: (values) {
            selectedBuildingList(values as List<Buildingdetails>);
          },
        );
      },
    );
  }

  getTicketType(String companyId) async {
    if (await isNetConnected()) {
      isLoading(true);
      try {
        var response = await HelpdeskApiCall().getTicketTypes(companyId);
        ticketTypeList.clear();
        if (response != null) {
          if (response.status) {
            if (response.requestType.length > 1 ||
                response.requestType.isEmpty) {
              ticketTypeList.addAll({'All': 0});
            }
            ticketTypeList.addAll(
                {for (var e in response.requestType) e.type: e.ticketTypeId});
          }
          selectedTicketType(ticketTypeList.keys.elementAt(0));
          viewTicketLabel("View ${selectedTicketType.value} Ticket");
          myTicketLabel("My ${selectedTicketType.value} Ticket");
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      isLoading(false);
    }
  }

  getDateRange(String val) async {
    dateRange = await customDateRange(dateRange);
    if (dateRange == null) return;

    selectStartDate(formatter.format(dateRange!.start));
    selectEndDate(formatter.format(dateRange!.end));

    customRange('${selectStartDate.value} - ${selectEndDate.value}');
    selectedDateType(val);
    label = 'Custom Days (${customRange.value})';
  }

  gotoTickets(String api, String title) {
    if (canShowType.value && selectedTicketType.isEmpty) {
      showToastMsg('Select Ticket Type');
      return;
    }

    if (selectedBuildingList.isEmpty) {
      showToastMsg('Select Building');
      return;
    }

    var params = {
      'companyName': selectedCompany.value,
      'companyid': '${getId(companyList.value, selectedCompany.value)}',
      'locationName': selectedLocation.value,
      'locationid': '${getId(locationList.value, selectedLocation.value)}',
      'duration': label,
      'userid': '$userId',
      'TicketDate':
          sendFormatter.format(formatter.parse(selectStartDate.value)),
      'enddate': sendFormatter.format(formatter.parse(selectEndDate.value)),
      'apiUrl': api,
      'ticketType': canShowType.value
          ? '${getId(ticketTypeList.value, selectedTicketType.value)}'
          : '0',
      'title': title,
      "building": selectedBuildingList.value,
      "complaintType": selectedTicketType.value,
    };

    Get.toNamed(HDRoutes.TICKETS, arguments: params);
  }

  showFeedbackDialog() async {
    await showModalBottomSheet(
        context: Get.context!,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please share your feedback',
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.w800),
                ),
                const Divider(),
                const Text(
                    'One of your tickets were recently closed. Please share your feedback to improve our work. Thanks'),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  width: 150,
                  buttonText: 'Give Feedback',
                  onPressed: () async {
                    Get.back();
                    if (fData.value == null) return;
                    var res = await Get.toNamed(HDRoutes.FEEDBACK,
                        arguments: fData.value);
                    if (res != null) {
                      fData.value?.feedbackdetails = res;
                      fData.refresh();
                    }
                  },
                  textSize: 13,
                  height: 35,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }
}
