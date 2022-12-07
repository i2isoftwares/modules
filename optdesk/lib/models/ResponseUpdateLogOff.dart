// To parse this JSON data, do
//
//     final updateLogOff = updateLogOffFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateLogOff updateLogOffFromJson(String str) => UpdateLogOff.fromJson(json.decode(str));

String updateLogOffToJson(UpdateLogOff data) => json.encode(data.toJson());

class UpdateLogOff {
  UpdateLogOff({
    required this.status,
    required this.showQa,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
    required this.isshow,
    required this.data,
    required this.isOtp,
    required this.isfeedback,
  });

  bool status;
  bool showQa;
  String message;
  String returnData;
  String method;
  String sessionId;
  String id;
  dynamic isshow;
  int data;
  dynamic isOtp;
  int isfeedback;

  factory UpdateLogOff.fromJson(Map<String, dynamic> json) => UpdateLogOff(
    status: json["Status"],
    showQa: json["ShowQa"],
    message: json["Message"],
    returnData: json["ReturnData"],
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
    isshow: json["isshow"],
    data: json["data"],
    isOtp: json["isOTP"],
    isfeedback: json["isfeedback"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "ShowQa": showQa,
    "Message": message,
    "ReturnData": returnData,
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
    "isshow": isshow,
    "data": data,
    "isOTP": isOtp,
    "isfeedback": isfeedback,
  };
}
