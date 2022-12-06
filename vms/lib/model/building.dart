class Building {
  late bool status;
  late String message;
  late List<BuildingList> result;

  Building(this.status, this.message, this.result);

  Building.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result.add(BuildingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    if (result != null) {
      map["result"] = result.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BuildingList {
  late int buildingid;
  late String buildingshortname;

  BuildingList(this.buildingid, this.buildingshortname);

  BuildingList.fromJson(dynamic json) {
    buildingid = json["buildingid"];
    buildingshortname = json["buildingshortname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["buildingid"] = buildingid;
    map["buildingshortname"] = buildingshortname;
    return map;
  }

}




