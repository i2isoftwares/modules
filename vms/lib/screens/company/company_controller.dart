import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:i2iutils/widgets/spinner.dart';

import 'package:vms/helper/vms_session.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/building.dart';
import 'package:vms/model/tenant.dart';
import 'package:vms/model/vehicle.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:i2iutils/helpers/image_picker_helper.dart';


class CompanyController extends GetxController {
  Rx<Visitor> visitor = Visitor().obs;
  final box=GetStorage();
  String _locid = '-1';

  var haveveh = false.obs;

  var vehhint = 'Type'.obs, veh = ''.obs;
  RxList<Map<String, String>> vehlists = RxList();

  var tenanthint = 'Location'.obs, tenant = ''.obs;
  RxList<Map<String, String>> tenantlist = RxList();
  var buildinghint = 'Building'.obs, building = ''.obs;
  RxList<Map<String, String>> buildinglist = RxList();

  final vehNumber = TextEditingController(),
      contactNumber = TextEditingController(),
      personController = TextEditingController();

  Rx<Uint8List?> vehImagePath = Rx(null);

  @override
  void onInit() async {
    super.onInit();
    visitor = Get.arguments;
    personController.text = visitor.value.visitPersonName ?? '';
    
    _locid = box.read(VMSSession.LOCID) ?? '-1';

    isNetConnected().then((value) {
      if (!value) showToastMsg('Check your internet connection');
    });

    _setupVisitor();
    _getVehTypes();
  }

  _setupVisitor() {
    if (visitor.value.vehNumber != null) {
      if (visitor.value.vehNumber!.isNotEmpty &&
          !(visitor.value.vehNumber!.toLowerCase() == 'no vehicle')) {
        vehNumber.text = visitor.value.vehNumber!;
        haveveh(true);
        veh(visitor.value.vehType);
      }
    }

    personController.text = visitor.value.visitPersonName ?? '';
    contactNumber.text = visitor.value.visitPersonContactId ?? '';
  }

  _getVehTypes() async {
    if(await isNetConnected()) {
      Vehicle? vehres = await getVehicleList();
      if (vehres != null && vehres.status) {
        if (vehres.result.isNotEmpty) {
          vehlists.clear();
          for (VehicleList list in vehres.result) {
            vehlists.add({'id': '${list.modeId}', 'value': '${list.mode}'});
          }

          if (visitor.value.vehTypeId != null &&
              visitor.value.vehTypeId!.isNotEmpty) {
            veh(visitor.value.vehTypeId);
          } else if (vehlists.isNotEmpty) {
            veh(vehlists.first['id']);
          }
        }
      }
      _getTenantList();

    }
  }

  _getTenantList() async {
    if(await isNetConnected()) {
      Tenant? tenantres = await getTenantList(_locid);
      if (tenantres != null && tenantres.status) {
        if (tenantres.result.isNotEmpty) {
          tenantlist.clear();
          for (TenantList list in tenantres.result) {
            tenantlist
                .add({'id': '${list.tenantid}', 'value': '${list.tenantname}'});
          }
        }
      }
      if (visitor.value.visitCompId != null &&
          visitor.value.visitCompId!.isNotEmpty &&
          visitor.value.visitCompId != '0') {
        var r = tenantlist.singleWhere((element) =>
        element['id'] == visitor.value.visitCompId, orElse: () => {});

        if (r.isNotEmpty) {
          tenant(visitor.value.visitCompId);
          loadBuilding();
        } else {
          showToastMsg('Company Detail Not Found');
          tenantlist.clear();
          buildinglist.clear();
        }
      } else if (tenantlist.isNotEmpty) {
        tenant(tenantlist.first['id']);
        loadBuilding();
      }
      // if (visitor.value.visitTowerId != null && visitor.value.visitTowerId!.isNotEmpty) {
      // loadBuilding();
      // }
    }
  }

  loadBuilding() {
    showLoader();
    _getBuildingList(tenant.value);
  }

  _getBuildingList(String tenid) async {
    if (await isNetConnected()) {
      Building? buildingResponse = await getBuildingList(
        tenid,
        _locid,
      );
      if (buildingResponse != null && buildingResponse.status) {
        if (buildingResponse.result.isNotEmpty) {
          buildinglist.clear();
          building.value = '';
          for (BuildingList list in buildingResponse.result) {
            buildinglist.add({
              'id': '${list.buildingid}',
              'value': list.buildingshortname
            });
          }

          if (visitor.value.visitTowerId != null &&
              visitor.value.visitTowerId!.isNotEmpty) {
            building(visitor.value.visitTowerId);
          } else if (buildinglist.isNotEmpty) {
            building(buildinglist.first['id']);
          }
        }
      }
      hideLoader();
    }

  }

  Future getVehImage() async {
    Get.focusScope?.unfocus();

    final pickedImage = await getImage(Get.context!);
    if (pickedImage != null) {
      vehImagePath(pickedImage);
    } else {
      print('No veh image selected ${visitor}');
    }
  }

  confirmPage() {

    Get.focusScope?.unfocus();
    print('confirm page');
    //
    // if(_haveveh){
    //   if(_veh==null || _veh.isEmpty){
    //     Utility.showToastMsg( 'Select vehicle type');
    //     return;
    //   }
    //   // if(_vehImage==null){
    //   //   Utility.showToastMsg(context, 'Capture vehicle image');
    //   //   return;
    //   // }
    //   if(_vehNumber.text.isEmpty){
    //     Utility.showToastMsg( 'Enter vehicle number');
    //     return;
    //   }
    // }
    if(tenant.value==null || tenant.value.isEmpty){
      showToastMsg( 'Select company');
      return;
    }
    if(building.value==null || building.value.isEmpty){
      showToastMsg('Select tower');
      return;
    }
    if(personController.value.text.isEmpty){
      showToastMsg('Enter person to meet');
      return;
    }
    // if(_contactNumber.text.length<10){
    //   Utility.showToastMsg( 'Enter correct contact number');
    //   return;
    // }

    visitor.value.haveVeh = haveveh.value;
    visitor.value.vehType =
        getMapItem(vehlists.value, veh.value)['value'].toString();
    visitor.value.vehTypeId = veh.value;
    visitor.value.vehNumber = vehNumber.value.text;
    visitor.value.vehTypeImage = vehImagePath.value;
    visitor.value.visitCompId = tenant.value;
    visitor.value.visitCompName =
        getMapItem(tenantlist.value, tenant.value)['value'].toString();
    visitor.value.visitTowerId = building.value;
    visitor.value.visitTowerName =
        getMapItem(buildinglist.value, building.value)['value'].toString();
    visitor.value.visitPersonName = personController.text;
    visitor.value.visitPersonContactId = contactNumber.value.text;

    Get.toNamed(VMSRoutes.CONFIRM, arguments: visitor.value);

  }
}
