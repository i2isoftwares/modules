// To parse this JSON data, do
//
//     final multipleTimeValidation = multipleTimeValidationFromJson(jsonString);

import 'dart:convert';

MultipleTimeValidation multipleTimeValidationFromJson(String str) => MultipleTimeValidation.fromJson(json.decode(str));

String multipleTimeValidationToJson(MultipleTimeValidation data) => json.encode(data.toJson());

class MultipleTimeValidation {
  MultipleTimeValidation({
    this.status,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  ReturnData? returnData;
  String? method;
  String? sessionId;
  String? id;

  factory MultipleTimeValidation.fromJson(Map<String, dynamic> json) => MultipleTimeValidation(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : returnData.toJson(),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}

class ReturnData {
  ReturnData({
    this.validationWorkstation,
  });

  List<ValidationWorkstation> validationWorkstation;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    validationWorkstation: json["ValidationWorkstation"] == null ? null : List<ValidationWorkstation>.from(json["ValidationWorkstation"].map((x) => ValidationWorkstation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ValidationWorkstation": validationWorkstation == null ? null : List<dynamic>.from(validationWorkstation.map((x) => x.toJson())),
  };
}

class ValidationWorkstation {
  ValidationWorkstation({
    this.workstationList,
    this.id,
    this.startTime,
    this.endTime,
    this.date,
  });

  List<WorkstationList>? workstationList;
  int? id;
  String? startTime;
  String? endTime;
  DateTime? date;

  factory ValidationWorkstation.fromJson(Map<String, dynamic> json) => ValidationWorkstation(
    workstationList: json["Workstationlist"] == null ? null : List<WorkstationList>.from(json["Workstationlist"].map((x) => WorkstationList.fromJson(x))),
    id: json["id"] == null ? null : json["id"],
    startTime: json["StartTime"] == null ? null : json["StartTime"],
    endTime: json["EndTime"] == null ? null : json["EndTime"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "Workstationlist": workstationList == null ? null : List<dynamic>.from(workstationList.map((x) => x.toJson())),
    "id": id == null ? null : id,
    "StartTime": startTime == null ? null : startTime,
    "EndTime": endTime == null ? null : endTime,
    "Date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}

class WorkstationList {
  WorkstationList({
    this.workstationId,
    this.workstationName,
    this.bookingStatus,
  });

  int? workstationId;
  String? workstationName;
  int? bookingStatus;

  factory WorkstationList.fromJson(Map<String, dynamic> json) => WorkstationList(
    workstationId: json["WorkstationId"] == null ? null : json["WorkstationId"],
    workstationName: json["WorkstationName"] == null ? null : json["WorkstationName"],
    bookingStatus: json["BookingStatus"] == null ? null : json["BookingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "WorkstationId": workstationId == null ? null : workstationId,
    "WorkstationName": workstationName == null ? null : workstationName,
    "BookingStatus": bookingStatus == null ? null : bookingStatus,
  };
}
