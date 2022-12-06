import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vms/helper/utils.dart';
import 'package:vms/model/building.dart';
import 'package:vms/model/company_response.dart';
import 'package:vms/model/dashboard_detail_response.dart';
import 'package:vms/model/invite_visitor_list_response.dart';
import 'package:vms/model/location_response.dart';
import 'package:vms/model/login_response.dart';
import 'package:vms/model/proof.dart';
import 'package:vms/model/purpose.dart';
import 'package:vms/model/tenant.dart';
import 'package:vms/model/vehicle.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/model/visitor_detail_response.dart';
import 'package:vms/networks/urls.dart';

var head = {
  "content-type": "application/json",
};


Future<LoginResponse?> getLoginDetails(String userName, String password, String token) async {
  Map<String, String> params = {
    'username': userName,
    'password': password,
  };

  var uri = Uri.https(BASE_URL, loginApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return LoginResponse.fromJsonMap(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<dynamic> getClientLoginDetails(String userName, String password, String token) async {
  Map<String, String> params = {
    'username': userName,
    'password': password,
  };

  var uri = Uri.https(BASE_URL, clientLoginApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<InviteVisitorListResponse?> getClientVisitorList(String tenantLoginId) async {
  Map<String, String> params = {
    'Tenantloginid': tenantLoginId,
  };

  var uri = Uri.https(BASE_URL, clientVisitorListApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return InviteVisitorListResponse.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<CompanyResponse?> getCompanyDetails(int userId) async {
  Map<String, String> params = {
    'userid': userId.toString(),
  };

  var uri = Uri.https(BASE_URL, companyApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return CompanyResponse.fromJsonMap(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<LocationResponse?> getLocationDetails(String userId, String companyId) async {
  Map<String, String> params = {
    'userid': userId,
    'companyid': companyId,
  };

  var uri = Uri.https(BASE_URL, locationApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return LocationResponse.fromJsonMap(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<QRCodeResponse?> getClientVisitorDetails(String qrcode) async {
  Map<String, String> params = {
    'QRCode': qrcode,
  };

  var uri = Uri.https(BASE_URL, clientVisitorDetailApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return QRCodeResponse.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<dynamic> getGateDetails(String locId) async {
  Map<String, String> params = {
    'locationID': locId,
  };

  var uri = Uri.https(BASE_URL, gateApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<dynamic> getDashboard(String cid, String lid,String gid) async {
  Map<String, String> params = {
    'companyid': cid,
    'locationid': lid,
    'gateid': gid,
  };

  var uri = Uri.https(BASE_URL, dashboardApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<DashboardDetailResponse?> getDashboardDetail(String cid, String lid,String gid,String did) async {
  Map<String, String> params = {
    'companyid': cid,
    'locationid': lid,
    'gateid': gid,
    'id': did,
  };

  var uri = Uri.https(BASE_URL, dashboardDetailApi, params);
  var response = await http.get(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return DashboardDetailResponse.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<dynamic> resendSms(String cid, String barcode,String mobileno, String name) async {
  Map<String, String> params = {
    'CustomerspecId': cid,
    'barcode': barcode,
    'mobileNo': mobileno,
    'visitorName': name,
  };

  var uri = Uri.https(BASE_URL, sendSmsApi, params);
  var response = await http.post(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<dynamic> clientResendSms(String barcode) async {
  Map<String, String> params = {
    'QRCode': barcode,
  };

  var uri = Uri.https(BASE_URL, clientSendSmsApi, params);
  var response = await http.post(uri, headers: head);

  print(
      '${response.request?.url}\n${response.statusCode}\n$params\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<Proof?> getProofList() async {
  var uri = Uri.https(BASE_URL, proofApi);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return Proof.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<Purpose?> getPurposeList() async {
  var uri = Uri.https(BASE_URL, purposeApi);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return Purpose.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<Vehicle?> getVehicleList() async {
  var uri = Uri.https(BASE_URL, vehTypeApi);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<Tenant?> getTenantList(String locid) async {
  Map<String, String> params = {
    'locationID': locid,
  };

  var uri = Uri.https(BASE_URL, meetLocationApi, params);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return Tenant.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<Building?> getBuildingList(String tid, String lid) async {
  Map<String, String> params = {
    'tenantID': tid,
    'locationID': lid,
  };
  var uri = Uri.https(BASE_URL, meetBuildingApi, params);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return Building.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<dynamic> savePass(Visitor visitor) async {
  try {
    var uri = Uri.https(BASE_URL, savePassApi);
    final response =
        await http.post(uri, body: jsonEncode(visitor), headers: head);

    print('${response.request?.url}\n${response.statusCode}\n${response.body}');

    if (response.statusCode <= 205) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to generate pass');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<dynamic> saveClient(var body) async {
  try {
    var uri = Uri.https(BASE_URL, saveClientApi);
    final response =
    await http.post(uri, body: jsonEncode(body), headers: head);

    print('${response.request?.url}\n${response.statusCode}\n${response.body}');

    if (response.statusCode <= 205) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to generate pass');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<dynamic> passOut(
  String passsid,
  String locid,
) async {
  Map<String, String> params = {
    'Passid': passsid,
    'locationid': locid,
  };

  var uri = Uri.https(BASE_URL, passLogoutApi, params);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<dynamic> checkVisitor(String mobileno, String locid) async {
  Map<String, String> params = {
    'VisitorPhoneno': mobileno,
    'locationid': locid,
  };

  var uri = Uri.https(BASE_URL, passGetApi, params);
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<dynamic> getAppVersion() async {

  var uri = Uri.https(BASE_URL, 'appversion.json', );
  var response = await http.get(uri, headers: head);

  print('${response.request?.url}\n${response.statusCode}\n${response.body}');

  if (response.statusCode <= 205) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}
