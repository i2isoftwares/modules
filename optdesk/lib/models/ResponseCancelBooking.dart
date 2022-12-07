// To parse this JSON data, do
//
//     final cancelBooking = cancelBookingFromJson(jsonString);

import 'dart:convert';

CancelBooking cancelBookingFromJson(String str) => CancelBooking.fromJson(json.decode(str));

String cancelBookingToJson(CancelBooking data) => json.encode(data.toJson());

class CancelBooking {
  CancelBooking({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });


  late bool status;
  late String message;
  List<dynamic>? returnData;
  late String method;
  late String sessionId;
  late String id;

  factory CancelBooking.fromJson(Map<String, dynamic> json) => CancelBooking(
    status: json["Status"],
    message: json["Message"],
    returnData: json["ReturnData"] == null ? null : List<dynamic>.from(json["ReturnData"].map((x) => x)),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": returnData == null ? null : List<dynamic>.from(returnData!.map((x) => x)),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}
