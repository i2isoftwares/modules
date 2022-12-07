// To parse this JSON data, do
//
//     final settingDetails = settingDetailsFromJson(jsonString);

import 'dart:convert';

SettingDetails settingDetailsFromJson(String str) => SettingDetails.fromJson(json.decode(str));

String settingDetailsToJson(SettingDetails data) => json.encode(data.toJson());

class SettingDetails {
  SettingDetails({

    required this.status,
    required this.showQa,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
    required this.isShow,
  });

  bool status;
  bool showQa;
  String message;
  ReturnData returnData;
  String method;
  String sessionId;
  String id;
  String isShow;

  factory SettingDetails.fromJson(Map<String, dynamic> json) => SettingDetails(
    status: json["Status"] ?? false,
    showQa: json["ShowQa"] ?? false,
    message: json["Message"] ?? '',
    returnData:  ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"] ?? '',
    sessionId: json["SessionID"] ?? '',
    id: json["ID"] ?? '',
    isShow: json["isshow"] ?? '',

  );

  Map<String, dynamic> toJson() => {
    "Status": status ?? false,
    "ShowQa": showQa ?? false,
    "Message": message ?? '',
    "ReturnData": returnData == null ? {} : returnData.toJson(),
    "Method": method ?? '',
    "SessionID": sessionId ?? '',
    "ID": id ?? '',
    "isshow": isShow ?? '',
  };
}

class ReturnData {
  ReturnData({
    required this.settingDetails,
  });

  List<SettingDetail> settingDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    settingDetails: List<SettingDetail>.from(json["SettingDetails"].map((x) => SettingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SettingDetails": settingDetails == null ? null : List<dynamic>.from(settingDetails.map((x) => x.toJson())),
  };
}

class SettingDetail {
  SettingDetail({
    required this.workStationSettingId,
    required this.location,
    required this.minSlot,
    required this.maxHours,
    required this.startTime,
    required this.endTime,
    required this.priorDays,
    required this.numberofBooking,
    required this.cuId,
    required this.cDate,
    required this.muId,
    required this.mDate,
    required this.isDelete,
    required this.companyId,
    required this.workstation,
    required this.inBetweenBook,
    required this.bookingcount,
    required this.isOddEven,
    required this.isVegNonVeg,
  });

  int workStationSettingId;
  String location;
  String minSlot;
  String maxHours;
  String startTime;
  String endTime;
  int priorDays;
  int numberofBooking;
  int cuId;
  DateTime cDate;
  int muId;
  DateTime mDate;
  int isDelete;
  int companyId;
  int workstation;
  String inBetweenBook;
  int bookingcount;
  bool isOddEven;
  bool isVegNonVeg;

  factory SettingDetail.fromJson(Map<String, dynamic> json) => SettingDetail(
    workStationSettingId: json["WorkStationSettingId"],
    location: json["Location"],
    minSlot: json["MinSlot"],
    maxHours: json["MaxHours"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    priorDays: json["PriorDays"],
    numberofBooking: json["NumberofBooking"],
    cuId: json["CuId"],
    cDate:  DateTime.parse(json["CDate"]),
    muId: json["MuId"],
    mDate: DateTime.parse(json["MDate"]),
    isDelete: json["IsDelete"],
    companyId: json["CompanyId"],
    workstation: json["Workstation"],
    inBetweenBook: json["InBetweenBook"],
    bookingcount: json["bookingcount"],
    isOddEven: json["isOddEven"] ?? false,
    isVegNonVeg: json["isVegNonVeg"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "WorkStationSettingId": workStationSettingId,
    "Location": location,
    "MinSlot": minSlot,
    "MaxHours": maxHours,
    "StartTime": startTime,
    "EndTime": endTime,
    "PriorDays": priorDays,
    "NumberofBooking": numberofBooking,
    "CuId": cuId,
    "CDate": cDate == null ? null : cDate.toIso8601String(),
    "MuId": muId,
    "MDate": mDate == null ? null : mDate.toIso8601String(),
    "IsDelete": isDelete,
    "CompanyId": companyId,
    "Workstation": workstation,
    "InBetweenBook": inBetweenBook,
    "bookingcount": bookingcount,
    "isOddEven": isOddEven ?? false,
    "isVegNonVeg": isVegNonVeg ?? false,
  };
}
