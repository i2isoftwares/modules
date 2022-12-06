import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/helper/vms_session.dart';

class TicketController extends GetxController {
  Visitor visitor=Get.arguments;
  final box=GetStorage();
  RxString compLogo="".obs;

  @override
  void onInit() async{
    
    compLogo(box.read(VMSSession.COMP_LOGO) ?? "");
    super.onInit();
  }

}
