// To parse this JSON data, do
//
//     final multipleTimeValidation = multipleTimeValidationFromJson(jsonString);

import 'dart:convert';

MultipleTimeValidation multipleTimeValidationFromJson(String str) => MultipleTimeValidation.fromJson(json.decode(str));

String multipleTimeValidationToJson(MultipleTimeValidation data) => json.encode(data.toJson());

class MultipleTimeValidation {
  MultipleTimeValidation({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  bool status;
  String message;
  ReturnData returnData;
  String method;
  String sessionId;
  String id;

  factory MultipleTimeValidation.fromJson(Map<String, dynamic> json) => MultipleTimeValidation(
    status: json["Status"],
    message: json["Message"],
    returnData: ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": returnData == null ? null : returnData.toJson(),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}

class ReturnData {
  ReturnData({
    required this.validationWorkstation,
  });

  List<ValidationWorkstation> validationWorkstation;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    validationWorkstation:List<ValidationWorkstation>.from(json["ValidationWorkstation"].map((x) => ValidationWorkstation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ValidationWorkstation": validationWorkstation == null ? null : List<dynamic>.from(validationWorkstation.map((x) => x.toJson())),
  };
}

class ValidationWorkstation {
  ValidationWorkstation({
    required this.workstationList,
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
  });

  List<WorkstationList> workstationList;
  int id;
  String startTime;
  String endTime;
  DateTime date;

  factory ValidationWorkstation.fromJson(Map<String, dynamic> json) => ValidationWorkstation(
    workstationList: List<WorkstationList>.from(json["Workstationlist"].map((x) => WorkstationList.fromJson(x))),
    id: json["id"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    date:DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "Workstationlist": workstationList == null ? null : List<dynamic>.from(workstationList.map((x) => x.toJson())),
    "id": id,
    "StartTime": startTime,
    "EndTime": endTime,
    "Date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}

class WorkstationList {
  WorkstationList({
    required this.workstationId,
    required this.workstationName,
    required this.bookingStatus,
  });

  int workstationId;
  String workstationName;
  int bookingStatus;

  factory WorkstationList.fromJson(Map<String, dynamic> json) => WorkstationList(
    workstationId: json["WorkstationId"],
    workstationName: json["WorkstationName"],
    bookingStatus: json["BookingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "WorkstationId": workstationId,
    "WorkstationName": workstationName,
    "BookingStatus": bookingStatus,
  };
}
