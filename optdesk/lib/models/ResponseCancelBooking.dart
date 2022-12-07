// To parse this JSON data, do
//
//     final cancelBooking = cancelBookingFromJson(jsonString);

import 'dart:convert';

CancelBooking cancelBookingFromJson(String str) => CancelBooking.fromJson(json.decode(str));

String cancelBookingToJson(CancelBooking data) => json.encode(data.toJson());

class CancelBooking {
  CancelBooking({
    this.status,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  List<dynamic>? returnData;
  String? method;
  String? sessionId;
  String? id;

  factory CancelBooking.fromJson(Map<String, dynamic> json) => CancelBooking(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : List<dynamic>.from(json["ReturnData"].map((x) => x)),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : List<dynamic>.from(returnData.map((x) => x)),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}
