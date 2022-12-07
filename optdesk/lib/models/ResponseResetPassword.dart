// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPassword resetPasswordFromJson(String str) => ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  ResetPassword({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  bool status;
  String message;
  String returnData;
  String method;
  String sessionId;
  String id;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    status: json["Status"],
    message: json["Message"],
    returnData: json["ReturnData"],
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": returnData,
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}
