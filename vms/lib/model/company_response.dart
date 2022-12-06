class CompanyResponse {
  bool status;
  String message;
  List<CompanyResult> result;

  CompanyResponse.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        result = List<CompanyResult>.from(
            map["result"].map((it) => CompanyResult.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['result'] =
        result != null ? this.result.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class CompanyResult {
  int CompanyId;
  String CompanyName;

  CompanyResult.fromJsonMap(Map<String, dynamic> map)
      : CompanyId = map["CompanyId"],
        CompanyName = map["CompanyName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = CompanyId;
    data['CompanyName'] = CompanyName;
    return data;
  }
}
