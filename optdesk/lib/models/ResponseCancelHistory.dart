// To parse this JSON data, do
//
//     final cancelHistory = cancelHistoryFromJson(jsonString);

import 'dart:convert';

CancelHistory cancelHistoryFromJson(String str) => CancelHistory.fromJson(json.decode(str));

String cancelHistoryToJson(CancelHistory data) => json.encode(data.toJson());

class CancelHistory {
  CancelHistory({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  late bool status;
  late String message;
  late List<ReturnDatum> returnData;
  late String method;
  late String sessionId;
  late String id;


  factory CancelHistory.fromJson(Map<String, dynamic> json) => CancelHistory(
    status: json["Status"],
    message: json["Message"],
    returnData: List<ReturnDatum>.from(json["ReturnData"].map((x) => ReturnDatum.fromJson(x))),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": List<dynamic>.from(returnData.map((x) => x.toJson())),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}

class ReturnDatum {
  ReturnDatum({
    required this.floorMapBookingId,
    required this.workStationId,
    required this.workStationName,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.cancelTime,
    required this.floorId,
    required this.floorName,
    required this.companyId,
    required this.companyName,
    required this.locationId,
    required this.locationName,
    required this.buildingId,
    required this.buildingName,
  });

  late int floorMapBookingId;
  late int workStationId;
  late String workStationName;
  late String startTime;
  late String endTime;
  late String startDate;
  late String endDate;
  late DateTime cancelTime;
  late int floorId;
  late String floorName;
  late int companyId;
  late String companyName;
  late int locationId;
  late String locationName;
  late int buildingId;
  late String buildingName;

  factory ReturnDatum.fromJson(Map<String, dynamic> json) => ReturnDatum(
    floorMapBookingId: json["FloorMapBookingId"],
    workStationId: json["WorkStationId"],
    workStationName: json["WorkStationName"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    cancelTime: DateTime.parse(json["CancelTime"]),
    floorId: json["FloorID"],
    floorName: json["FloorName"],
    companyId: json["CompanyId"],
    companyName: json["CompanyName"],
    locationId: json["LocationId"],
    locationName: json["LocationName"],
    buildingId: json["BuildingId"],
    buildingName: json["BuildingName"],
  );

  Map<String, dynamic> toJson() => {
    "FloorMapBookingId": floorMapBookingId,
    "WorkStationId": workStationId,
    "WorkStationName": workStationName,
    "StartTime": startTime,
    "EndTime": endTime,
    "StartDate": startDate,
    "EndDate": endDate,
    "CancelTime": cancelTime.toIso8601String(),
    "FloorID": floorId,
    "FloorName": floorName,
    "CompanyId": companyId,
    "CompanyName": companyName,
    "LocationId": locationId,
    "LocationName": locationName,
    "BuildingId": buildingId,
    "BuildingName": buildingName,
  };
}
