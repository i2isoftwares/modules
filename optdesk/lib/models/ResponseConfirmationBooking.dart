// To parse this JSON data, do
//
//     final confirmationBooking = confirmationBookingFromJson(jsonString);

import 'dart:convert';

ConfirmationBooking confirmationBookingFromJson(String str) => ConfirmationBooking.fromJson(json.decode(str));

String confirmationBookingToJson(ConfirmationBooking data) => json.encode(data.toJson());

class ConfirmationBooking {
  ConfirmationBooking({
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

  factory ConfirmationBooking.fromJson(Map<String, dynamic> json) => ConfirmationBooking(
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
    this.confirmationDetails,
  });

  List<ConfirmationDetail> confirmationDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    confirmationDetails: json["ConfirmationDetails"] == null ? null : List<ConfirmationDetail>.from(json["ConfirmationDetails"].map((x) => ConfirmationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ConfirmationDetails": confirmationDetails == null ? null : List<dynamic>.from(confirmationDetails.map((x) => x.toJson())),
  };
}

class ConfirmationDetail {
  ConfirmationDetail({
    this.companyName,
    this.locationName,
    this.buildingName,
    this.floorName,
    this.wingName,
    this.book,
  });

  String? companyName;
  String? locationName;
  String? buildingName;
  String? floorName;
  dynamic wingName;
  List<Book>? book;

  factory ConfirmationDetail.fromJson(Map<String, dynamic> json) => ConfirmationDetail(
    companyName: json["CompanyName"] == null ? '' : json["CompanyName"],
    locationName: json["LocationName"] == null ? '' : json["LocationName"],
    buildingName: json["BuildingName"] == null ? '' : json["BuildingName"],
    floorName: json["FloorName"] == null ? '' : json["FloorName"],
    wingName: json["WingName"] == null ? '' : json["WingName"],
    book: json["book"] == null ? null : List<Book>.from(json["book"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CompanyName": companyName == null ? '' : companyName,
    "LocationName": locationName == null ? '' : locationName,
    "BuildingName": buildingName == null ? '' : buildingName,
    "FloorName": floorName == null ? '' : floorName,
    "WingName": wingName == null ? '' : wingName,
    "book": book == null ? null : List<dynamic>.from(book.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    this.date,
    this.startTime,
    this.toTime,
    this.workstationId,
    this.workstationName,
  });

  DateTime? date;
  String? startTime;
  String? toTime;
  int? workstationId;
  String? workstationName;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    startTime: json["StartTime"] == null ? null : json["StartTime"],
    toTime: json["ToTime"] == null ? null : json["ToTime"],
    workstationId: json["WorkstationId"] == null ? null : json["WorkstationId"],
    workstationName: json["WorkstationName"] == null ? null : json["WorkstationName"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "StartTime": startTime == null ? null : startTime,
    "ToTime": toTime == null ? null : toTime,
    "WorkstationId": workstationId == null ? null : workstationId,
    "WorkstationName": workstationName == null ? null : workstationName,
  };
}
