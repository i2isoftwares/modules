import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:i2iutils/helpers/image_picker_helper.dart';
import 'package:intl/intl.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/proof.dart';
import 'package:vms/model/purpose.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:i2iutils/widgets/spinner.dart';

class PersonalController extends GetxController {
  Rx<Visitor> visitor = Visitor().obs;
  Rx<RxList<dynamic>> accessory = RxList().obs;
  RxString visitImage = ''.obs, visitProofImage = ''.obs;

  var today = '', time = '';

  var temp = '°C'.obs;
  List<Map<String, String>> templists = [
    {
      'id': '°C',
      'value': '°C',
    }
  ].obs;

  var proofhint = 'ID Proof'.obs, proof = ''.obs;
  RxList<Map<String, String>> prooflists = RxList();

  var visithint = 'Visit Purpose'.obs, purpose = ''.obs;
  RxList<Map<String, String>> purposelists = RxList();

  var haveacc = false.obs;

  Rx<Uint8List?> userImagePath = Rx(null), proofImagePath = Rx(null);

  Rx<TextEditingController> namecontroller = TextEditingController().obs,
      mobilecontroller = TextEditingController().obs,
      loccontroller = TextEditingController().obs,
      tempController = TextEditingController().obs,
      proofController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    visitor(Get.arguments);

    today = DateFormat('MMM dd yyy').format(DateTime.now());
    time = DateFormat('hh:mm a').format(DateTime.now());
    _getProofList();

    isNetConnected().then((value) {
      if (!value) showToastMsg('Check your internet connection');
    });

    _setupVisitor();
  }

  _setupVisitor() {
    namecontroller.value.text = visitor.value.visitorName ?? '';
    loccontroller.value.text = visitor.value.visitorFrom ?? '';
    mobilecontroller.value.text = visitor.value.mobileNo ?? '';

    proofController.value.text = visitor.value.idProofNo ?? '';
    // proof(visitor.value.idProofName);

    // purpose(visitor.value.visitPurposeName);

    tempController.value.text = visitor.value.bodyTemp ?? '';
    // if (visitor.value.tempScale != null) temp(visitor.value.tempScale);
    temp(templists.first['id']);

    if (visitor.value.visitorImage.runtimeType == String) {
      visitImage(visitor.value.visitorImage);
    }

    if(visitor.value.accessories!=null && visitor.value.accessories!.isNotEmpty){
      haveacc(true);
      accessory.value.addAll(visitor.value.accessories!);
    }
  }

  _getProofList() async {
    if(await isNetConnected()) {
      Proof? proofres = await getProofList();
      if (proofres != null && proofres.status) {
        if (proofres.result.isNotEmpty) {
          prooflists.clear();
          for (ProofList list in proofres.result) {
            prooflists.add({'id': '${list.proofid}', 'value': list.proofname});
          }
          if (visitor.value.idProofId != null && visitor.value.idProofId != 0) {
            proof('${visitor.value.idProofId}');
          } else if (prooflists.isNotEmpty) {
            proof(prooflists.first['id']);
          }
        }
      }
      _getPurposeList();
    }
  }

  _getPurposeList() async {
    if(await isNetConnected()) {
      Purpose? purposeres = await getPurposeList();
      if (purposeres != null && purposeres.status) {
        if (purposeres.result.isNotEmpty) {
          purposelists.clear();
          for (PurposeList list in purposeres.result) {
            purposelists
                .add(
                {'id': '${list.purposeid}', 'value': list.purposename});
          }
          if (visitor.value.visitPurposeId != null &&
              visitor.value.visitPurposeId!.isNotEmpty &&
              visitor.value.visitPurposeId != '0') {
            purpose(visitor.value.visitPurposeId);
          } else if (purposelists.isNotEmpty) {
            purpose(purposelists.first['id']);
          }
        }
      }
    }
  }

  Future getUserImage() async {
    Get.focusScope?.unfocus();

    final pickedFile = await getImage(Get.context!,);

    if (pickedFile != null) {
      userImagePath(pickedFile);
    } else {
      print('No user image selected');
    }
  }

  Future getProofImage() async {
    Get.focusScope?.unfocus();

    final pickedFile = await getImage(Get.context!,);

    if (pickedFile != null) {
      proofImagePath(pickedFile);
    } else {
      print('No proof image selected $visitor');
    }
  }

  nextPage() {
    Get.focusScope?.unfocus();

    if (namecontroller.value.text.isEmpty) {
      showToastMsg('Enter visitor name');
      return;
    }
    if (userImagePath.value == null && visitImage.isEmpty) {
      showToastMsg('Capture visitor image');
      return;
    }
    if (loccontroller.value.text.isEmpty) {
      showToastMsg('Enter visitor coming from');
      return;
    }
    // if (_tempController.text.isEmpty) {
    //   Utility.showToastMsg(context, 'Enter visitor body temp');
    //   return;
    // }
    if (proof.value.isEmpty) {
      showToastMsg('Select ID proof purpose');
      return;
    }
    if (proofController.value.text.isEmpty) {
      showToastMsg('Enter proof Number');
      return;
    }
    // if (_proofImage == null) {
    //   Utility.showToastMsg(context, 'Capture ID proof image');
    //   return;
    // }
    if (purpose.value.isEmpty) {
      showToastMsg('Select visit purpose');
      return;
    }

    visitor.value.visitingDateTime = '$today $time';
    visitor.value.visitorName = namecontroller.value.text;
    visitor.value.visitorImage =
        userImagePath.value ?? visitor.value.visitorImage;
    visitor.value.visitorFrom = loccontroller.value.text;
    visitor.value.bodyTemp = tempController.value.text;
    visitor.value.tempScale = temp.value;
    visitor.value.idProofId = int.parse(proof.value);
    visitor.value.idProofName =
        getMapItem(prooflists.value, proof.value)['value'].toString();
    visitor.value.idProofImage = proofImagePath.value;
    visitor.value.idProofNo = proofController.value.text;
    visitor.value.visitPurposeId = purpose.value;
    visitor.value.visitPurposeName =
        getMapItem(purposelists.value, purpose.value)['value'].toString();
    visitor.value.haveAccess = haveacc.value && accessory.value.isNotEmpty;
    if (haveacc.value) {
      visitor.value.accessories = accessory.value
          .map((element) => Accessory.fromJson(element.toJson()))
          .toList();
    }

    Get.toNamed(VMSRoutes.COMPANY, arguments: visitor);
  }

  addAccessory() async {
    Get.focusScope?.unfocus();
    var acc = await showAccessoryDialog();
    if (acc != null) accessory.value.add(acc);
  }

  void deleteAcc(Accessory acc) {
    accessory.value.remove(acc);
  }
}
