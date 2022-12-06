
class Visitor {
  List<Accessory>? accessories;
  late String? bodyTemp;
  late bool? haveAccess;
  late bool? haveVeh;
  late int? idProofId;
  late dynamic? idProofImage;
  late String? idProofName;
  late String? idProofNo;
  late String? mobileNo;
  late String? tempScale;
  late String? userID;
  late String? vehNumber;
  late String? vehType;
  late String? vehTypeId;
  late dynamic? vehTypeImage;
  late String? visitCompId;
  late String? visitCompName;
  late String? visitPersonContactId;
  late String? visitPersonId;
  late String? visitPersonName;
  late String? visitPurposeId;
  late String? visitPurposeName;
  late String? visitTowerId;
  late String? visitTowerName;
  late String? visitorFrom;
  late dynamic? visitorImage;
  late String? visitorName;
  late String? visitingDateTime;
  late String? barcodeImage;
  late String? qrcode;
  late int? CompanyID;
  late int? LocationID;
  late int? GateId;
  late int? CustomerId;
  late dynamic? custImagearray;
  bool readOnly=false;

  Visitor({
    this.accessories,
    this.bodyTemp,
    this.haveAccess,
    this.haveVeh,
    this.idProofId,
    this.idProofImage,
    this.idProofName,
    this.idProofNo,
    this.mobileNo,
    this.tempScale,
    this.userID,
    this.vehNumber,
    this.vehType,
    this.vehTypeId,
    this.vehTypeImage,
    this.visitCompId,
    this.visitCompName,
    this.visitPersonContactId,
    this.visitPersonId,
    this.visitPersonName,
    this.visitPurposeId,
    this.visitPurposeName,
    this.visitTowerId,
    this.visitTowerName,
    this.visitorFrom,
    this.visitorImage,
    this.visitorName,
    this.visitingDateTime,
    this.barcodeImage,
    this.qrcode,
    this.CompanyID,
    this.LocationID,
    this.GateId,
    this.CustomerId,
    this.custImagearray,}
  );

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      accessories: json['accessories'] != null
          ? (json['accessories'] as List)
          .map((i) => Accessory.fromJson(i))
          .toList()
          : null,
      bodyTemp: json['bodyTemp'],
      haveAccess: json['haveAccess'],
      haveVeh: json['haveVeh'],
      idProofId: json['idProofId'],
      idProofImage: json['idProofImage'],
      idProofName: json['idProofName'],
      idProofNo: json['idProofNo'],
      mobileNo: json['mobileNo'],
      tempScale: json['tempScale'],
      userID: json['userID'],
      vehNumber: json['vehNumber'],
      vehType: json['vehType'],
      vehTypeId: json['vehTypeId'],
      vehTypeImage: json['vehTypeImage'],
      visitCompId: json['visitCompId'],
      visitCompName: json['visitCompName'],
      visitPersonContactId: json['visitPersonContactId'],
      visitPersonId: json['visitPersonId'],
      visitPersonName: json['visitPersonName'],
      visitPurposeId: json['visitPurposeId'],
      visitPurposeName: json['visitPurposeName'],
      visitTowerId: json['visitTowerId'],
      visitTowerName: json['visitTowerName'],
      visitorFrom: json['visitorFrom'],
      visitorImage: json['visitorImage'],
      visitorName: json['visitorName'],
      visitingDateTime: json['StartDateTime'],
      barcodeImage: json['barcodeImage'],
      qrcode: json['QRCode'],
      CompanyID: json['CompanyID'],
      LocationID: json['LocationID'],
      GateId: json['GateId'],
      CustomerId: json['CustomerId'],
      custImagearray: json['custImagearray'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bodyTemp'] = bodyTemp;
    data['haveAccess'] = haveAccess;
    data['haveVeh'] = haveVeh;
    data['idProofId'] = idProofId;
    data['idProofImage'] = idProofImage;
    data['idProofName'] = idProofName;
    data['idProofNo'] = idProofNo;
    data['mobileNo'] = mobileNo;
    data['tempScale'] = tempScale;
    data['userID'] = userID;
    data['vehNumber'] = vehNumber;
    data['vehType'] = vehType;
    data['vehTypeId'] = vehTypeId;
    data['vehTypeImage'] = vehTypeImage;
    data['visitCompId'] = visitCompId;
    data['visitCompName'] = visitCompName;
    data['visitPersonContactId'] = visitPersonContactId;
    data['visitPersonId'] = visitPersonId;
    data['visitPersonName'] = visitPersonName;
    data['visitPurposeId'] = visitPurposeId;
    data['visitPurposeName'] = visitPurposeName;
    data['visitTowerId'] = visitTowerId;
    data['visitTowerName'] = visitTowerName;
    data['visitorFrom'] = visitorFrom;
    data['visitorImage'] = visitorImage;
    data['visitorName'] = visitorName;
    data['StartDateTime'] = visitingDateTime;
    data['barcodeImage'] = barcodeImage;
    data['QRCode'] = qrcode;
    data['CompanyID'] = CompanyID;
    data['LocationID'] = LocationID;
    data['GateId'] = GateId;
    data['CustomerId'] = CustomerId;
    data['custImagearray'] = custImagearray;
    if (accessories != null) {
      data['accessories'] = accessories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accessory {
  late String desc;
  late String name;

  Accessory(this.name, this.desc);

  factory Accessory.fromJson(Map<String, dynamic> json) {
    return Accessory(
      json['name'],
      json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = desc;
    data['name'] = name;
    return data;
  }
}
