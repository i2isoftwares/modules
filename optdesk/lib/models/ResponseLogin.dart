// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    this.status,
    this.showQa,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
    this.isshow,
    this.data,
    this.isOTP,
  });

  bool? status;
  bool? showQa;
  String? message;
  ReturnData? returnData;
  String? method;
  String? sessionId;
  String? id;
  String? isshow;
  int? data;
  String? isOTP;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    status: json["Status"] == null ? null : json["Status"],
    showQa: json["ShowQa"] == null ? null : json["ShowQa"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
    isshow: json["isshow"] == null ? null : json["isshow"],
    data: json["data"] == null ? null : json["data"],
    isOTP: json["isOTP"] == null ? null : json["isOTP"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "ShowQa": showQa == null ? null : showQa,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : returnData.toJson(),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
    "isshow": isshow == null ? null : isshow,
    "data": data == null ? null : data,
    "isOTP": isOTP == null ? null : isOTP,
  };
}

class ReturnData {
  ReturnData({
    this.userDetails,
    this.companyDetails,
    this.locationDetails,
    this.buildingDetails,
    this.floorDetails,
    this.workStationDetails,
  });

  List<UserDetail>? userDetails;
  List<CompanyDetail>? companyDetails;
  List<LocationDetail>? locationDetails;
  List<BuildingDetail>? buildingDetails;
  List<FloorDetail>? floorDetails;
  List<WorkStationDetail>? workStationDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    userDetails: json["UserDetails"] == null ? null : List<UserDetail>.from(json["UserDetails"].map((x) => UserDetail.fromJson(x))),
    companyDetails: json["CompanyDetails"] == null ? null : List<CompanyDetail>.from(json["CompanyDetails"].map((x) => CompanyDetail.fromJson(x))),
    locationDetails: json["LocationDetails"] == null ? null : List<LocationDetail>.from(json["LocationDetails"].map((x) => LocationDetail.fromJson(x))),
    buildingDetails: json["BuildingDetails"] == null ? null : List<BuildingDetail>.from(json["BuildingDetails"].map((x) => BuildingDetail.fromJson(x))),
    floorDetails: json["FloorDetails"] == null ? null : List<FloorDetail>.from(json["FloorDetails"].map((x) => FloorDetail.fromJson(x))),
    workStationDetails: json["WorkStationDetails"] == null ? null : List<WorkStationDetail>.from(json["WorkStationDetails"].map((x) => WorkStationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserDetails": userDetails == null ? null : List<dynamic>.from(userDetails.map((x) => x.toJson())),
    "CompanyDetails": companyDetails == null ? null : List<dynamic>.from(companyDetails.map((x) => x.toJson())),
    "LocationDetails": locationDetails == null ? null : List<dynamic>.from(locationDetails.map((x) => x.toJson())),
    "BuildingDetails": buildingDetails == null ? [] : List<dynamic>.from(buildingDetails.map((x) => x.toJson())),
    "FloorDetails": floorDetails == null ? null : List<dynamic>.from(floorDetails.map((x) => x.toJson())),
    "WorkStationDetails": workStationDetails == null ? null : List<dynamic>.from(workStationDetails.map((x) => x.toJson())),
  };
}

class BuildingDetail {
  BuildingDetail({
    this.buildingId,
    this.buildingName,
  });

  int? buildingId;
  String? buildingName;

  factory BuildingDetail.fromJson(Map<String, dynamic> json) => BuildingDetail(
    buildingId: json["BuildingID"] == null ? null : json["BuildingID"],
    buildingName: json["BuildingName"] == null ? null : json["BuildingName"],
  );

  Map<String, dynamic> toJson() => {
    "BuildingID": buildingId == null ? null : buildingId,
    "BuildingName": buildingName == null ? null : buildingName,
  };
}

class CompanyDetail {
  CompanyDetail({
    this.cuid,
    this.companyId,
    this.companyName,
    this.countryId,
    this.logoname,
  });

  int? cuid;
  int? companyId;
  String? companyName;
  String? countryId;
  dynamic logoname;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
    cuid: json["CUID"] == null ? null : json["CUID"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
    companyName: json["CompanyName"] == null ? null : json["CompanyName"],
    countryId: json["CountryId"] == null ? null : json["CountryId"],
    logoname: json["Logoname"],
  );

  Map<String, dynamic> toJson() => {
    "CUID": cuid == null ? null : cuid,
    "CompanyID": companyId == null ? null : companyId,
    "CompanyName": companyName == null ? null : companyName,
    "CountryId": countryId == null ? null : countryId,
    "Logoname": logoname,
  };
}

class FloorDetail {
  FloorDetail({
    this.floorId,
    this.floorName,
  });

