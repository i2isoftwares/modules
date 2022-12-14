import 'package:get/get.dart';

class Checklist {
  Checklist.fromJson(dynamic json) {
    questionId = json['questionid'];
    questionName = json['questionName'];
    scoreId = json['scoreid'];
    remarks = json['remarks'];
    image = json['image'];
  }

  Checklist(this.questionId, this.questionName, this.scoreId, this.remarks,
      this.image, this.checklistImage);

  int questionId = -1;
  String questionName = '';
  Rx<int> scoreId = Rx(-1);
  String remarks = '';
  String image = '';
  Rx<String> checklistImage = ''.obs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionid'] = questionId;
    map['questionName'] = questionName;
    map['scoreid'] = scoreId.value;
    map['remarks'] = remarks;
    map['image'] = image;
    map['checklistImage'] = checklistImage.value;
    return map;
  }
}
