// To parse this JSON data, do
//
//     final cancelHistory = cancelHistoryFromJson(jsonString);

import 'dart:convert';

CancelHistory cancelHistoryFromJson(String str) => CancelHistory.fromJson(json.decode(str));

String cancelHistoryToJson(CancelHistory data) => json.encode(data.toJson());

class CancelHistory {
  CancelHistory({
    this.status,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  List<ReturnDatum>? returnData;
  String? method;
  String? sessionId;
  String? id;

  factory CancelHistory.fromJson(Map<String, dynamic> json) => CancelHistory(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : List<ReturnDatum>.from(json["ReturnData"].map((x) => ReturnDatum.fromJson(x))),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : List<dynamic>.from(returnData.map((x) => x.toJson())),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}

class ReturnDatum {
  ReturnDatum({
    this.floorMapBookingId,
    this.workStationId,
    this.workStationName,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.cancelTime,
    this.floorId,
    this.floorName,
    this.companyId,
    this.companyName,
    this.locationId,
    this.locationName,
    this.buildingId,
    this.buildingName,
  });

  int? floorMapBookingId;
  int? workStationId;
  String? workStationName;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  DateTime? cancelTime;
  int? floorId;
  String? floorName;
  int? companyId;
  String? companyName;
  int? locationId;
  String? locationName;
  int? buildingId;
  String? buildingName;

  factory ReturnDatum.fromJson(Map<String, dynamic> json) => ReturnDatum(
    floorMapBookingId: json["FloorMapBookingId"] == null ? null : json["FloorMapBookingId"],
    workStationId: json["WorkStationId"] == null ? null : json["WorkStationId"],
    workStationName: json["WorkStationName"] == null ? null : json["WorkStationName"],
    startTime: json["StartTime"] == null ? null : json["StartTime"],
    endTime: json["EndTime"] == null ? null : json["EndTime"],
    startDate: json["StartDate"] == null ? null : json["StartDate"],
    endDate: json["EndDate"] == null ? null : json["EndDate"],
    cancelTime: json["CancelTime"] == null ? null : DateTime.parse(json["CancelTime"]),
    floorId: json["FloorID"] == null ? null : json["FloorID"],
    floorName: json["FloorName"] == null ? null : json["FloorName"],
    companyId: json["CompanyId"] == null ? null : json["CompanyId"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    locationId: json["LocationId"] == null ? null : json["LocationId"],
    locationName: json["LocationName"] == null ? null : json["LocationName"],
    buildingId: json["BuildingId"] == null ? null : json["BuildingId"],
    buildingName: json["BuildingName"] == null ? null : json["BuildingName"],
  );

  Map<String, dynamic> toJson() => {
    "FloorMapBookingId": floorMapBookingId == null ? null : floorMapBookingId,
    "WorkStationId": workStationId == null ? null : workStationId,
    "WorkStationName": workStationName == null ? null : workStationName,
    "StartTime": startTime == null ? null : startTime,
    "EndTime": endTime == null ? null : endTime,
    "StartDate": startDate == null ? null : startDate,
    "EndDate": endDate == null ? null : endDate,
    "CancelTime": cancelTime == null ? null : cancelTime.toIso8601String(),
    "FloorID": floorId == null ? null : floorId,
    "FloorName": floorName == null ? null : floorName,
    "CompanyId": companyId == null ? null : companyId,
    "CompanyName": companyName == null ? null : companyName,
    "LocationId": locationId == null ? null : locationId,
    "LocationName": locationName == null ? null : locationName,
    "BuildingId": buildingId == null ? null : buildingId,
    "BuildingName": buildingName == null ? null : buildingName,
  };
}
