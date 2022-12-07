// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  UserList({
    this.status,
    this.message,
    this.returnData,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  ReturnData? returnData;
  String? method;
  String? sessionId;
  String? id;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : ReturnData.fromJson(json["ReturnData"]),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : returnData.toJson(),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}

class ReturnData {
  ReturnData({
    this.userDetails,
  });

  List<UserDetail1> userDetails;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
    userDetails: json["UserDetails"] == null ? null : List<UserDetail1>.from(json["UserDetails"].map((x) => UserDetail1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserDetails": userDetails == null ? null : List<dynamic>.from(userDetails.map((x) => x.toJson())),
  };
}

class UserDetail1 {
  UserDetail1({
    this.userid,
    this.emailId,
  });

  int? userid;
  String? emailId;

  factory UserDetail1.fromJson(Map<String, dynamic> json) => UserDetail1(
    userid: json["Userid"] == null ? null : json["Userid"],
    emailId: json["EmailId"] == null ? null : json["EmailId"],
  );

  Map<String, dynamic> toJson() => {
    "Userid": userid == null ? null : userid,
    "EmailId": emailId == null ? null : emailId,
  };
}
