// To parse this JSON data, do
//
//     final confirmationBooking = confirmationBookingFromJson(jsonString);

import 'dart:convert';

ConfirmationBooking confirmationBookingFromJson(String str) => ConfirmationBooking.fromJson(json.decode(str));

String confirmationBookingToJson(ConfirmationBooking data) => json.encode(data.toJson());

class ConfirmationBooking {
  ConfirmationBooking({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  late bool status;
  late String message;
  late ReturnData returnData;
  late String method;
  late String sessionId;
  late String id;
  factory ConfirmationBooking.fromJson(Map<String, dynamic> json) => ConfirmationBooking(
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
    "ReturnData":returnData.toJson(),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}

class ReturnData {
  ReturnData({
    required this.confirmationDetails,
  });

  late List<ConfirmationDetail> confirmationDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    confirmationDetails:List<ConfirmationDetail>.from(json["ConfirmationDetails"].map((x) => ConfirmationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ConfirmationDetails":List<dynamic>.from(confirmationDetails.map((x) => x.toJson())),
  };
}

class ConfirmationDetail {
  ConfirmationDetail({
    required this.companyName,
    required this.locationName,
    required this.buildingName,
    required this.floorName,
    this.wingName,
    required this.book,
  });

  late String companyName;
  late String locationName;
  late String buildingName;
  late String floorName;
  dynamic wingName;
  late List<Book> book;

  factory ConfirmationDetail.fromJson(Map<String, dynamic> json) => ConfirmationDetail(
    companyName: json["CompanyName"] ?? '',
    locationName: json["LocationName"] ?? '',
    buildingName: json["BuildingName"] ?? '',
    floorName: json["FloorName"] ?? '',
    wingName: json["WingName"] ?? '',
    book: List<Book>.from(json["book"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CompanyName": companyName ?? '',
    "LocationName": locationName ?? '',
    "BuildingName": buildingName ?? '',
    "FloorName": floorName ?? '',
    "WingName": wingName ?? '',
    "book": List<dynamic>.from(book.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    required this.date,
    required this.startTime,
    required this.toTime,
    required this.workstationId,
    required this.workstationName,
  });

  late DateTime date;
  late String startTime;
  late  String toTime;
  late int workstationId;
  late String workstationName;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    date: DateTime.parse(json["Date"]),
    startTime: json["StartTime"],
    toTime: json["ToTime"],
    workstationId: json["WorkstationId"],
    workstationName: json["WorkstationName"],
  );

  Map<String, dynamic> toJson() => {
    "Date":"${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "StartTime": startTime,
    "ToTime": toTime,
    "WorkstationId": workstationId,
    "WorkstationName": workstationName,
  };
}
