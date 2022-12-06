
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:intl/intl.dart';
import 'package:vms/helper/vms_session.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/invite_visitor_list_response.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:i2iutils/widgets/button.dart';

class ClientVisitorViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var searchController = TextEditingController();
  final box=GetStorage();

  RxList<InviteVisitors> visitors = RxList();
  RxList<InviteVisitors> todayVisitors = RxList();
  RxList<InviteVisitors> upcomingVisitors = RxList();
  List<InviteVisitors> tempTodayList = [];
  List<InviteVisitors> tempUpcomingList = [];
  List<InviteVisitors> tempVisitorList = [];
  RxBool isLoading = false.obs;

  int _userId = -1;
  RxString title = 'Hi!'.obs;
  TabController? tController;
  String today = '';

  RxString prevCount='0'.obs,ucCount='0'.obs;
  RxInt tnCount=0.obs,tiCount=0.obs,toCount=0.obs;

  String listTitle = '';

  @override
  void onInit() async {
    
    _userId = box.read(VMSSession.USERID) ?? -1;
    String name = box.read(VMSSession.USEREMAIL) ?? '';
    title('Hi! $name');
    super.onInit();
    tController = TabController(length: 3, vsync: this);
    tController?.addListener(() {
      filter(searchController.text, tController!.index);
    });
    today = DateFormat('MMM dd yyyy').format(DateTime.now());
    getList();

  }


  getList() async {
    if (await isNetConnected()) {
      isLoading(true);
      InviteVisitorListResponse? response =
          await getClientVisitorList('$_userId');
      if (response != null && response.status) {
        if (response.result!.isNotEmpty) {
          visitors(response.result!
              .where((element) => DateFormat("MMM dd yyyy")
                  .parse(element.visitDate)
                  .isBefore(DateFormat("MMM dd yyyy").parse(today)))
              // .where((element) => !element.isVisited)
              .toList());

          upcomingVisitors(response.result!
              .where((element) => DateFormat("MMM dd yyyy")
                  .parse(element.visitDate)
                  .isAfter(DateFormat("MMM dd yyyy").parse(today)))
              .toList());

          todayVisitors(response.result!
              .where((element) => DateFormat("MMM dd yyyy")
              .parse(element.visitDate)
              .isAtSameMomentAs(DateFormat("MMM dd yyyy").parse(today)))
              .toList());

          // visitors(response.result!);
          tempTodayList = todayVisitors.value;
          tempUpcomingList = upcomingVisitors.value;
          tempVisitorList = visitors.value;

          prevCount('${tempVisitorList.length}');
          ucCount('${tempUpcomingList.length}');

          tnCount(0);
          tiCount(0);
          toCount(0);
          for (var element in tempTodayList) {
            if(!element.isVisited){
              tnCount(++tnCount.value);
            }else if((element.inTime.isNotEmpty && element.outTime.isEmpty)){
              tiCount(++tiCount.value);
            }else{
              toCount(++toCount.value);
            }
          }

        }
      }
      isLoading(false);
    }
  }


  //typed listener for search
  void filter(String q, int index) {
    try {
      String query = q.toLowerCase().trim();

      if (query.isNotEmpty) {
        //Loaded searched
        if (index == 0) {
          upcomingVisitors(tempUpcomingList
              .where((element) =>
                  element.visitorFName.toLowerCase().contains(query) ||
                  element.contactNo.toLowerCase().contains(query))
              .toList());

        } else if(index==1) {
          todayVisitors(tempTodayList
              .where((element) =>
                  element.visitorFName.toLowerCase().contains(query) ||
                  element.contactNo.toLowerCase().contains(query))
              .toList());

        } else{
        visitors(tempVisitorList
            .where((element) =>
        element.visitorFName.toLowerCase().contains(query) ||
            element.contactNo.toLowerCase().contains(query))
            .toList());

      }
      } else {
        //Loaded fully
        if (index == 0) {
          upcomingVisitors(tempUpcomingList);
        } else if(index==1){
          todayVisitors(tempTodayList);
        } else {
          visitors(tempVisitorList);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (index == 0) {
        upcomingVisitors(tempUpcomingList);
      } else if(index==1){
        todayVisitors(tempTodayList);
      } else {
        visitors(tempVisitorList);
      }
    }
  }

  void smsResend(InviteVisitors visitor) async {
    bool? res = await showAlert(
        'are you sure you want to  resend sms to ${visitor.visitorFName}',
        '',
        'Resend');
    if (res != null && res) {
      if (await isNetConnected()) {
        showLoader(title: 'Resend SMS');
        var response = await clientResendSms(
          visitor.qRCode,
        );
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
}
