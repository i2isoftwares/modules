class Tenant {
  late bool status;
  late String message;
  late List<TenantList> result;

  Tenant(this.status, this.message, this.result);

  Tenant.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result.add(TenantList.fromJson(v));
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

class TenantList {
  late int tenantid;
  late String tenantname;

  TenantList(this.tenantid, this.tenantname);

  TenantList.fromJson(dynamic json) {
    tenantid = json["tenantid"];
    tenantname = json["tenantname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tenantid"] = tenantid;
    map["tenantname"] = tenantname;
    return map;
  }
}
