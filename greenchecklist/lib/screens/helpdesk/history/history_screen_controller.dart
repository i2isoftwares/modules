
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenchecklist/api/api_calls.dart';
import 'package:greenchecklist/model/ticket_histories.dart';
import 'package:i2iutils/helpers/common_functions.dart';

class HistoryScreenController extends GetxController{

  var complaintId=Get.arguments['complaintId'];
  RxBool isHistoryLoading=false.obs;
  RxList<Histories> histories=RxList();

  @override
  void onInit() {
    super.onInit();
    getTicketHistory();
  }

  getTicketHistory() async {

    if (await isNetConnected()) {
      isHistoryLoading(true);

      try {
        var response = await ApiCall().getTicketHistory(complaintId);
        if (response != null) {
          if (response['Status']) {
            histories((response['ticketdetails']['lsthistory'] as List).map((e) => Histories.fromJson(e)).toList());
          }else{
            showToastMsg('${response['Message']}');
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      isHistoryLoading(false);
    }
  }

}