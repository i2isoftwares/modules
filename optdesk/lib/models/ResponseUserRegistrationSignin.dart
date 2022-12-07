// To parse this JSON data, do
//
//     final userRegistrationSignin = userRegistrationSigninFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserRegistrationSignin userRegistrationSigninFromJson(String str) => UserRegistrationSignin.fromJson(json.decode(str));

String userRegistrationSigninToJson(UserRegistrationSignin data) => json.encode(data.toJson());

class UserRegistrationSignin {
  UserRegistrationSignin({
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

  factory UserRegistrationSignin.fromJson(Map<String, dynamic> json) => UserRegistrationSignin(
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
  };
}
