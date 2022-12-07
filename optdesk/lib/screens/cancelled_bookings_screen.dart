import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseCancelHistory.dart';
import 'package:optdesk/widgets/app_bar.dart';

import '../api/network_utils.dart';

class CancelledBookings extends StatefulWidget {
  @override
  _CancelledBookingsState createState() => _CancelledBookingsState();
}

class _CancelledBookingsState extends State<CancelledBookings> {
  late CancelHistory cancelHistory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._postBookingHistory(context);
  }

  void _postBookingHistory(BuildContext context) async {
    Utils.showLoader(context);
    CancelHistory response = await postCancelHistory(Utils.userDetail!.userId.toString(), Utils.userDetail!.roleformshowid.toString(),context);

    setState(() {
      if(response != null){
        this.cancelHistory = response;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'Cancelled Bookings',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: cancelHistory != null ? cancelHistory.returnData.length : 0,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/location-8.png',
                          height: 23,
                          width: 23,
                        ),
                        SizedBox(width: 7),
                        Expanded(
                          child: AutoSizeText(
                            "${cancelHistory.returnData[index].companyName}, ${cancelHistory.returnData[index].locationName}, ${cancelHistory.returnData[index].buildingName}, ${cancelHistory.returnData[index].floorName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                            minFontSize: 6,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/calendar-8.png',
                          height: 23,
                          width: 23,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: AutoSizeText(
                            "${cancelHistory.returnData[index].workStationName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                            minFontSize: 6,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/calendar-8.png',
                          height: 23,
                          width: 23,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: AutoSizeText(
                            cancelHistory.returnData[index].startDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                            minFontSize: 6,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/time-8.png',
                          height: 23,
                          width: 23,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: AutoSizeText(
                            "${cancelHistory.returnData[index].startTime} to ${cancelHistory.returnData[index].endTime}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                            minFontSize: 6,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
