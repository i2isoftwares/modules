// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  UserList({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  bool status;
  String message;
  ReturnData returnData;
  String method;
  String sessionId;
  String id;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    status: json["Status"],
    message: json["Message"],
    returnData:  ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData":  returnData.toJson(),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}

class ReturnData {
  ReturnData({
    required this.userDetails,
  });

  List<UserDetail1> userDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    userDetails:List<UserDetail1>.from(json["UserDetails"].map((x) => UserDetail1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserDetails": List<dynamic>.from(userDetails.map((x) => x.toJson())),
  };
}

class UserDetail1 {
  UserDetail1({
    required this.userid,
    required this.emailId,
  });

  int userid;
  String emailId;

  factory UserDetail1.fromJson(Map<String, dynamic> json) => UserDetail1(
    userid: json["Userid"],
    emailId: json["EmailId"],
  );

  Map<String, dynamic> toJson() => {
    "Userid": userid,
    "EmailId": emailId,
  };
}
