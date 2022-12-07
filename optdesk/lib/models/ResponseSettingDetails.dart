// To parse this JSON data, do
//
//     final settingDetails = settingDetailsFromJson(jsonString);

import 'dart:convert';

SettingDetails settingDetailsFromJson(String str) => SettingDetails.fromJson(json.decode(str));

String settingDetailsToJson(SettingDetails data) => json.encode(data.toJson());

class SettingDetails {
  SettingDetails({
    this.status,
    this.showQa,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
    this.isShow,
  });

  bool? status;
  bool? showQa;
  String? message;
  ReturnData? returnData;
  String? method;
  String? sessionId;
  String? id;
  String? isShow;

  factory SettingDetails.fromJson(Map<String, dynamic> json) => SettingDetails(
    status: json["Status"] == null ? false : json["Status"],
    showQa: json["ShowQa"] == null ? false : json["ShowQa"],
    message: json["Message"] == null ? '' : json["Message"],
    returnData: json["ReturnData"] == null ? {} : ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"] == null ? '' : json["Method"],
    sessionId: json["SessionID"] == null ? '' : json["SessionID"],
    id: json["ID"] == null ? '' : json["ID"],
    isShow: json["isshow"] == null ? '' : json["isshow"],

  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? false : status,
    "ShowQa": showQa == null ? false : showQa,
    "Message": message == null ? '' : message,
    "ReturnData": returnData == null ? {} : returnData.toJson(),
    "Method": method == null ? '' : method,
    "SessionID": sessionId == null ? '' : sessionId,
    "ID": id == null ? '' : id,
    "isshow": isShow == null ? '' : isShow,
  };
}

class ReturnData {
  ReturnData({
    this.settingDetails,
  });

  List<SettingDetail> settingDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    settingDetails: json["SettingDetails"] == null ? null : List<SettingDetail>.from(json["SettingDetails"].map((x) => SettingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SettingDetails": settingDetails == null ? null : List<dynamic>.from(settingDetails.map((x) => x.toJson())),
  };
}

class SettingDetail {
  SettingDetail({
    this.workStationSettingId,
    this.location,
    this.minSlot,
    this.maxHours,
    this.startTime,
    this.endTime,
    this.priorDays,
    this.numberofBooking,
    this.cuId,
    this.cDate,
    this.muId,
    this.mDate,
    this.isDelete,
    this.companyId,
    this.workstation,
    this.inBetweenBook,
    this.bookingcount,
    this.isOddEven,
    this.isVegNonVeg,
  });

  int? workStationSettingId;
  String? location;
  String? minSlot;
  String? maxHours;
  String? startTime;
  String? endTime;
  int? priorDays;
  int? numberofBooking;
  int? cuId;
  DateTime? cDate;
  int? muId;
  DateTime? mDate;
  int? isDelete;
  int? companyId;
  int? workstation;
  String? inBetweenBook;
  int? bookingcount;
  bool? isOddEven;
  bool? isVegNonVeg;

  factory SettingDetail.fromJson(Map<String, dynamic> json) => SettingDetail(
    workStationSettingId: json["WorkStationSettingId"] == null ? null : json["WorkStationSettingId"],
    location: json["Location"] == null ? null : json["Location"],
    minSlot: json["MinSlot"] == null ? null : json["MinSlot"],
    maxHours: json["MaxHours"] == null ? null : json["MaxHours"],
    startTime: json["StartTime"] == null ? null : json["StartTime"],
    endTime: json["EndTime"] == null ? null : json["EndTime"],
    priorDays: json["PriorDays"] == null ? null : json["PriorDays"],
    numberofBooking: json["NumberofBooking"] == null ? null : json["NumberofBooking"],
    cuId: json["CuId"] == null ? null : json["CuId"],
    cDate: json["CDate"] == null ? null : DateTime.parse(json["CDate"]),
    muId: json["MuId"] == null ? null : json["MuId"],
    mDate: json["MDate"] == null ? null : DateTime.parse(json["MDate"]),
    isDelete: json["IsDelete"] == null ? null : json["IsDelete"],
    companyId: json["CompanyId"] == null ? null : json["CompanyId"],
    workstation: json["Workstation"] == null ? null : json["Workstation"],
    inBetweenBook: json["InBetweenBook"] == null ? null : json["InBetweenBook"],
    bookingcount: json["bookingcount"] == null ? null : json["bookingcount"],
    isOddEven: json["isOddEven"] == null ? false : json["isOddEven"],
    isVegNonVeg: json["isVegNonVeg"] == null ? false : json["isVegNonVeg"],
  );

  Map<String, dynamic> toJson() => {
    "WorkStationSettingId": workStationSettingId == null ? null : workStationSettingId,
    "Location": location == null ? null : location,
    "MinSlot": minSlot == null ? null : minSlot,
    "MaxHours": maxHours == null ? null : maxHours,
    "StartTime": startTime == null ? null : startTime,
    "EndTime": endTime == null ? null : endTime,
    "PriorDays": priorDays == null ? null : priorDays,
    "NumberofBooking": numberofBooking == null ? null : numberofBooking,
    "CuId": cuId == null ? null : cuId,
    "CDate": cDate == null ? null : cDate.toIso8601String(),
    "MuId": muId == null ? null : muId,
    "MDate": mDate == null ? null : mDate.toIso8601String(),
    "IsDelete": isDelete == null ? null : isDelete,
    "CompanyId": companyId == null ? null : companyId,
    "Workstation": workstation == null ? null : workstation,
    "InBetweenBook": inBetweenBook == null ? null : inBetweenBook,
    "bookingcount": bookingcount == null ? null : bookingcount,
    "isOddEven": isOddEven == null ? false : isOddEven,
    "isVegNonVeg": isVegNonVeg == null ? false : isVegNonVeg,
  };
}
