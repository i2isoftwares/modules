// To parse this JSON data, do
//
//     final multipleSave = multipleSaveFromJson(jsonString);

import 'dart:convert';

MultipleSave multipleSaveFromJson(String str) => MultipleSave.fromJson(json.decode(str));

String multipleSaveToJson(MultipleSave data) => json.encode(data.toJson());

class MultipleSave {
  MultipleSave({
    required this.status,
    required this.message,
    required this.returnData,
    required this.method,
    required this.sessionId,
    required this.id,
  });

  bool status;
  String message;
  List<dynamic> returnData;
  String method;
  String sessionId;
  String id;

  factory MultipleSave.fromJson(Map<String, dynamic> json) => MultipleSave(
    status: json["Status"],
    message: json["Message"],
    returnData: List<dynamic>.from(json["ReturnData"].map((x) => x)),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": returnData == null ? null : List<dynamic>.from(returnData.map((x) => x)),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}
