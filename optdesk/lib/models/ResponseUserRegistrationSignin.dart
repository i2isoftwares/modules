// To parse this JSON data, do
//
//     final userRegistrationSignin = userRegistrationSigninFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserRegistrationSignin userRegistrationSigninFromJson(String str) => UserRegistrationSignin.fromJson(json.decode(str));

String userRegistrationSigninToJson(UserRegistrationSignin data) => json.encode(data.toJson());

class UserRegistrationSignin {
  UserRegistrationSignin({
    @required this.status,
    @required this.showQa,
    @required this.message,
    @required this.returnData,
    @required this.method,
    @required this.sessionId,
    @required this.id,
    @required this.isshow,
    @required this.data,
    @required this.isOtp,
  });

  bool? status;
  bool? showQa;
  String? message;
  String? returnData;
  String? method;
  String? sessionId;
  String? id;
  dynamic isshow;
  int? data;
  dynamic isOtp;

  factory UserRegistrationSignin.fromJson(Map<String, dynamic> json) => UserRegistrationSignin(
    status: json["Status"] == null ? null : json["Status"],
    showQa: json["ShowQa"] == null ? null : json["ShowQa"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : json["ReturnData"],
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
    isshow: json["isshow"],
    data: json["data"] == null ? null : json["data"],
    isOtp: json["isOTP"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "ShowQa": showQa == null ? null : showQa,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : returnData,
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
    "isshow": isshow,
    "data": data == null ? null : data,
    "isOTP": isOtp,
  };
}