  int? floorId;
  String? floorName;

  factory FloorDetail.fromJson(Map<String, dynamic> json) => FloorDetail(
    floorId: json["FloorID"] == null ? null : json["FloorID"],
    floorName: json["FloorName"] == null ? null : json["FloorName"],
  );

  Map<String, dynamic> toJson() => {
    "FloorID": floorId == null ? null : floorId,
    "FloorName": floorName == null ? null : floorName,
  };
}

class LocationDetail {
  LocationDetail({
    this.locationId,
    this.locationName,
  });

  int? locationId;
  String? locationName;

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
    locationId: json["LocationID"] == null ? null : json["LocationID"],
    locationName: json["LocationName"] == null ? null : json["LocationName"],
  );

  Map<String, dynamic> toJson() => {
    "LocationID": locationId == null ? null : locationId,
    "LocationName": locationName == null ? null : locationName,
  };
}

class UserDetail {
  UserDetail({
    this.fromFramework,
    this.countryId,
    this.countryIdCurrent,
    this.roleId,
    this.userId,
    this.companyIdUser,
    this.locationIdUser,
    this.companyName,
    this.companyIdCurrent,
    this.locationName,
    this.locationIdCurrent,
    this.groupId,
    this.groupIdCurrent,
    this.languageId,
    this.userFirstName,
    this.userLastName,
    this.themeFolderPath,
    this.compLogo,
    this.announcement,
    this.isWorkstationLogin,
    this.roleformshowid,
    this.emailId,
    this.showQa,
    this.DepartmentID,
    this.DepartmentName
  });

  bool? fromFramework;
  int? countryId;
  int? countryIdCurrent;
  int? roleId;
  int? userId;
  int? companyIdUser;
  int? locationIdUser;
  dynamic companyName;
  int? companyIdCurrent;
  String? locationName;
  int? locationIdCurrent;
  int? groupId;
  int? groupIdCurrent;
  int? languageId;
  String? userFirstName;
  String? userLastName;
  dynamic themeFolderPath;
  String? compLogo;
  String? announcement;
  int? isWorkstationLogin;
  int? roleformshowid;
  dynamic? emailId;
  bool? showQa;
  int? DepartmentID;
  String? DepartmentName;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    fromFramework: json["FromFramework"] == null ? null : json["FromFramework"],
    countryId: json["CountryID"] == null ? null : json["CountryID"],
    countryIdCurrent: json["CountryIDCurrent"] == null ? null : json["CountryIDCurrent"],
    roleId: json["RoleID"] == null ? null : json["RoleID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    companyIdUser: json["CompanyIDUser"] == null ? null : json["CompanyIDUser"],
    locationIdUser: json["LocationIDUser"] == null ? null : json["LocationIDUser"],
    companyName: json["CompanyName"],
    companyIdCurrent: json["CompanyIDCurrent"] == null ? null : json["CompanyIDCurrent"],
    locationName: json["LocationName"] == null ? null : json["LocationName"],
    locationIdCurrent: json["LocationIDCurrent"] == null ? null : json["LocationIDCurrent"],
    groupId: json["GroupID"] == null ? null : json["GroupID"],
    groupIdCurrent: json["GroupIDCurrent"] == null ? null : json["GroupIDCurrent"],
    languageId: json["LanguageID"] == null ? null : json["LanguageID"],
    userFirstName: json["UserFirstName"] == null ? null : json["UserFirstName"],
    userLastName: json["UserLastName"] == null ? null : json["UserLastName"],
    themeFolderPath: json["ThemeFolderPath"],
    compLogo: json["CompLogo"] == null ? null : json["CompLogo"],
    announcement: json["Announcement"] == null ? null : json["Announcement"],
    isWorkstationLogin: json["IsWorkstationLogin"] == null ? null : json["IsWorkstationLogin"],
    roleformshowid: json["Roleformshowid"] == null ? null : json["Roleformshowid"],
    emailId: json["EmailID"],
    showQa: json["showQA"] == null ? null : json["showQA"],
    DepartmentID: json["DepartmentID"] == null ? null : json["DepartmentID"],
    DepartmentName: json["DepartmentName"] == null ? null : json["DepartmentName"],
  );

