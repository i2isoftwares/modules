/// Status : true
/// StatusID : "1"
/// Message : "Get Visitor details Sucessfully.."
/// ReturnData : {"ClientVisitorID":2,"TenantID":6137,"LocationID":1509,"CompanyID":1509,"BuildingID":1509,"Visitor_FName":"Venkatesh","Visitor_LName":"S","Contact_No":"9847474747","Email_ID":"venkatesh.s@i2isoftwares.com","Visit_Date":"02/03/2022","Start_Time":"10:00 AM","End_Time":"10:30 AM","Whom_To_Visit":"Saran","Purpose_Of_Visit":"Official","Purpose_Of_Visit_ID":3,"QRCode":null,"isVisited":false,"Scan_DateTime":null,"TenantName":"SAP","LocationName":"RMZ Ecoworld 8A-B","BuildingName":"","visitorImage":null,"CustomerId":0,"idProofNo":null,"idProofImage":"","idProofName":null,"idProofId":0,"VisitorProofId":0}

class QRCodeResponse {
  QRCodeResponse({
      this.status, 
      this.statusID, 
      this.message, 
      this.returnData,});

  QRCodeResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusID = json['StatusID'];
    message = json['Message'];
    returnData = json['ReturnData'] != null ? VisitorDetail.fromJson(json['ReturnData']) : null;
  }
  bool? status;
  String? statusID;
  String? message;
  VisitorDetail? returnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['StatusID'] = statusID;
    map['Message'] = message;
    if (returnData != null) {
      map['ReturnData'] = returnData?.toJson();
    }
    return map;
  }

}

/// ClientVisitorID : 2
/// TenantID : 6137
/// LocationID : 1509
/// CompanyID : 1509
/// BuildingID : 1509
/// Visitor_FName : "Venkatesh"
/// Visitor_LName : "S"
/// Contact_No : "9847474747"
/// Email_ID : "venkatesh.s@i2isoftwares.com"
/// Visit_Date : "02/03/2022"
/// Start_Time : "10:00 AM"
/// End_Time : "10:30 AM"
/// Whom_To_Visit : "Saran"
/// Purpose_Of_Visit : "Official"
/// Purpose_Of_Visit_ID : 3
/// QRCode : null
/// isVisited : false
/// Scan_DateTime : null
/// TenantName : "SAP"
/// LocationName : "RMZ Ecoworld 8A-B"
/// BuildingName : ""
/// visitorImage : null
/// CustomerId : 0
/// idProofNo : null
/// idProofImage : ""
/// idProofName : null
/// idProofId : 0
/// VisitorProofId : 0

class VisitorDetail {
  VisitorDetail({
      this.clientVisitorID, 
      this.tenantID, 
      this.locationID, 
      this.companyID, 
      this.buildingID, 
      this.visitorFName, 
      this.visitorLName, 
      this.contactNo, 
      this.emailID, 
      this.visitDate, 
      this.startTime, 
      this.endTime, 
      this.whomToVisit, 
      this.purposeOfVisit, 
      this.purposeOfVisitID, 
      this.qRCode, 
      this.isVisited, 
      this.scanDateTime, 
      this.tenantName, 
      this.locationName, 
      this.buildingName, 
      this.visitorImage, 
      this.customerId, 
      this.idProofNo, 
      this.idProofImage, 
      this.idProofName, 
      this.idProofId,
    this.comeFrom,
    this.accessory,
      this.visitorProofId,});

  VisitorDetail.fromJson(dynamic json) {
    clientVisitorID = json['ClientVisitorID'];
    tenantID = json['TenantID'];
    locationID = json['LocationID'];
    companyID = json['CompanyID'];
    buildingID = json['BuildingID'];
    visitorFName = json['Visitor_FName'];
    visitorLName = json['Visitor_LName'];
    contactNo = json['Contact_No'];
    emailID = json['Email_ID'];
    visitDate = json['Visit_Date'];
    startTime = json['Start_Time'];
    endTime = json['End_Time'];
    whomToVisit = json['Whom_To_Visit'];
    purposeOfVisit = json['Purpose_Of_Visit'];
    purposeOfVisitID = json['Purpose_Of_Visit_ID'];
    qRCode = json['QRCode'];
    isVisited = json['isVisited'];
    scanDateTime = json['Scan_DateTime'];
    tenantName = json['TenantName'];
    locationName = json['LocationName'];
    buildingName = json['BuildingName'];
    visitorImage = json['visitorImage'];
    customerId = json['CustomerId'];
    idProofNo = json['idProofNo'];
    idProofImage = json['idProofImage'];
    idProofName = json['idProofName'];
    idProofId = json['idProofId'];
    visitorProofId = json['VisitorProofId'];
    comeFrom = json['comeFrom'];
    accessory = json['accessory'];
  }
  int? clientVisitorID;
  int? tenantID;
  int? locationID;
  int? companyID;
  int? buildingID;
  String? visitorFName;
  String? visitorLName;
  String? contactNo;
  String? emailID;
  String? visitDate;
  String? startTime;
  String? endTime;
  String? whomToVisit;
  String? purposeOfVisit;
  int? purposeOfVisitID;
  dynamic qRCode;
  bool? isVisited;
  dynamic scanDateTime;
  String? tenantName;
  String? locationName;
  String? buildingName;
  dynamic visitorImage;
  int? customerId;
  dynamic idProofNo;
  String? idProofImage;
  dynamic idProofName;
  int? idProofId;
  int? visitorProofId;
  String? comeFrom;
  String? accessory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ClientVisitorID'] = clientVisitorID;
    map['TenantID'] = tenantID;
    map['LocationID'] = locationID;
    map['CompanyID'] = companyID;
    map['BuildingID'] = buildingID;
    map['Visitor_FName'] = visitorFName;
    map['Visitor_LName'] = visitorLName;
    map['Contact_No'] = contactNo;
    map['Email_ID'] = emailID;
    map['Visit_Date'] = visitDate;
    map['Start_Time'] = startTime;
    map['End_Time'] = endTime;
    map['Whom_To_Visit'] = whomToVisit;
    map['Purpose_Of_Visit'] = purposeOfVisit;
    map['Purpose_Of_Visit_ID'] = purposeOfVisitID;
    map['QRCode'] = qRCode;
    map['isVisited'] = isVisited;
    map['Scan_DateTime'] = scanDateTime;
    map['TenantName'] = tenantName;
    map['LocationName'] = locationName;
    map['BuildingName'] = buildingName;
    map['visitorImage'] = visitorImage;
    map['CustomerId'] = customerId;
    map['idProofNo'] = idProofNo;
    map['idProofImage'] = idProofImage;
    map['idProofName'] = idProofName;
    map['idProofId'] = idProofId;
    map['VisitorProofId'] = visitorProofId;
    map['comeFrom'] = comeFrom;
    map['accessory'] = accessory;

    return map;
  }

}