// To parse this JSON data, do
//
//     final bookingHistory = bookingHistoryFromJson(jsonString);

import 'dart:convert';

BookingHistory bookingHistoryFromJson(String str) => BookingHistory.fromJson(json.decode(str));

String bookingHistoryToJson(BookingHistory data) => json.encode(data.toJson());

class BookingHistory {
  BookingHistory({
    required this.status,
    required this.showQa,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
    this.isshow,
    required this.data,
    this.isOtp,
  });

  late bool status;
  late bool showQa;
  late String message;
  late ReturnData returnData;
  late String method;
  late String sessionId;
  late String id;
  late dynamic isshow;
  late int data;
  late dynamic isOtp;

  factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
    status: json["Status"],
    showQa: json["ShowQa"],
    message: json["Message"],
    returnData: ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
    isshow: json["isshow"],
    data: json["data"],
    isOtp: json["isOTP"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "ShowQa": showQa,
    "Message": message,
    "ReturnData": returnData.toJson(),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
    "isshow": isshow,
    "data": data,
    "isOTP": isOtp,
  };
}

class ReturnData {
  ReturnData({
    required this.upcomingBookingHistory,
    required this.occupied,
    required this.pastBookingHistory,
  });

  late List<Occupied> upcomingBookingHistory;
  late List<Occupied> occupied;
  late List<Occupied> pastBookingHistory;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    upcomingBookingHistory: List<Occupied>.from(json["UpcomingBookingHistory"].map((x) => Occupied.fromJson(x))),
    occupied: List<Occupied>.from(json["Occupied"].map((x) => Occupied.fromJson(x))),
    pastBookingHistory: List<Occupied>.from(json["PastBookingHistory"].map((x) => Occupied.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UpcomingBookingHistory": List<dynamic>.from(upcomingBookingHistory.map((x) => x.toJson())),
    "Occupied": List<dynamic>.from(occupied.map((x) => x.toJson())),
    "PastBookingHistory": List<dynamic>.from(pastBookingHistory.map((x) => x.toJson())),
  };
}

class Occupied {
  Occupied({
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.floorMapBookingId,
    required this.book,
    required this.companyId,
    required this.companyName,
    required this.locationName,
    required this.buildingName,
    required this.floorName,
    this.wingName,
    required this.foodpreference,
    required this.floorid,
  });


  late String startTime;
  late String endTime;
  late String startDate;
  late String endDate;
  late int floorMapBookingId;
  late List<Book> book;
  late int companyId;
  late CompanyName? companyName;
  late LocationName? locationName;
  late BuildingName? buildingName;
  late FloorName? floorName;
  late dynamic wingName;
  late String foodpreference;
  late int floorid;
  factory Occupied.fromJson(Map<String, dynamic> json) => Occupied(
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    floorMapBookingId: json["FloorMapBookingId"],
    book: List<Book>.from(json["Book"].map((x) => Book.fromJson(x))),
    companyId: json["CompanyId"],
    companyName: companyNameValues.map[json["CompanyName"]],
    locationName: locationNameValues.map[json["LocationName"]],
    buildingName: buildingNameValues.map[json["BuildingName"]],
    floorName: floorNameValues.map[json["FloorName"]],
    wingName: json["WingName"],
    foodpreference: json["Foodpreference"],
    floorid: json["Floorid"],
  );



  Map<String, dynamic> toJson() => {
    "StartTime": startTime,
    "EndTime": endTime,
    "StartDate": startDate,
    "EndDate": endDate,
    "FloorMapBookingId": floorMapBookingId,
    "Book": List<dynamic>.from(book.map((x) => x.toJson())),
    "CompanyId": companyId,
    "CompanyName": companyNameValues.reverse[companyName],
    "LocationName": locationNameValues.reverse[locationName],
    "BuildingName": buildingNameValues.reverse[buildingName],
    "FloorName": floorNameValues.reverse[floorName],
    "WingName": wingName,
    "Foodpreference": foodpreference,
    "Floorid": floorid,
  };
}

class Book {
  Book({
    required this.date,
    required this.startTime,
    required this.toTime,
    required this.workstationId,
    required this.workstationName,
    required this.logofftime,
    required this.islogoff,
  });


