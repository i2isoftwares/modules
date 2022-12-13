import 'dart:convert';

import 'package:greenchecklist/api/api_calls.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import '../../database/dao/checklist_transaction_dao.dart';
import '../../database/dao/logsheet_transaction_dao.dart';

typedef onCompleteFunc = Function();
typedef onErrorFunc = Function(String);

class SyncData {
  final ChecklistTransactionDao checklistDao;
  final LogsheetTransactionDao logsheetDao;
  final Map<String, dynamic> extraParams;
  final onCompleteFunc onComplete;
  final onErrorFunc errorFunc;

  SyncData(this.checklistDao, this.logsheetDao, this.extraParams,
      this.onComplete, this.errorFunc);

  execute() async {
    if (!await isNetConnected()) return;

    var checklists = await checklistDao.getAllChecklistTransaction();

    if (checklists.isNotEmpty) {
      ApiCall().sendErrorNotification('Checklist Upload progress',
          title: 'Checklist Upload', notId: 109);

      checklists.forEach((element) async {
        var params = element.toJson();
        params['checklists'] = jsonDecode(element.checklists);
        params['submitImages'] = jsonDecode(element.submitImages);
        params.addAll(extraParams);

        var response = await ApiCall().submitChecklist(params);
        if (response != null) {
          if (response['status']) {
            // var guid = response['result']['deviceguid'];
            checklistDao.updateChecklistTransaction(element.guid);
          } else {
            errorFunc(response['message']);
          }
        }
      });

      ApiCall().sendErrorNotification('Checklist Upload done',
          title: 'Checklist Upload', notId: 109);
    }

    checklistDao.updateIsSyncing();

    var logsheets = await logsheetDao.getAllLogsheetTransaction();

    if (logsheets.isNotEmpty) {
      ApiCall().sendErrorNotification('logsheet Upload progress',
          title: 'logsheet Upload', notId: 200);

      logsheets.forEach((element) async {
        var params = element.toJson();
        params['logsheets'] = jsonDecode(element.logsheets);
        params['submitImages'] = jsonDecode(element.submitImages);
        params.addAll(extraParams);

        var response = await ApiCall().submitLogsheet(params);
        if (response != null) {
          if (response['status']) {
            // var guid = response['result']['deviceguid'];
            logsheetDao.updateLogsheetTransaction(element.guid);
          } else {
            errorFunc(response['message']);
          }
        }
      });

      ApiCall().sendErrorNotification('logsheet Upload done',
          title: 'logsheet Upload', notId: 200);
    }

    logsheetDao.updateIsSyncing();

    onComplete();
  }
}
