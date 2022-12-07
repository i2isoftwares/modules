import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/api/url_utils.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseBookingHistory.dart';
import 'package:optdesk/models/ResponseCancelBooking.dart';
import 'package:optdesk/models/ResponseCancelHistory.dart';
import 'package:optdesk/models/ResponseConfirmationBooking.dart';
import 'package:optdesk/models/ResponseEmailVerification.dart';
import 'package:optdesk/models/ResponseGetQuestions.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponseMultipleSave.dart';
import 'package:optdesk/models/ResponseMultipleTimeValidation.dart';
import 'package:optdesk/models/ResponsePandemicQnsAnsDetails.dart';
import 'package:optdesk/models/ResponseResetPassword.dart';
import 'package:optdesk/models/ResponseSettingDetails.dart';
import 'package:optdesk/models/ResponseUpdateLogOff.dart';
import 'package:optdesk/models/ResponseUserList.dart';
import 'package:optdesk/models/ResponseUserRegistrationSignin.dart';

import '../models/response_check_booking.dart';

Future<ResponseLogin> getLoginDetail(
    String email, String password, BuildContext context,
    {String? userId,
    String? companyId,
    String? roleId,
    String? locationId,
    String? buildingId,
    String? floorId,
    String? departmentId}) async {
  Map<String, String> body = {
    'username': email,
    'pwd': password,
    'UserId': userId ?? "0",
    'CompanyId': companyId ?? "0",
    'RoleId': roleId ?? "0",
    'LocationId': locationId ?? "0",
    'BuildingId': buildingId ?? "0",
    'FloorId': floorId ?? "0",
    'DeparmentID': departmentId ?? "0",
  };
  //print(body);
  final uri = Uri.http(URL, URL_LOGIN, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return ResponseLogin.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<SettingDetails> getSettingDetails(String companyId, String roleId,
    String locationId, String userId, BuildContext context) async {
  Map<String, String> body = {
    'companyid': companyId,
    'locationid': locationId,
    'UserId': userId,
    'RoleId': roleId,
  };
  print(body);
  final uri = Uri.http(URL, URL_SettingDetails, body);

  var dio = Dio();
  dio.options.connectTimeout = 70000;
  print(uri);
  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return SettingDetails.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<MultipleTimeValidation> postMultipleTimeValidation(
    String companyId,
    String floorId,
    String roleId,
    String locationId,
    String userId,
    List<Map<String, String>> book,
    String departmentId,
    BuildContext context) async {
  Map<String, dynamic> body = {
    'Companyid': companyId,
    'FloorId': floorId,
    'Locationid': locationId,
    'UserId': userId,
    'RoleId': roleId,
    'Book': book,
    'DepartmentID': departmentId,
  };

  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_MULTIPLE_TIME_VALIDATION,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return MultipleTimeValidation.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }

//  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//  final response = await http.post(URL_MULTIPLE_TIME_VALIDATION, body: json.encode(body), headers: headers);
//  print('${response.request.url}\n${response.statusCode}\n$body\n${response.body}');
//  Utils.hideLoader();
//  if (response.statusCode <= 205) {
//    final responseJson = json.decode(response.body);
//    return MultipleTimeValidation.fromJson(responseJson);
//  } else {
//    showToastMsg("Something went wrong!");
//    return null;
//  }
}

Future<ConfirmationBooking> postConfirmBooking(
    String companyId,
    String floorId,
    String buildingId,
    String roleId,
    String locationId,
    String userId,
    List<Map<String, String>> book,
    BuildContext context) async {
  Map<String, dynamic> body = {
    'Companyid': companyId,
    'Locationid': locationId,
    'BuildingId': buildingId,
    'FloorId': floorId,
    'UserId': userId,
    'RoleId': roleId,
    'Book': book,
  };

  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_CONFIRMATION_BOOKING,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return ConfirmationBooking.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<MultipleSave> postMultipleSave(
    String bookedForUser,
    String companyId,
    String floorId,
    String buildingId,
    String roleId,
    String locationId,
    String userId,
    List<Map<String, String>> book,
    String foodPreference,
    BuildContext context) async {
  Map<String, dynamic> body;

  if (foodPreference == '') {
    body = {
      'BookedforUser': bookedForUser,
      'Companyid': companyId,
      'Locationid': locationId,
      'BuildingId': buildingId,
      'FloorId': floorId,
      'UserId': userId,
      'RoleId': roleId,
      'Book': book,
    };
  } else {
    body = {
      'BookedforUser': bookedForUser,
      'Companyid': companyId,
      'Locationid': locationId,
      'BuildingId': buildingId,
      'FloorId': floorId,
      'UserId': userId,
      'RoleId': roleId,
      'Book': book,
      'Foodpreference': foodPreference,
    };
  }

  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_MULTIPLE_SAVE,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return MultipleSave.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<BookingHistory> getBookingHistory(
    String userId, String userRoleId, BuildContext context) async {
  Map<String, String> body = {
    'UserId': userId,
    'userroleid': userRoleId,
  };

  final uri = Uri.http(URL, URL_BookingHistory, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return BookingHistory.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }

//  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//
//  print(uri);
//  final response = await http.get(uri, headers: headers);
//
//  print('${response.request.url}\n${response.statusCode}\n$body\n${response.body}');
//  Utils.hideLoader();
//  if (response.statusCode <= 205) {
//    final responseJson = json.decode(response.body);
//    return BookingHistory.fromJson(responseJson);
//  } else {
//    showToastMsg("Something went wrong!");
//    return null;
//  }
}

Future<UserList> getUserList(String companyId, BuildContext context) async {
  Map<String, String> body = {
    'companyid': companyId,
  };

  final uri = Uri.http(URL, URL_GET_USER_LIST, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return UserList.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<CancelHistory> postCancelHistory(
    String userId, String roleId, BuildContext context) async {
  Map<String, String> body = {
    'UserId': userId,
    'Roleid': roleId,
  };

  final uri = Uri.http(URL, URL_CancelHistory, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return CancelHistory.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<EmailVerification> postEmailVerification(
    String emailId, String isReset, BuildContext context) async {
  Map<String, String> body = {
    'EmailID': emailId,
    'isreset': isReset,
  };

  final uri = Uri.http(URL, URL_EmailVerification, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return EmailVerification.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<ResetPassword> postResetPassword(
    String emailId, String password, BuildContext context) async {
  Map<String, String> body = {
    'EmailId': emailId,
    'Pwd': password,
  };

  final uri = Uri.http(URL, URL_ResetPassword, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return ResetPassword.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<EmailVerification> postUserRegistration(String fName, String lName,
    String mobile, String email, String password, BuildContext context) async {
  Map<String, String> body = {
    'UserID': '0',
    'FirstName': fName,
    'LastName': lName,
    'CompanyID': '0',
    'LocationID': '0',
    'PhoneNumber': mobile,
    'MobileNumber': '0',
    'EmailID': email,
    'Password': password,
    'CUID': '0',
    'CDate': '',
    'MUID': '0',
    'MDate': '',
    'UserToken': '',
    'isdelete': '0',
    'CompanyName': '',
    'LocationName': '',
  };

  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_UserRegistration,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return EmailVerification.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<UserRegistrationSignin> postUserRegistrationSignin(String fName,
    String lName, String mobile, String email, BuildContext context) async {
  Map<String, String> body = {
    "UserID": '0',
    "FirstName": fName,
    "LastName": lName,
    "CompanyID": '0',
    "LocationID": '0',
    "PhoneNumber": mobile,
    "MobileNumber": '0',
    "EmailID": email,
    "Password": "string",
    "UserToken": "string",
    "isdelete": '0',
    "CompanyName": "string",
    "LocationName": "string"
  };

  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_UserRegistrationSignin,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return UserRegistrationSignin.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<UserRegistrationSignin> postSaveRegPassword(
    String token, String password, BuildContext context) async {
  Map<String, String> body = {
    "usertoken": token,
    "Pwd": password,
  };

  final uri = Uri.http(URL, URL_SaveRegPassword, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return UserRegistrationSignin.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<UserRegistrationSignin> postForgetPasswordSignIn(
    String email, BuildContext context) async {
  Map<String, String> body = {
    "Emailid": email,
  };

  final uri = Uri.http(URL, URL_ForgetPasswordSignIn, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return UserRegistrationSignin.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<EmailVerification> postOtpRequest(
    String phoneNumber, String userName, BuildContext context) async {
  Map<String, String> body = {
    'Phonenumber': phoneNumber,
    'UserName': userName,
  };

  final uri = Uri.http(URL, URL_OTPRequest, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return EmailVerification.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<EmailVerification> getOtpForSignIn(
    String email, BuildContext context) async {
  Map<String, String> body = {
    'Email': email,
  };

  final uri = Uri.http(URL, URL_GetOtpForSignIn, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return EmailVerification.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<EmailVerification> getInsertSignIn(
    String email, String userId, String roleId, BuildContext context) async {
  Map<String, String> body = {
    'Email': email,
    'userid': userId,
    'roleid': roleId,
  };

  final uri = Uri.http(URL, URL_GetInsertSignIn, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return EmailVerification.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

// Future<CancelBooking> postCancelBooking(String roleId,String userId,
//     String floorMapBookingId, String isCancel,
//     String qrCode,   BuildContext context) async {

Future<CancelBooking> postCancelBooking(
    String floorMapBookingId,
    String isCancel,
    String qrCode,
    String userId,
    String roleId,
    BuildContext context) async {
  Map<String, String> body = {
    'FloorMapBookingId': floorMapBookingId,
    'IsCancel': isCancel,
    'Qrcode': qrCode,
    'Userid': userId,
    'Roleid': roleId,
  };

  final uri = Uri.http(URL, URL_CancelBooking, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return CancelBooking.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

//This funtion is used for homepage scan
Future<ResponseCheckBooking> checkCancelBooking(String userId, String roleId,
    String workstationId, String emailId, BuildContext context) async {
  Map<String, String> body = {
    'userid': userId,
    'roleid': roleId,
    'Workstationid': workstationId,
    'emailid': emailId,
  };

  final uri = Uri.http(URL, URL_ChckCancelBooking, body);
  var dio = Dio();
  // dio.options.baseUrl=URL;
  dio.options.connectTimeout = 70000;

  try {
    print(URL_ChckCancelBooking);
    print(dio.options.baseUrl);
    print(jsonEncode(body));
    var response = await dio.getUri(
      uri,
    );
    Utils.hideLoader();
    print(response.statusCode);
    print(response.statusMessage);
    print(response.toString());
    print(response.data);
    return ResponseCheckBooking.fromJson(response.data);
    // return null;
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<GetQuestions> getQuestions(
    String companyId, BuildContext context) async {
  Map<String, String> body = {
    'CompId': companyId,
  };

  final uri = Uri.http(URL, URL_GET_QUESTIONS, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.getUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return GetQuestions.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<PandemicQnsAnsDetails> postQnsAnsDetails(
    Map<String, dynamic> body, BuildContext context) async {
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.post(URL_PandemicQnsAnsDetails,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: json.encode(body));
    Utils.hideLoader();
    return PandemicQnsAnsDetails.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}

Future<PandemicQnsAnsDetails?> postQnsAnsDetailsUpload(
    Map<String, dynamic> body, File file, BuildContext context) async {
  var dio = Dio();
  FormData formData;
  if (file != null) {
    String fileName = file.path.split('/').last;
    formData = FormData.fromMap({
      "Details": json.encode(body),
      "Filedata": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  } else {
    formData = FormData.fromMap({
      "Details": json.encode(body),
    });
  }
  var response =
      await dio.post(URL_PandemicQnsAnsDetailsUpload, data: formData);
  Utils.hideLoader();
  if ((response.statusCode ?? 500) <= 205) {
    return PandemicQnsAnsDetails.fromJson(response.data);
  } else {
    showToastMsg("Something went wrong!");
    return null;
  }
}

Future<UpdateLogOff> updateLogOff(String floorMapBookingId, String userId,
    String logOffTime, BuildContext context) async {
  Map<String, String> body = {
    'FloorMapBookingId': floorMapBookingId,
    'userid': userId,
    'Logofftime': logOffTime,
  };

  final uri = Uri.http(URL, URL_UpdateLogOff, body);
  var dio = Dio();
  dio.options.connectTimeout = 70000;

  try {
    var response = await dio.postUri(uri,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Utils.hideLoader();
    return UpdateLogOff.fromJson(response.data);
  } catch (e) {
    Utils.hideLoader();
    showToastMsg("Something went wrong!");
    throw Exception(e.toString());
  }
}