  Map<String, dynamic> toJson() => {
    "FromFramework": fromFramework == null ? null : fromFramework,
    "CountryID": countryId == null ? null : countryId,
    "CountryIDCurrent": countryIdCurrent == null ? null : countryIdCurrent,
    "RoleID": roleId == null ? null : roleId,
    "UserID": userId == null ? null : userId,
    "CompanyIDUser": companyIdUser == null ? null : companyIdUser,
    "LocationIDUser": locationIdUser == null ? null : locationIdUser,
    "CompanyName": companyName,
    "CompanyIDCurrent": companyIdCurrent == null ? null : companyIdCurrent,
    "LocationName": locationName == null ? null : locationName,
    "LocationIDCurrent": locationIdCurrent == null ? null : locationIdCurrent,
    "GroupID": groupId == null ? null : groupId,
    "GroupIDCurrent": groupIdCurrent == null ? null : groupIdCurrent,
    "LanguageID": languageId == null ? null : languageId,
    "UserFirstName": userFirstName == null ? null : userFirstName,
    "UserLastName": userLastName == null ? null : userLastName,
    "ThemeFolderPath": themeFolderPath,
    "CompLogo": compLogo == null ? null : compLogo,
    "Announcement": announcement == null ? null : announcement,
    "IsWorkstationLogin": isWorkstationLogin == null ? null : isWorkstationLogin,
    "Roleformshowid": roleformshowid == null ? null : roleformshowid,
    "EmailID": emailId,
    "showQA": showQa == null ? null : showQa,
  };
}

class WorkStationDetail {
  WorkStationDetail({
    this.workStationId,
    this.amenityId,
    this.companyId,
    this.locationId,
    this.buildingId,
    this.floorId,
    this.wingId,
    this.workStationName,
    this.isActive,
    this.isDelete,
    this.cuId,
    this.cDate,
    this.muId,
    this.mDate,
    this.qrCode,
    this.qrId,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    this.isSocialDistance,
  });

  int? workStationId;
  String amenityId;
  int? companyId;
  int? locationId;
  int? buildingId;
  int? floorId;
  int? wingId;
  String? workStationName;
  bool? isActive;
  bool? isDelete;
  int? cuId;
  DateTime? cDate;
  dynamic muId;
  dynamic mDate;
  dynamic qrCode;
  dynamic qrId;
  int? x1;
  int? y1;
  int? x2;
  int? y2;
  bool? isSocialDistance;

  factory WorkStationDetail.fromJson(Map<String, dynamic> json) => WorkStationDetail(
    workStationId: json["WorkStationId"] == null ? null : json["WorkStationId"],
    amenityId: json["AmenityId"] == null ? null : json["AmenityId"],
    companyId: json["CompanyId"] == null ? null : json["CompanyId"],
    locationId: json["LocationId"] == null ? null : json["LocationId"],
    buildingId: json["BuildingId"] == null ? null : json["BuildingId"],
    floorId: json["FloorID"] == null ? null : json["FloorID"],
    wingId: json["WingId"] == null ? null : json["WingId"],
    workStationName: json["WorkStationName"] == null ? null : json["WorkStationName"],
    isActive: json["IsActive"] == null ? null : json["IsActive"],
    isDelete: json["IsDelete"] == null ? null : json["IsDelete"],
    cuId: json["CuID"] == null ? null : json["CuID"],
    cDate: json["CDate"] == null ? null : DateTime.parse(json["CDate"]),
    muId: json["MuID"],
    mDate: json["MDate"],
    qrCode: json["QrCode"],
    qrId: json["QrId"],
    x1: json["X1"] == null ? null : json["X1"],
    y1: json["Y1"] == null ? null : json["Y1"],
    x2: json["X2"] == null ? null : json["X2"],
    y2: json["Y2"] == null ? null : json["Y2"],
    isSocialDistance: json["IsSocialDistance"] == null ? null : json["IsSocialDistance"],
  );

  Map<String, dynamic> toJson() => {
    "WorkStationId": workStationId == null ? null : workStationId,
    "AmenityId": amenityId == null ? null : amenityId,
    "CompanyId": companyId == null ? null : companyId,
    "LocationId": locationId == null ? null : locationId,
    "BuildingId": buildingId == null ? null : buildingId,
    "FloorID": floorId == null ? null : floorId,
    "WingId": wingId == null ? null : wingId,
    "WorkStationName": workStationName == null ? null : workStationName,
    "IsActive": isActive == null ? null : isActive,
    "IsDelete": isDelete == null ? null : isDelete,
    "CuID": cuId == null ? null : cuId,
    "CDate": cDate == null ? null : cDate.toIso8601String(),
    "MuID": muId,
    "MDate": mDate,
    "QrCode": qrCode,
    "QrId": qrId,
    "X1": x1 == null ? null : x1,
    "Y1": y1 == null ? null : y1,
    "X2": x2 == null ? null : x2,
    "Y2": y2 == null ? null : y2,
    "IsSocialDistance": isSocialDistance == null ? null : isSocialDistance,
  };
}
