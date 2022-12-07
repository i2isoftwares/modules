// To parse this JSON data, do
//
//     final pandemicQnsAnsDetails = pandemicQnsAnsDetailsFromJson(jsonString);

import 'dart:convert';

PandemicQnsAnsDetails pandemicQnsAnsDetailsFromJson(String str) => PandemicQnsAnsDetails.fromJson(json.decode(str));

String pandemicQnsAnsDetailsToJson(PandemicQnsAnsDetails data) => json.encode(data.toJson());

class PandemicQnsAnsDetails {
  PandemicQnsAnsDetails({
    required this.status,
    required this.showQa,
    required this.message,
    this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
    this.isshow,
    required this.data,
  });

  bool status;
  bool showQa;
  String message;
  dynamic returnData;
  String method;
  String sessionId;
  String id;
  dynamic isshow;
  int data;

  factory PandemicQnsAnsDetails.fromJson(Map<String, dynamic> json) => PandemicQnsAnsDetails(
    status: json["Status"],
    showQa: json["ShowQa"],
    message: json["Message"],
    returnData: json["ReturnData"],
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
    isshow: json["isshow"],
    data: json["data"],
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
  };
}
