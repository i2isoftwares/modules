class Histories {
  Histories(
      this.username,
      this.location,
      this.description,
      this.statusTime,
      this.statusDate,
      this.status,
      this.colorcode,
      this.building,
      this.floor,
      this.wing,
      this.imagelink,
      );

  Histories.fromJson(dynamic json) {
    username = json['Username'];
    location = json['location'];
    description = json['description'];
    statusTime = json['StatusTime'];
    statusDate = json['StatusDate'];
    status = json['Status'];
    colorcode = json['Colorcode'];
    building = json['Building'];
    floor = json['Floor'];
    wing = json['Wing'];
    imagelink = json['imagelink'];
  }

  late String username;
  late String location;
  late String description;
  late String statusTime;
  late String statusDate;
  late String status;
  late String colorcode;
  late String building;
  late String floor;
  late String wing;
  late String imagelink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Username'] = username;
    map['location'] = location;
    map['description'] = description;
    map['StatusTime'] = statusTime;
    map['StatusDate'] = statusDate;
    map['Status'] = status;
    map['Colorcode'] = colorcode;
    map['Building'] = building;
    map['Floor'] = floor;
    map['Wing'] = wing;
    map['imagelink'] = imagelink;
    return map;
  }
}