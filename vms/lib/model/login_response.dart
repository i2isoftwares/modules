class LoginResponse {
  bool status;
  String message;
  List<LoginResult> result;

  LoginResponse.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        result = List<LoginResult>.from(
            map["result"].map((it) => LoginResult.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['result'] =
        result != null ? this.result.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class LoginResult {
  int UserID;
  int companyId;
  int locationId;
  String companyName;
  String locationName;
  String name;
  int groupId;
  String userName;
  String password;

  LoginResult.fromJsonMap(Map<String, dynamic> map)
      : UserID = map["UserID"],
        companyId = map["companyId"],
        locationId = map["locationId"],
        companyName = map["companyName"],
        locationName = map["locationName"],
        name = map["name"],
        groupId = map["groupId"],
        userName = map["userName"],
        password = map["password"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = UserID;
    data['companyId'] = companyId;
    data['locationId'] = locationId;
    data['companyName'] = companyName;
    data['locationName'] = locationName;
    data['name'] = name;
    data['groupId'] = groupId;
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}
