class Proof {
  late bool status;
  late int statusId;
  late String message;
  late int totalpages;
  late List<ProofList> result;
  late dynamic aMCDetails;
  late dynamic itemList;

  Proof(
      this.status,
      this.statusId,
      this.message,
      this.totalpages,
      this.result,
      this.aMCDetails,
      this.itemList);

  Proof.fromJson(dynamic json) {
    status = json["status"];
    statusId = json["statusId"];
    message = json["message"];
    totalpages = json["Totalpages"];
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result.add(ProofList.fromJson(v));
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

class ProofList {
  late int proofid;
  late String proofname;

  ProofList(this.proofid, this.proofname);

  ProofList.fromJson(dynamic json) {
    proofid = json["proofid"];
    proofname = json["proofname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["proofid"] = proofid;
    map["proofname"] = proofname;
    return map;
  }
}
