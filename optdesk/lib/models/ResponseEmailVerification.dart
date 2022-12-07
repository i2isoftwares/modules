// To parse this JSON data, do
//
//     final emailVerification = emailVerificationFromJson(jsonString);

import 'dart:convert';

EmailVerification emailVerificationFromJson(String str) => EmailVerification.fromJson(json.decode(str));

String emailVerificationToJson(EmailVerification data) => json.encode(data.toJson());

class EmailVerification {
  EmailVerification({
    this.status,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  dynamic returnData;
  String? method;
  String? sessionId;
  String? id;

  factory EmailVerification.fromJson(Map<String, dynamic> json) => EmailVerification(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : json["ReturnData"],
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : returnData,
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}
