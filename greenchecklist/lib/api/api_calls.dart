import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:greenchecklist/helpers/utils.dart';
import 'package:greenchecklist/model/dashboard_response.dart';
import 'package:greenchecklist/model/ticket_detail_response.dart';

import '../model/all_tickets_response.dart';
import '../model/user_response.dart';
import 'urls.dart';

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();
  final Dio _dio = Dio();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = baseUrl;
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    // const DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings(
    //   requestSoundPermission: true,
    //   requestBadgePermission: true,
    //   requestAlertPermission: true,
    // );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,);

    flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  sendErrorNotification(String msg,
      {String title = 'Something wrong', int notId = 108}) {
    AndroidNotificationDetails notificationDetails = AndroidNotificationDetails(
        'greenchecklist', 'greenchecklist',
        channelDescription: 'greenchecklist notification channel',
        styleInformation: BigTextStyleInformation(msg),
        importance: Importance.max,
        priority: Priority.high,
        groupKey: 'greenchecklist');
    NotificationDetails notificationDetailsPlatformSpecifics =
        NotificationDetails(android: notificationDetails);

    flutterLocalNotificationPlugin.show(
      notId,
      title,
      msg,
      notificationDetailsPlatformSpecifics,
    );
  }

  Future<dynamic> getSecureKey() async {
    final response = await _dio.get(
      secureKeyApi,
    );

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<UserResponse?> checkLogin(String userName, String password) async {
    var params = {
      "username": encryptString(userName),
      "password": encryptString(password)
    };
    log('${params.toString()} ${_dio.options.baseUrl} $loginApi');
    
    final response = await _dio.post(loginApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return UserResponse.fromJson(response.data);
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> logout(String token, String userId) async {
    var params = {"token": token, "userid": userId};
    final response = await _dio.post(logoutApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> checkLeaveByDepartment(params) async {
    final response = await _dio.post(checkLeaveApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> checkIsHaveOnlineRecord(params) async {
    final response = await _dio.post(onlineCheckApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getDepartments(params) async {
    try {
      final response = await _dio.post(departmentApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getBarcodes(params) async {
    try {
      final response = await _dio.post(barcodeApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getQuestions(var params) async {
    try {
      final response = await _dio.post(questionApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getScores(params) async {
    try {
      final response = await _dio.post(scoreApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getTemplates(params) async {
    try {
      final response = await _dio.post(templateApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getTemplateDetails(params) async {
    try {
      final response = await _dio.post(templateDetailApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getParameters(params) async {
    try {
      final response = await _dio.post(parameterApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getSubParameters(params) async {
    try {
      final response = await _dio.post(subParameterApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //helpdesk
  Future<AllTicketsResponse?> getTickets(var params) async {
    var dio = Dio();
    dio.options.baseUrl = "https://ifazig.com/ClientHelpdesk/api/";

    log('${dio.options.baseUrl} Get_Dahboarddetails ${jsonEncode(params)}');
    try {
      final response =
          await dio.get('Get_Dahboarddetails', queryParameters: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return AllTicketsResponse.fromJson(response.data);
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<TicketDetailsResponse?> getTicketDetails(var params) async {
    var dio = Dio();
    dio.options.baseUrl = "https://ifazig.com/ClientHelpdesk/api/";

    log('${dio.options.baseUrl} Get_TicketsByStatus ${jsonEncode(params)}');
    try {
      final response =
          await dio.get('Get_TicketsByStatus', queryParameters: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return TicketDetailsResponse.fromJson(response.data);
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<dynamic> getTicketHistory(String complaintId) async {
    var dio = Dio();
    dio.options.baseUrl =
        "https://ifazig.com/HelpdeskAPI_RESTNew/Api/Dashboard/";
    var params = {'complaintId': complaintId};

    try {
      log('${dio.options.baseUrl} GetTicketHistory ${jsonEncode(params)}');
      final response =
          await dio.get('GetTicketHistory', queryParameters: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      sendErrorNotification(e.toString());
      return null;
    }
  }

  getHelpdeskDetail(params) async {
    var dio = Dio();
    dio.options.baseUrl = "https://ifazig.com/ClientHelpdesk/api/";
    log('${dio.options.baseUrl}{$helpdeskDetailApi} ${jsonEncode(params)}');
    try {
      final response = await dio.post(helpdeskDetailApi, data: params);

      log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
      if ((response.statusCode ?? -1) <= 205) {
        return response.data;
      } else {
        sendErrorNotification(response.statusMessage ?? 'Error');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      sendErrorNotification(e.toString());
      return null;
    }
  }

  Future<dynamic> getCompanyList(params) async {
    final response = await _dio.post(companyApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getLocationList(params) async {
    final response = await _dio.post(locationApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getBuildingList(params) async {
    final response = await _dio.post(buildingApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getFloorList(params) async {
    final response = await _dio.post(floorApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getWingList(params) async {
    final response = await _dio.post(wingApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<DashboardResponse?> getDashboardChecklist(params) async {
    final response = await _dio.post(dashboardChecklistApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return DashboardResponse.fromJson(response.data);
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<DashboardResponse?> getDashboardLogsheet(params) async {
    final response = await _dio.post(dashboardLogsheetApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return DashboardResponse.fromJson(response.data);
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getChecklistDetail(params) async {
    final response = await _dio.post(dashboardChecklistDetailApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getCheckDownloadableLink(params) async {
    final response = await _dio.post(dashboardChecklistPdfApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getLogsheetDetail(params) async {
    final response = await _dio.post(dashboardLogsheetDetailApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getLogDownloadableLink(params) async {
    final response = await _dio.post(dashboardLogsheetPdfApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getTodosChecklist(params) async {
    final response = await _dio.post(todoChecklistApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  Future<dynamic> getTodosLogsheet(params) async {
    final response = await _dio.post(todoLogsheetApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  submitChecklist(params) async {
    final response = await _dio.post(submitChecklistApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }

  submitLogsheet(params) async {
    final response = await _dio.post(submitLogsheetApi, data: params);

    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${jsonEncode(params)}\n${response.statusCode}\n${response.data}');
    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      sendErrorNotification(response.statusMessage ?? 'Error');
      return null;
    }
  }
}
