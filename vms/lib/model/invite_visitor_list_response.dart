/// status : true
/// message : "Visitor List Retrieval Success"
/// result : [{"ClientVisitorID":2003,"TenantID":4876,"LocationID":169,"BuildingID":149,"Visitor_FName":"Rajesh","Visitor_LName":"B","Contact_No":"9840073699","Email_ID":"","Visit_Date":"2022-02-15T00:00:00","Start_Time":"","End_Time":"","Whom_To_Visit":"Venky","Purpose_Of_Visit":"Official","QRCode":"67535386","isVisited":false,"Purpose_Of_Visit_ID":3}]

class InviteVisitorListResponse {
  InviteVisitorListResponse(
    this.status,
    this.message,
    this.result,
  );

  InviteVisitorListResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(InviteVisitors.fromJson(v));
      });
    }
  }

  late bool status;
  late String message;
  List<InviteVisitors>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ClientVisitorID : 2003
/// TenantID : 4876
/// LocationID : 169
/// BuildingID : 149
/// Visitor_FName : "Rajesh"
/// Visitor_LName : "B"
/// Contact_No : "9840073699"
/// Email_ID : ""
/// Visit_Date : "2022-02-15T00:00:00"
/// Start_Time : ""
/// End_Time : ""
/// Whom_To_Visit : "Venky"
/// Purpose_Of_Visit : "Official"
/// QRCode : "67535386"
/// isVisited : false
/// Purpose_Of_Visit_ID : 3

class InviteVisitors {
  InviteVisitors(
      this.clientVisitorID,
      this.tenantID,
      this.locationID,
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
      this.qRCode,
      this.isVisited,
      this.inTime,
      this.outTime,
      this.visitPic,
      this.purposeOfVisitID);

  InviteVisitors.fromJson(dynamic json) {
    clientVisitorID = json['ClientVisitorID'];
    tenantID = json['TenantID'];
    locationID = json['LocationID'];
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
    qRCode = json['QRCode'];
    isVisited = json['isVisited'];
    purposeOfVisitID = json['Purpose_Of_Visit_ID'];
    inTime = json['InTime'] ?? '';
    outTime = json['OutTime'] ?? '';
    visitPic = json['VisitPic'] ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
  }

  late int clientVisitorID;
  late int tenantID;
  late int locationID;
  late int buildingID;
  late String visitorFName;
  late String visitorLName;
  late String contactNo;
  late String? emailID;
  late String visitDate;
  late String? startTime;
  late String? endTime;
  late String whomToVisit;
  late String purposeOfVisit;
  late String qRCode;
  late bool isVisited;
  late int? purposeOfVisitID;
  late String inTime;
  late String outTime;
  late String visitPic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ClientVisitorID'] = clientVisitorID;
    map['TenantID'] = tenantID;
    map['LocationID'] = locationID;
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
    map['QRCode'] = qRCode;
    map['isVisited'] = isVisited;
    map['Purpose_Of_Visit_ID'] = purposeOfVisitID;
    map['InTime'] = inTime;
    map['OutTime'] = outTime;
    map['VisitPic'] = visitPic;
    return map;
  }
}
