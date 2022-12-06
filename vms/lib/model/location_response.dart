class LocationResponse {
  bool status;
  String message;
  List<LocationResult> result;

  LocationResponse.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        result = List<LocationResult>.from(
            map["result"].map((it) => LocationResult.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['result'] =
        result != null ? this.result.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class LocationResult {
  int LocationId;
  String LocationName;

  LocationResult.fromJsonMap(Map<String, dynamic> map)
      : LocationId = map["LocationId"],
        LocationName = map["LocationName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LocationId'] = LocationId;
    data['LocationName'] = LocationName;
    return data;
  }
}
