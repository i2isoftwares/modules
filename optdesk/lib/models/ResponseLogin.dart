// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.status,
    required this.showQa,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
    required this.isshow,
    required this.data,
    required this.isOTP,
  });

  bool status;
  bool showQa;
  String message;
  ReturnData returnData;
  String method;
  String sessionId;
  String id;
  String isshow;
  int data;
  String isOTP;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    status: json["Status"],
    showQa: json["ShowQa"],
    message: json["Message"],
    returnData:ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
    isshow: json["isshow"],
    data: json["data"],
    isOTP: json["isOTP"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "ShowQa": showQa,
    "Message": message,
    "ReturnData": returnData == null ? null : returnData.toJson(),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
    "isshow": isshow,
    "data": data,
    "isOTP": isOTP,
  };
}

class ReturnData {
  ReturnData({
    required this.userDetails,
    required this.companyDetails,
    required this.locationDetails,
    required this.buildingDetails,
    required this.floorDetails,
    required this.workStationDetails,
  });

  List<UserDetail> userDetails;
  List<CompanyDetail> companyDetails;
  List<LocationDetail> locationDetails;
  List<BuildingDetail> buildingDetails;
  List<FloorDetail> floorDetails;
  List<WorkStationDetail> workStationDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    userDetails: List<UserDetail>.from(json["UserDetails"].map((x) => UserDetail.fromJson(x))),
    companyDetails:  List<CompanyDetail>.from(json["CompanyDetails"].map((x) => CompanyDetail.fromJson(x))),
    locationDetails:  List<LocationDetail>.from(json["LocationDetails"].map((x) => LocationDetail.fromJson(x))),
    buildingDetails:  List<BuildingDetail>.from(json["BuildingDetails"].map((x) => BuildingDetail.fromJson(x))),
    floorDetails: List<FloorDetail>.from(json["FloorDetails"].map((x) => FloorDetail.fromJson(x))),
    workStationDetails: List<WorkStationDetail>.from(json["WorkStationDetails"].map((x) => WorkStationDetail.fromJson(x))),
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
    required this.buildingId,
    required this.buildingName,
  });

  int buildingId;
  String buildingName;

  factory BuildingDetail.fromJson(Map<String, dynamic> json) => BuildingDetail(
    buildingId: json["BuildingID"],
    buildingName: json["BuildingName"],
  );

  Map<String, dynamic> toJson() => {
    "BuildingID": buildingId,
    "BuildingName": buildingName,
  };
}

class CompanyDetail {
  CompanyDetail({
    required this.cuid,
    required this.companyId,
    required this.companyName,
    required this.countryId,
    this.logoname,
  });

  int cuid;
  int companyId;
  String companyName;
  String countryId;
  dynamic logoname;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
    cuid: json["CUID"],
    companyId: json["CompanyID"],
    companyName: json["CompanyName"],
    countryId: json["CountryId"],
    logoname: json["Logoname"],
  );

  Map<String, dynamic> toJson() => {
    "CUID": cuid,
    "CompanyID": companyId,
    "CompanyName": companyName,
    "CountryId": countryId,
    "Logoname": logoname,
  };
}

class FloorDetail {
  FloorDetail({
    required this.floorId,
    required this.floorName,
  });

  int floorId;
  String floorName;

  factory FloorDetail.fromJson(Map<String, dynamic> json) => FloorDetail(
    floorId: json["FloorID"],
    floorName: json["FloorName"],
  );

  Map<String, dynamic> toJson() => {
    "FloorID": floorId,
    "FloorName": floorName,
  };
}

class LocationDetail {
  LocationDetail({
    required this.locationId,
    required this.locationName,
  });

  int locationId;
  String locationName;

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
    locationId: json["LocationID"],
    locationName: json["LocationName"],
  );

  Map<String, dynamic> toJson() => {
    "LocationID": locationId,
    "LocationName": locationName,
  };
}

class UserDetail {
  UserDetail({
    required this.fromFramework,
    required this.countryId,
    required this.countryIdCurrent,
    required this.roleId,
    required this.userId,
    required this.companyIdUser,
    required this.locationIdUser,
    required this.companyName,
    required this.companyIdCurrent,
    required this.locationName,
    required this.locationIdCurrent,
    required this.groupId,
    required this.groupIdCurrent,
    required this.languageId,
    required this.userFirstName,
    required this.userLastName,
    required this.themeFolderPath,
    required this.compLogo,
    required this.announcement,
    required this.isWorkstationLogin,
    required this.roleformshowid,
    required this.emailId,
    required this.showQa,
    required this.DepartmentID,
    required this.DepartmentName
  });

