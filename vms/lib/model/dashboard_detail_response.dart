import 'dart:developer';

class DashboardDetailResponse {
  DashboardDetailResponse(
      this.status, 
      this.message, 
      this.result,);

  DashboardDetailResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(DashboardDetail.fromJson(v));
      });
    }
  }
  late bool status;
  late String message;
  List<DashboardDetail>? result;

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

class DashboardDetail {
  DashboardDetail(
      this.customerspecid, 
      this.customerid, 
      this.firstname, 
      this.phoneno, 
      this.barcoded, 
      this.towerid, 
      this.buildingName, 
      this.companyid, 
      this.locationName, 
      this.persontomeet, 
      this.persontomeetContact, 
      this.gate, 
      this.inTime, 
      this.outTime,);

  DashboardDetail.fromJson(dynamic json) {
    customerspecid = json['customerspecid'];
    customerid = json['customerid'];
    firstname = json['firstname'];
    phoneno = json['phoneno'];
    barcoded = json['Barcoded'];
    towerid = json['towerid'];
    buildingName = json['BuildingName'];
    companyid = json['companyid'];
    locationName = json['LocationName'];
    persontomeet = json['persontomeet'];
    persontomeetContact = json['persontomeet_contact'];
    gate = json['gate'];
    inTime = json['InTime'];
    outTime = json['OutTime'];
    visitPic = json['VisitPic'] ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    purpose = json['Purpose_Of_Visit'] ?? '';
    passlink = json['VPassLink'];
  }
  late int customerspecid;
  late int customerid;
  late String firstname;
  late String phoneno;
  late String barcoded;
  late int towerid;
  late String buildingName;
  late int companyid;
  late String locationName;
  late String persontomeet;
  late String persontomeetContact;
  late String gate;
  String? inTime;
  String? outTime;
  late String purpose;
  late String visitPic;
  late String passlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerspecid'] = customerspecid;
    map['customerid'] = customerid;
    map['firstname'] = firstname;
    map['phoneno'] = phoneno;
    map['Barcoded'] = barcoded;
    map['towerid'] = towerid;
    map['BuildingName'] = buildingName;
    map['companyid'] = companyid;
    map['LocationName'] = locationName;
    map['persontomeet'] = persontomeet;
    map['persontomeet_contact'] = persontomeetContact;
    map['gate'] = gate;
    map['InTime'] = inTime;
    map['OutTime'] = outTime;
    map['VisitPic'] = visitPic;
    map['Purpose_Of_Visit'] = purpose;
    map['VPassLink'] = passlink;
    return map;
  }

}