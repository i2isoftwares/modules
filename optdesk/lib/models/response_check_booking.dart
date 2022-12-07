class ResponseCheckBooking {
  late bool status;
  late bool showQa;
  late String message;


  ResponseCheckBooking(
      this.status, 
      this.showQa, 
      this.message, 
      );

  ResponseCheckBooking.fromJson(dynamic json) {
    status = json["Status"];
    showQa = json["ShowQa"];
    message = json["Message"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Status"] = status;
    map["ShowQa"] = showQa;
    map["Message"] = message;

    return map;
  }

}