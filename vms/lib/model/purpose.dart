class Purpose {
  late bool status;
  late int statusId;
  late String message;
  late int totalpages;
  late List<PurposeList> result;
  late dynamic aMCDetails;
  late dynamic itemList;

  Purpose(
      this.status,
      this.statusId,
      this.message,
      this.totalpages,
      this.result,
      this.aMCDetails,
      this.itemList);

  Purpose.fromJson(dynamic json) {
    status = json["status"];
    statusId = json["statusId"];
    message = json["message"];
    totalpages = json["Totalpages"];
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result.add(PurposeList.fromJson(v));
      });
    }
    aMCDetails = json["AMCDetails"];
    itemList = json["ItemList"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["statusId"] = statusId;
    map["message"] = message;
    map["Totalpages"] = totalpages;
    if (result != null) {
      map["result"] = result.map((v) => v.toJson()).toList();
    }
    map["AMCDetails"] = aMCDetails;
    map["ItemList"] = itemList;
    return map;
  }
}

class PurposeList {
  late int purposeid;
  late String purposename;

  PurposeList(this.purposeid, this.purposename);

  PurposeList.fromJson(dynamic json) {
    purposeid = json["purposeid"];
    purposename = json["purposename"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["purposeid"] = purposeid;
    map["purposename"] = purposename;
    return map;
  }
}