  bool fromFramework;
  int countryId;
  int countryIdCurrent;
  int roleId;
  int userId;
  int companyIdUser;
  int locationIdUser;
  dynamic companyName;
  int companyIdCurrent;
  String locationName;
  int locationIdCurrent;
  int groupId;
  int groupIdCurrent;
  int languageId;
  String userFirstName;
  String userLastName;
  dynamic themeFolderPath;
  String compLogo;
  String announcement;
  int isWorkstationLogin;
  int roleformshowid;
  dynamic emailId;
  bool showQa;
  int DepartmentID;
  String DepartmentName;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    fromFramework: json["FromFramework"],
    countryId: json["CountryID"],
    countryIdCurrent: json["CountryIDCurrent"],
    roleId: json["RoleID"],
    userId: json["UserID"],
    companyIdUser: json["CompanyIDUser"],
    locationIdUser: json["LocationIDUser"],
    companyName: json["CompanyName"],
    companyIdCurrent: json["CompanyIDCurrent"],
    locationName: json["LocationName"],
    locationIdCurrent: json["LocationIDCurrent"],
    groupId: json["GroupID"],
    groupIdCurrent: json["GroupIDCurrent"],
    languageId: json["LanguageID"],
    userFirstName: json["UserFirstName"],
    userLastName: json["UserLastName"],
    themeFolderPath: json["ThemeFolderPath"],
    compLogo: json["CompLogo"],
    announcement: json["Announcement"],
    isWorkstationLogin: json["IsWorkstationLogin"],
    roleformshowid: json["Roleformshowid"],
    emailId: json["EmailID"],
    showQa: json["showQA"],
    DepartmentID: json["DepartmentID"],
    DepartmentName: json["DepartmentName"],
  );

  Map<String, dynamic> toJson() => {
    "FromFramework": fromFramework,
    "CountryID": countryId,
    "CountryIDCurrent": countryIdCurrent,
    "RoleID": roleId,
    "UserID": userId,
    "CompanyIDUser": companyIdUser,
    "LocationIDUser": locationIdUser,
    "CompanyName": companyName,
    "CompanyIDCurrent": companyIdCurrent,
    "LocationName": locationName,
    "LocationIDCurrent": locationIdCurrent,
    "GroupID": groupId,
    "GroupIDCurrent": groupIdCurrent,
    "LanguageID": languageId,
    "UserFirstName": userFirstName,
    "UserLastName": userLastName,
    "ThemeFolderPath": themeFolderPath,
    "CompLogo": compLogo,
    "Announcement": announcement,
    "IsWorkstationLogin": isWorkstationLogin,
    "Roleformshowid": roleformshowid,
    "EmailID": emailId,
    "showQA": showQa,
  };
}

class WorkStationDetail {
  WorkStationDetail({
    required this.workStationId,
    required this.amenityId,
    required this.companyId,
    required this.locationId,
    required this.buildingId,
    required this.floorId,
    required this.wingId,
    required this.workStationName,
    required this.isActive,
    required this.isDelete,
    required this.cuId,
    required this.cDate,
    required this.muId,
    required this.mDate,
    required this.qrCode,
    required this.qrId,
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.isSocialDistance,
  });

  int workStationId;
  String amenityId;
  int companyId;
  int locationId;
  int buildingId;
  int floorId;
  int wingId;
  String workStationName;
  bool isActive;
  bool isDelete;
  int cuId;
  DateTime cDate;
  dynamic muId;
  dynamic mDate;
  dynamic qrCode;
  dynamic qrId;
  int x1;
  int y1;
  int x2;
  int y2;
  bool isSocialDistance;

  factory WorkStationDetail.fromJson(Map<String, dynamic> json) => WorkStationDetail(
    workStationId: json["WorkStationId"],
    amenityId: json["AmenityId"],
    companyId: json["CompanyId"],
    locationId: json["LocationId"],
    buildingId: json["BuildingId"],
    floorId: json["FloorID"],
    wingId: json["WingId"],
    workStationName: json["WorkStationName"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
    cuId: json["CuID"],
    cDate: DateTime.parse(json["CDate"]),
    muId: json["MuID"],
    mDate: json["MDate"],
    qrCode: json["QrCode"],
    qrId: json["QrId"],
    x1: json["X1"],
    y1: json["Y1"],
    x2: json["X2"],
    y2: json["Y2"],
    isSocialDistance: json["IsSocialDistance"],
  );

  Map<String, dynamic> toJson() => {
    "WorkStationId": workStationId,
    "AmenityId": amenityId,
    "CompanyId": companyId,
    "LocationId": locationId,
    "BuildingId": buildingId,
    "FloorID": floorId,
    "WingId": wingId,
    "WorkStationName": workStationName,
    "IsActive": isActive,
    "IsDelete": isDelete,
    "CuID": cuId,
    "CDate": cDate == null ? null : cDate.toIso8601String(),
    "MuID": muId,
    "MDate": mDate,
    "QrCode": qrCode,
    "QrId": qrId,
    "X1": x1,
    "Y1": y1,
    "X2": x2,
    "Y2": y2,
    "IsSocialDistance": isSocialDistance,
  };
}
