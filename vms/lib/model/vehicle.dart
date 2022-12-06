class Vehicle {
  late bool status;
  late String message;
  late List<VehicleList> result;

  Vehicle(this.status, this.message, this.result);

  Vehicle.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result.add(VehicleList.fromJson(v));
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

class VehicleList {
  late int modeId;
  late String mode;

  VehicleList(this.modeId, this.mode);

  VehicleList.fromJson(dynamic json) {
    modeId = json["ModeId"];
    mode = json["Mode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ModeId"] = modeId;
    map["Mode"] = mode;
    return map;
  }
}
