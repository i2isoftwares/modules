class TicketDetailsResponse {
  TicketDetailsResponse(
      this.status,
      this.message,
      this.ticketdetails,
      );

  TicketDetailsResponse.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['ReturnData']!= null) {
      ticketdetails = [];
      json['ReturnData'].forEach((v) {
        ticketdetails?.add(TicketDetails.fromJson(v));
      });
    }

  }

  late bool status;
  late String message;
  late List<TicketDetails>? ticketdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (ticketdetails != null) {
      map['ReturnData'] = ticketdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


class TicketDetails {
  TicketDetails(
      this.scoreImage,
      this.rating,
      this.imagelink,
      this.closedTime,
      this.priorityName,
      this.reqTime,
      this.responsible,
      this.statusName,
      this.categoryName,
      this.departmentName,
      this.wingName,
      this.floorName,
      this.buildingName,
      this.locationName,
      this.ticketNo,
      this.compliantID,);

  TicketDetails.fromJson(dynamic json) {
    scoreImage = json['ScoreImage'];
    rating = json['rating'];
    imagelink = json['imagelink'];
    closedTime = json['ClosedTime'];
    priorityName = json['PriorityName'];
    reqTime = json['ReqTime'];
    responsible = json['Responsible'];
    statusName = json['StatusName'];
    categoryName = json['CategoryName'];
    departmentName = json['DepartmentName'];
    wingName = json['WingName'];
    floorName = json['FloorName'];
    buildingName = json['BuildingName'];
    locationName = json['LocationName'];
    ticketNo = json['TicketNo'];
    compliantID = json['CompliantID'];
  }
  late String scoreImage;
  late num rating;
  late String imagelink;
  late String closedTime;
  late String priorityName;
  late String reqTime;
  late String responsible;
  late String statusName;
  late String categoryName;
  late String departmentName;
  late String wingName;
  late String floorName;
  late String buildingName;
  late String locationName;
  late String ticketNo;
  late num compliantID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ScoreImage'] = scoreImage;
    map['rating'] = rating;
    map['imagelink'] = imagelink;
    map['ClosedTime'] = closedTime;
    map['PriorityName'] = priorityName;
    map['ReqTime'] = reqTime;
    map['Responsible'] = responsible;
    map['StatusName'] = statusName;
    map['CategoryName'] = categoryName;
    map['DepartmentName'] = departmentName;
    map['WingName'] = wingName;
    map['FloorName'] = floorName;
    map['BuildingName'] = buildingName;
    map['LocationName'] = locationName;
    map['TicketNo'] = ticketNo;
    map['CompliantID'] = compliantID;
    return map;
  }

}