  late String date;
  late String startTime;
  late String toTime;
  late int workstationId;
  late String workstationName;
  late String logofftime;
  late int islogoff;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    date: json["Date"],
    startTime: json["StartTime"],
    toTime: json["ToTime"],
    workstationId: json["WorkstationId"],
    workstationName: json["WorkstationName"],
    logofftime: json["Logofftime"],
    islogoff: json["islogoff"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "StartTime": startTime,
    "ToTime": toTime,
    "WorkstationId": workstationId,
    "WorkstationName": workstationName,
    "Logofftime": logofftime,
    "islogoff": islogoff,
  };
}

enum BuildingName { IN50, TOWER_A, BUILDING1, SJR_CYBER, IN19, TOWER_B, DU_PARC_TRINITY, IN02_ACCESS_FREE, IN02, IN31, IN09, IN32, IN01, LK_01_ACCESS_FREE, IN24, IN09_ACCESS_FREE, IN08, IN74 }

final buildingNameValues = EnumValues({
  "Building1": BuildingName.BUILDING1,
  "DuParc Trinity": BuildingName.DU_PARC_TRINITY,
  "IN01": BuildingName.IN01,
  "IN02": BuildingName.IN02,
  "IN02 Access Free": BuildingName.IN02_ACCESS_FREE,
  "IN08": BuildingName.IN08,
  "IN09": BuildingName.IN09,
  "IN09 Access Free": BuildingName.IN09_ACCESS_FREE,
  "IN19": BuildingName.IN19,
  "IN24": BuildingName.IN24,
  "IN31": BuildingName.IN31,
  "IN32": BuildingName.IN32,
  "IN50": BuildingName.IN50,
  "IN74": BuildingName.IN74,
  "LK 01 Access Free": BuildingName.LK_01_ACCESS_FREE,
  "SJR Cyber": BuildingName.SJR_CYBER,
  "Tower A": BuildingName.TOWER_A,
  "Tower B": BuildingName.TOWER_B
});

enum CompanyName { SIPL, I2_I_SOFTWARES, I2_I_ADMIN, RAZORPAY, VESTIAN_GLOBAL_WORKPLACE_SERVICES_PRIVATE_LIMITED, SLPL }

final companyNameValues = EnumValues({
  "i2i Admin": CompanyName.I2_I_ADMIN,
  "i2i Softwares": CompanyName.I2_I_SOFTWARES,
  "Razorpay": CompanyName.RAZORPAY,
  "SIPL": CompanyName.SIPL,
  "SLPL": CompanyName.SLPL,
  "Vestian Global Workplace Services Private Limited": CompanyName.VESTIAN_GLOBAL_WORKPLACE_SERVICES_PRIVATE_LIMITED
});

enum FloorName { GROUND_FLOOR, THE_2_ND_FLOOR, FLOOR1, THE_7_TH_FLOOR, THE_1_ST_FLOOR, FIRST_FLOOR, THE_3_RD_FLOOR, GODAVARI, BASEMENT, THE_4_TH_FLOOR, BRAHMAPUTRA, THE_5_TH_FLOOR_ACCESS_FLOOR, THE_5_TH_FLOOR, THE_6_TH_FLOOR, LOBBY_7_F, THE_8_TH_FLOOR }

final floorNameValues = EnumValues({
  "Basement": FloorName.BASEMENT,
  "Brahmaputra": FloorName.BRAHMAPUTRA,
  "First Floor": FloorName.FIRST_FLOOR,
  "Floor1": FloorName.FLOOR1,
  "Godavari": FloorName.GODAVARI,
  "Ground Floor": FloorName.GROUND_FLOOR,
  "Lobby 7F": FloorName.LOBBY_7_F,
  "1st Floor": FloorName.THE_1_ST_FLOOR,
  "2nd Floor": FloorName.THE_2_ND_FLOOR,
  "3rd Floor": FloorName.THE_3_RD_FLOOR,
  "4th Floor": FloorName.THE_4_TH_FLOOR,
  "5th Floor": FloorName.THE_5_TH_FLOOR,
  "5th Floor Access Floor": FloorName.THE_5_TH_FLOOR_ACCESS_FLOOR,
  "6th Floor": FloorName.THE_6_TH_FLOOR,
  "7th Floor": FloorName.THE_7_TH_FLOOR,
  "8th Floor": FloorName.THE_8_TH_FLOOR
});

enum LocationName { NOIDA, BANGALORE, INDIRA_NAGAR, BANGALORE_FM, HYDERABAD, SRILANKA, MUMBAI }

final locationNameValues = EnumValues({
  "Bangalore": LocationName.BANGALORE,
  "Bangalore FM": LocationName.BANGALORE_FM,
  "Hyderabad": LocationName.HYDERABAD,
  "Indira Nagar": LocationName.INDIRA_NAGAR,
  "Mumbai": LocationName.MUMBAI,
  "Noida": LocationName.NOIDA,
  "Srilanka": LocationName.SRILANKA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
