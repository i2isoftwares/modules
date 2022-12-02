import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greenchecklist/api/api_calls.dart';
import 'package:greenchecklist/model/ticket_detail_response.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import '../../helpers/gc_session.dart';
import '../../model/all_tickets_response.dart';

class HelpdeskController extends GetxController {
  final box = GetStorage();
  RxBool isLoading = true.obs;
  RxList<Statusdetails> statusDetails = RxList();
  RxList<TicketDetails> tickets = RxList();
  String selectedStatusColor = "#FFFFFF";
  RxInt selectedStatusId = 0.obs;

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;

  int userId = -1, companyId = -1, locationId = -1, groupId = -1;

  DateTimeRange? dateRange;
  String mdy = 'MM-dd-yyyy';

  @override
  void onInit() async {
    super.onInit();

    fromDate(getDate(format: mdy));
    toDate(getDate(format: mdy));

    userId = box.read(GCSession.hdUserId) ?? -1;
    companyId = box.read(GCSession.hdUserCompanyId) ?? -1;
    locationId = box.read(GCSession.hdUserLocationId) ?? -1;
    groupId = box.read(GCSession.hdUserGroupId) ?? -1;

    if (userId == -1) {
      //get helpdesk user details

      var params = {
        'CompanyID': '${box.read(GCSession.userCompanyId)}',
        'LocationID': '${box.read(GCSession.userLocationId)}',
        'BuildingID': '0',
        'Floor': '',
        'Wing': '',
        'Complaint': 'greenchklist',
        'CompliantNature': '',
      };
      // {"CompanyID":"166076","LocationID":"288198","BuildingID":"0","Floor":"","Wing":"","Complaint":"greenchklist","CompliantNature":""}
      var response = await ApiCall().getHelpdeskDetail(params);
      if (response != null) {
        if (response['RtnStatus']) {
          userId = response['RtnData'][0]['UserID'];
          companyId = response['RtnData'][0]['CompanyId'];
          locationId = response['RtnData'][0]['LocationId'];
          groupId = response['RtnData'][0]['GroupId'];
          box.write(GCSession.hdUserId, userId);
          box.write(GCSession.hdUserCompanyId, companyId);
          box.write(GCSession.hdUserLocationId, locationId);
          box.write(GCSession.hdUserGroupId, groupId);
        } else {
          showToastMsg(response['RtnMessage'] ?? 'Something went wrong');
        }
      }
    }
    getTicket();
  }

  getTicket() async {
    if (await isNetConnected()) {
      isLoading(true);
      var params = {
        'GroupId': '$groupId',
        'CompanyId': '$companyId',
        'UserId': '$userId',
        'Fromdate': '$fromDate',
        'Enddate': '$toDate',
      };

      try {
        var response = await ApiCall().getTickets(params);

        if (response != null) {
          if (response.status) {
            statusDetails(response.statusdetails ?? []);

            if(response.statusdetails?.isNotEmpty ?? false) onStatusChange(statusDetails.first);

          } else {
            showToastMsg(response.message);
          }
        }
      } catch (e) {
        showToastMsg(e.toString());
      }
      isLoading(false);
    }
  }

  onStatusChange(Statusdetails status) async {
    if (await isNetConnected()) {
      isLoading(true);
      var params = {
        'statusid': '${status.statusid}',
        'CompanyId': '$companyId',
        'UserId': '$userId',
        'Fromdate': '$fromDate',
        'Enddate': '$toDate',
      };
      selectedStatusColor=status.colorcode;
      selectedStatusId(status.statusid);
      try {
        var response = await ApiCall().getTicketDetails(params);

        if (response != null) {
          if (response.status) {
            tickets(response.ticketdetails ?? []);
          } else {
            tickets.clear();
            showToastMsg(response.message);
          }
        }
      } catch (e) {
        showToastMsg(e.toString());
      }
      isLoading(false);
    }
  }

  changeDate() async {
    dateRange = await customDateRange(dateRange);
    if (dateRange == null) return;

    fromDate(getDate(format: mdy, dateTime: dateRange!.start));
    toDate(getDate(format: mdy, dateTime: dateRange!.end));

    getTicket();
  }

  Future<DateTimeRange?> customDateRange(DateTimeRange? dates) async {
    return await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dates,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('en', "IN"),
      fieldStartHintText: 'dd/MM/yyyy',
      fieldEndHintText: 'dd/MM/yyyy',
    );
  }
}
