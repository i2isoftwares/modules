import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/model/visitor_detail_response.dart';
import 'package:vms/routes/vms_app_routes.dart';

class VisitorViewController extends GetxController {
  VisitorDetail detail = Get.arguments;
  RxBool isValid = false.obs;
  RxString msg = "".obs;

  @override
  void onInit() {
    super.onInit();

    try {
      String date = detail.visitDate!;
      // String stime = detail.startTime!;
      // String etime = detail.endTime!;
      //
      // var time1 = DateFormat("MM/dd/yyyy hh:mm a").parse('$date $stime');
      // var time2 = DateFormat("MM/dd/yyyy hh:mm a").parse('$date $etime');
      // if (time1.millisecondsSinceEpoch <=
      //         DateTime.now().millisecondsSinceEpoch &&
      //     time2.millisecondsSinceEpoch >=
      //         DateTime.now().millisecondsSinceEpoch) {
      //   isValid(true);
      // }else{
      //   isValid(false);
      //   msg('Appointment Date Time Exceed');
      // }

      var d = DateFormat("MM/dd/yyyy").parse(date);
      if (d !=
          DateFormat("MM/dd/yyyy")
              .parse(DateFormat("MM/dd/yyyy").format(DateTime.now()))) {
        isValid(false);
        msg('Appointment Date Not Valid');
      }else{
        isValid(true);
        msg('');
      }

    } catch (e) {
      print(e);
    }
  }

  nextScreen() {
    Visitor visitor = Visitor();
    visitor.visitCompId = detail.tenantID.toString();
    visitor.visitCompName = detail.tenantName.toString();
    visitor.visitTowerName = detail.buildingName.toString();
    visitor.visitTowerId = detail.buildingID.toString();

    visitor.visitorName = detail.visitorFName.toString();
    visitor.mobileNo = detail.contactNo.toString();
    visitor.visitorImage = detail.visitorImage.toString();
    visitor.CustomerId=detail.customerId ?? 0;

    visitor.visitPersonName = detail.whomToVisit.toString();
    visitor.visitPurposeName = detail.purposeOfVisit.toString();
    visitor.visitPurposeId = detail.purposeOfVisitID.toString();

    visitor.idProofNo = detail.idProofNo.toString();
    visitor.idProofId = detail.idProofId;
    visitor.idProofImage = detail.idProofImage.toString();
    visitor.idProofName = detail.idProofName.toString();

    visitor.qrcode=detail.qRCode;

    visitor.visitorFrom=detail.comeFrom ?? '';
    visitor.accessories= (detail.accessory ?? '').isNotEmpty ? [
      Accessory(detail.accessory ?? '', '')
    ] : null;

    visitor.readOnly = true;

    Get.toNamed(VMSRoutes.PERSONAL, arguments: visitor);
  }
}
