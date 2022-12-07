// To parse this JSON data, do
//
//     final getQuestions = getQuestionsFromJson(jsonString);

import 'dart:convert';

GetQuestions getQuestionsFromJson(String str) => GetQuestions.fromJson(json.decode(str));

String getQuestionsToJson(GetQuestions data) => json.encode(data.toJson());

class GetQuestions {
  GetQuestions({
    this.status,
    this.message,
    this.returnData,
    this.returnDatax,
    this.method,
    this.sessionId,
    this.id,
  });

  bool? status;
  String? message;
  List<Question>? returnData;
  List<dynamic>? returnDatax;
  String? method;
  String? sessionId;
  String? id;

  factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    returnData: json["ReturnData"] == null ? null : List<Question>.from(json["ReturnData"].map((x) => Question.fromJson(x))),
    returnDatax: json["ReturnDatax"] == null ? null : List<dynamic>.from(json["ReturnDatax"].map((x) => x)),
    method: json["Method"] == null ? null : json["Method"],
    sessionId: json["SessionID"] == null ? null : json["SessionID"],
    id: json["ID"] == null ? null : json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "ReturnData": returnData == null ? null : List<dynamic>.from(returnData.map((x) => x.toJson())),
    "ReturnDatax": returnDatax == null ? null : List<dynamic>.from(returnDatax.map((x) => x)),
    "Method": method == null ? null : method,
    "SessionID": sessionId == null ? null : sessionId,
    "ID": id == null ? null : id,
  };
}

class Question {
  Question({
    this.qnsid,
    this.question,
    this.answer,
    this.options,
  });

  int? qnsid;
  String? question;
  String? answer;
  List<Option>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    qnsid: json["Qnsid"] == null ? null : json["Qnsid"],
    question: json["Question"] == null ? null : json["Question"],
    options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Qnsid": qnsid == null ? null : qnsid,
    "Question": question == null ? null : question,
    "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    this.optionid,
    this.optiondetail,
  });

  int? optionid;
  String? optiondetail;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    optionid: json["Optionid"] == null ? null : json["Optionid"],
    optiondetail: json["Optiondetail"] == null ? null : json["Optiondetail"],
  );

  Map<String, dynamic> toJson() => {
    "Optionid": optionid == null ? null : optionid,
    "Optiondetail": optiondetail == null ? null : optiondetail,
  };
}

class Quiz {
  Quiz({
    this.optionId,
    this.questionId,
  });

  Map<String, String>? optionId;
  Map<String, String>? questionId;
}
