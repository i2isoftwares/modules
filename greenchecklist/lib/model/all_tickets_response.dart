class AllTicketsResponse {
  AllTicketsResponse(
    this.status,
    this.message,
    this.statusdetails,
  );

  AllTicketsResponse.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['ReturnData']['Dashboard_details'] != null) {
      statusdetails = [];
      json['ReturnData']['Dashboard_details'].forEach((v) {
        statusdetails?.add(Statusdetails.fromJson(v));
      });
    }

  }

  late bool status;
  late String message;
  late List<Statusdetails>? statusdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (statusdetails != null) {
      map['statusdetails'] = statusdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}




class Statusdetails {
  Statusdetails(
    this.statusid,
    this.status,
    this.colorcode,
    this.tickets,
  );

  Statusdetails.fromJson(dynamic json) {
    statusid = json['StatusID'];
    status = json['StatusName'];
    colorcode = json['ColorCode'];
    tickets = json['tickets'];
  }

  late int statusid;
  late String status;
  late String colorcode;
  late int tickets;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusID'] = statusid;
    map['StatusName'] = status;
    map['ColorCode'] = colorcode;
    map['tickets'] = tickets;
    return map;
  }
}
