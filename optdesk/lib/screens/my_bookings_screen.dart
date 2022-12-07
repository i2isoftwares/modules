import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseBookingHistory.dart';
import 'package:optdesk/models/ResponseUpdateLogOff.dart';
import 'package:optdesk/widgets/app_bar.dart';

import '../api/network_utils.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings>
    with SingleTickerProviderStateMixin {
  List<Occupied> upcomingBookingHistory = [];
  List<Occupied> pastBookingHistory = [];
  List<Occupied> occupiedBookingHistory = [];

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _getBookingHistory(context);
  }

  void _getBookingHistory(BuildContext context) async {
    Utils.showLoader(context);
    upcomingBookingHistory = [];
    pastBookingHistory = [];
    occupiedBookingHistory = [];
    BookingHistory response = await getBookingHistory(
        Utils.userDetail!.userId.toString(),
        Utils.userDetail!.roleformshowid.toString(),
        context);

    setState(() {
      pastBookingHistory = response.returnData.pastBookingHistory;
      upcomingBookingHistory = response.returnData.upcomingBookingHistory;
      occupiedBookingHistory = response.returnData.occupied;
    });
    Utils.hideLoader();
  }

  void _updateLogOff(String floorMapBookingId, BuildContext context) async {
    Utils.showLoader(context);
    upcomingBookingHistory = [];
    pastBookingHistory = [];
    occupiedBookingHistory = [];
    UpdateLogOff response = await updateLogOff(
        floorMapBookingId,
        Utils.userDetail!.userId.toString(),
        DateFormat('HH:mm').format(DateTime.now()),
        context);
    Utils.hideLoader();
  }

  Future<void> _showConfirmationDialog(int index) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text('Do you want to release the\nworkstation?'),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
              padding: EdgeInsets.zero,
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateLogOff(occupiedBookingHistory[index].floorMapBookingId.toString(),context);
                _getBookingHistory(context);
              },
              child: Text('Yes'),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'My Bookings',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
            margin: EdgeInsets.zero,
            elevation: 10,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: primary,
              indicatorColor: primary,
              labelStyle: TextStyle(fontSize: 12, color: primary),
              unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.grey),
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  child: AutoSizeText(
                    'Past Booking',
                    minFontSize: 7,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    'Upcoming Booking',
                    minFontSize: 7,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    'Occupied',
                    textAlign: TextAlign.center,
                    minFontSize: 7,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: TabBarView(
              controller: _tabController,
              children: [
                _pastTab(context),
                _upcomingTab(context),
                _occupiedTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pastTab(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: pastBookingHistory.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/optdesk/location-8.png',
                        height: 23,
                        width: 23,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: AutoSizeText(
                          "${pastBookingHistory[index].companyName}, ${pastBookingHistory[index].locationName}, ${pastBookingHistory[index].buildingName}, ${pastBookingHistory[index].floorName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
                          minFontSize: 6,
                          maxLines: 2,
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
                          "${pastBookingHistory[index].book[0].workstationName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
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
                          "${pastBookingHistory[index].book[0].date}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
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
                          "${pastBookingHistory[index].book[0].startTime} to ${pastBookingHistory[index].book[0].toTime}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
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
    );
  }

  Widget _upcomingTab(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: upcomingBookingHistory.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              final result = await Navigator.of(context).pushNamed(
                  '/booking_detail_screen',
                  arguments: upcomingBookingHistory[index]);
              if (result == 'reloadData') {
                _getBookingHistory(context);
              }
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/location-8.png',
                          height: 23,
                          width: 23,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: AutoSizeText(
                            "${upcomingBookingHistory[index].companyName}, ${upcomingBookingHistory[index].locationName}, ${upcomingBookingHistory[index].buildingName}, ${upcomingBookingHistory[index].floorName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
                            minFontSize: 6,
                            maxLines: 2,
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
                            "${upcomingBookingHistory[index].book[0].workstationName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
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
                            "${upcomingBookingHistory[index].book[0].date}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
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
                            "${upcomingBookingHistory[index].book[0].startTime} to ${upcomingBookingHistory[index].book[0].toTime}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
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
                            "${upcomingBookingHistory[index].foodpreference}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.black)
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
                            minFontSize: 6,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 7),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            '/view_floor_map_screen',
                            arguments: upcomingBookingHistory[index].floorid);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: AutoSizeText(
                              "View Floor Map",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.apply(color: primary)
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                              minFontSize: 6,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Image.asset(
                            'assets/optdesk/location-8.png',
                            color: primary,
                            height: 23,
                            width: 23,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _occupiedTab(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: occupiedBookingHistory.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/optdesk/location-8.png',
                        height: 23,
                        width: 23,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: AutoSizeText(
                          "${occupiedBookingHistory[index].companyName}, ${occupiedBookingHistory[index].locationName}, ${occupiedBookingHistory[index].buildingName}, ${occupiedBookingHistory[index].floorName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
                          minFontSize: 6,
                          maxLines: 2,
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
                          "${occupiedBookingHistory[index].book[0].workstationName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
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
                          "${occupiedBookingHistory[index].book[0].date}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
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
                          "${occupiedBookingHistory[index].book[0].startTime} to ${occupiedBookingHistory[index].book[0].toTime}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black)
                              .copyWith(
                                  fontWeight: FontWeight.normal, fontSize: 11),
                          minFontSize: 6,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: occupiedBookingHistory[index].companyId == 132325,
                    child: GestureDetector(
                      onTap: () {
                        _showConfirmationDialog(index);
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 7),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/optdesk/logout-8.png',
                                height: 23,
                                width: 23,
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: AutoSizeText(
                                  "Release Workstation",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.apply(color: Colors.black)
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11),
                                  minFontSize: 6,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
