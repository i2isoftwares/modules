import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenchecklist/api/api_calls.dart';
import 'package:greenchecklist/helpers/constatnts.dart';
import 'package:greenchecklist/helpers/utils.dart';
import 'package:greenchecklist/model/checklist_wise.dart';
import 'package:greenchecklist/model/template_wise.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardDetailController extends GetxController {
  var args = Get.arguments;

  String title = '';

  RxList list = RxList();
  RxBool isLoading = true.obs;

  Dio _dio = Dio();
  var reportPath = '';

  @override
  void onInit() async {
    super.onInit();

    if (args['isChecklist']) {
      title = (args['checklist'] as ChecklistWise).checkList;
      getChecklistDetail();
    } else {
      title = (args['template'] as TemplateWise).templateName;
      getLogsheetDetail();
    }

    reportPath = (await getApplicationDocumentsDirectory()).path;
  }

  getChecklistDetail() async {
    if (await isNetConnected()) {
      var params = {
        'locationid': encryptString(args['locationId']),
        'buildingid': encryptString(args['buildingId']),
        'departmentid': encryptString(
            (args['checklist'] as ChecklistWise).departmentId.toString()),
        'categoryid': encryptString(
            (args['checklist'] as ChecklistWise).categoryId.toString()),
        'floorid': encryptString(args['floorId']),
        'wingid': encryptString(args['wingId']),
        'type': args['isComplete'] ? 0 : 2,
        'date': args['date'],
        'time': args['time'],
        'userid': args['userId'],
        'token': args['token'],
      };

      var response = await ApiCall().getChecklistDetail(params);
      if (response != null) {
        if (response['status']) {
          list(response['result']);
          //{BuildingName: Discovery Centre, FloorName: Ground Floor, WingName: No Wing, slot: 00:00-24:00, Percentage: 100.00, Status: True, buildingid: 66642, floorid: 74800, wingid: 79857, ChecklistID: 14157, AssignDeptId: 276, Type: Completed, qrcode: 7548056009282583215, uploadimage: 7fcf489d-fcc5-41d3-b294-8cc335863844.png, deviceguid: 20508822-6d7b-4815-b47a-27bee97b1cd5}
        } else {
          showToastMsg(response['message']);
        }
      }

      isLoading(false);
    }
  }

  getLogsheetDetail() async {
    if (await isNetConnected()) {
      var params = {
        'locationid': encryptString(args['locationId']),
        'buildingid': encryptString(args['buildingId']),
        'templateid': encryptString(
            (args['template'] as TemplateWise).templateId.toString()),
        'floorid': encryptString(args['floorId']),
        'wingid': encryptString(args['wingId']),
        'status': args['isComplete'] ? 1 : 0,
        'date': args['date'],
        'time': args['time'],
        'userid': args['userId'],
        'token': args['token'],
      };

      var response = await ApiCall().getLogsheetDetail(params);
      if (response != null) {
        if (response['status']) {
          list(response['result']);
        } else {
          showToastMsg(response['message']);
        }
      }

      isLoading(false);
    }
  }

  downloadCheckReport(data) async {
    if (await checkFileIsExist(data['deviceguid'])) {
      viewReport(data['deviceguid']);
      return;
    }
    if (await isNetConnected()) {
      String date = getDate(format: "MM-dd-yyyy");
      var slots = data['slot'].toString().split('-');
      var params = {
        'SlotSDate': '$date ${slots[0].trim()}',
        'SlotEDate':
            '$date ${slots[1].startsWith('24') ? '23:59' : '${slots[1].trim()}'}',
        'CompanyID': args['companyId'],
        'LocationId': args['locationId'],
        'BuildingId': data['buildingid'],
        'FloorId': data['floorid'],
        'WingId': data['wingid'],
        'ChecklistID': data['ChecklistID'],
        'AssignDeptId': data['AssignDeptId'],
        'Score': '1',
        'Slot': data['slot'],
        "deviceguid": data['deviceguid'],
        'userid': args['userId'],
        'token': args['token'],
      };

      var response = await ApiCall().getCheckDownloadableLink(params);
      if (response != null) {
        if (response['status']) {
          downloadPdf(response['result'], data['deviceguid']);
        } else {
          showToastMsg(response['message']);
        }
      }
    }
  }

  downloadLogReport(String guid) async {
    if (await checkFileIsExist(guid)) {
      viewReport(guid);
      return;
    }
    if (await isNetConnected()) {
      var params = {
        'companyid': args['companyId'],
        'deviceguid': guid,
        'userid': args['userId'],
        'token': args['token'],
      };

      var response = await ApiCall().getLogDownloadableLink(params);
      if (response != null) {
        if (response['status']) {
          downloadPdf(response['result'], guid);
        } else {
          showToastMsg(response['message']);
        }
      }
    }
  }

  downloadPdf(String url, String guid) async {
    isLoading(true);

    try {
      var response = await _dio.get(url, onReceiveProgress: (i, j) {
        debugPrint('i -- $i, j -- $j');
      },
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return (status ?? 501) < 500;
              }));

      File file =
          File(p.join(reportPath, FOLDER_GC, FOLDER_REPORT, '$guid.pdf'));
      file.createSync();
      var ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();

      viewReport(guid);
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading(false);
  }

  Future<bool> checkFileIsExist(String guid) async {
    return File(p.join(reportPath, FOLDER_GC, FOLDER_REPORT, '$guid.pdf'))
        .exists();
  }

  viewReport(String guid) async {
    final String filePath =
        p.join(reportPath, FOLDER_GC, FOLDER_REPORT, '$guid.pdf');
    final Uri uri = Uri.file(filePath);

    if (!File(uri.toFilePath()).existsSync()) {
      showToastMsg('File Not Found');
      throw '$uri does not exist!';
    }
    try {
      await launchUrl(uri);
    } catch (e) {
      showToastMsg('Could not open at this moment');
    }
  }
}
