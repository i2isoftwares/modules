// To parse this JSON data, do
//
//     final getQuestions = getQuestionsFromJson(jsonString);

import 'dart:convert';

GetQuestions getQuestionsFromJson(String str) => GetQuestions.fromJson(json.decode(str));

String getQuestionsToJson(GetQuestions data) => json.encode(data.toJson());

class GetQuestions {
  GetQuestions({
    required this.status,
    required this.message,
    required this.returnData,
    required this.returnDatax,
    required this.method,
    required this.sessionId,
    required this.id,
  });


  late bool status;
  late String message;
  late List<Question> returnData;
  late List<dynamic> returnDatax;
  late String method;
  late String sessionId;
  late String id;

  factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
    status: json["Status"],
    message: json["Message"],
    returnData: List<Question>.from(json["ReturnData"].map((x) => Question.fromJson(x))),
    returnDatax: List<dynamic>.from(json["ReturnDatax"].map((x) => x)),
    method: json["Method"],
    sessionId: json["SessionID"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ReturnData": List<dynamic>.from(returnData.map((x) => x.toJson())),
    "ReturnDatax":  List<dynamic>.from(returnDatax.map((x) => x)),
    "Method": method,
    "SessionID": sessionId,
    "ID": id,
  };
}

class Question {
  Question({
    required this.qnsid,
    required this.question,
    this.answer,
    required this.options,
  });

  int qnsid;
  String question;
  String? answer;
  List<Option> options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    qnsid: json["Qnsid"],
    question: json["Question"],
    options:  List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Qnsid": qnsid,
    "Question": question,
    "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    required this.optionid,
    required this.optiondetail,
  });

  int optionid;
  String optiondetail;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    optionid: json["Optionid"],
    optiondetail: json["Optiondetail"],
  );

  Map<String, dynamic> toJson() => {
    "Optionid": optionid,
    "Optiondetail": optiondetail,
  };
}

class Quiz {
  Quiz({
    required this.optionId,
    required this.questionId,
  });

  Map<String, String> optionId;
  Map<String, String> questionId;
}
