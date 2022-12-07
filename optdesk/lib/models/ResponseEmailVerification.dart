// To parse this JSON data, do
//
//     final emailVerification = emailVerificationFromJson(jsonString);

import 'dart:convert';

EmailVerification emailVerificationFromJson(String str) => EmailVerification.fromJson(json.decode(str));

String emailVerificationToJson(EmailVerification data) => json.encode(data.toJson());

class EmailVerification {
  EmailVerification({
    required this.status,
    required this.message,
    this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  late bool status;
  late String message;
  late dynamic returnData;
  late String method;
  late String sessionId;
  late String id;


  factory EmailVerification.fromJson(Map<String, dynamic> json) => EmailVerification(
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
