// To parse this JSON data, do
//
//     final pandemicQnsAnsDetails = pandemicQnsAnsDetailsFromJson(jsonString);

import 'dart:convert';

PandemicQnsAnsDetails pandemicQnsAnsDetailsFromJson(String str) => PandemicQnsAnsDetails.fromJson(json.decode(str));

String pandemicQnsAnsDetailsToJson(PandemicQnsAnsDetails data) => json.encode(data.toJson());

class PandemicQnsAnsDetails {
  PandemicQnsAnsDetails({
    this.status,
    this.showQa,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
    this.isshow,
    this.data,
  });

  bool? status;
  bool? showQa;
  String? message;
  dynamic returnData;
  String? method;
  String? sessionId;
  String? id;
  dynamic isshow;
  int? data;

  factory PandemicQnsAnsDetails.fromJson(Map<String, dynamic> json) => PandemicQnsAnsDetails(
    status: json["Status"] == null ? null : json["Status"],
    showQa: json["ShowQa"] == null ? null : json["ShowQa"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"],
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
    isshow: json["isshow"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "ShowQa": showQa == null ? null : showQa,
    "Message": message == null ? null : message,
    "ReturnData": returnData,
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
    "isshow": isshow,
    "data": data == null ? null : data,
  };
}
