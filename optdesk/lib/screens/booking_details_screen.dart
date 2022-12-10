import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:intl/intl.dart';
import 'package:optdesk/helpers/colors.dart';

import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseBookingHistory.dart';
import 'package:optdesk/models/ResponseCancelBooking.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';

import '../api/network_utils.dart';

class BookingDetails extends StatefulWidget {
  final Occupied data;

  BookingDetails({required this.data});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {

  void _onTapScanNow(BuildContext context) async {
    var currentTime = TimeOfDay.fromDateTime(DateTime.now()).hour.toDouble() + TimeOfDay.fromDateTime(DateTime.now()).minute.toDouble()/60;
    var officeStrTime = TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(widget.data.startTime)).hour.toDouble() + (TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(widget.data.startTime)).minute.toDouble() - 5.0)/60;
    var officeEndTime = TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(widget.data.endTime)).hour.toDouble() + TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(widget.data.endTime)).minute.toDouble()/60;
    var strDate = DateFormat('dd-MMM-yyyy').parse(widget.data.startDate);

    if((currentTime >= officeStrTime) && (currentTime <= officeEndTime) && (strDate.day == DateTime.now().day) && (strDate.month == DateTime.now().month) && (strDate.year == DateTime.now().year)){
      await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: const Text('\nAre you sure want to Scan ?'),
            actions: <Widget>[
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
                padding: EdgeInsets.zero,
              ),
              // CupertinoButton(
              //   onPressed: () async {
              //     Navigator.of(context).pop();
              //     String scanData = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.QR);
              //     api(scanData);
              //   },
              //   child: const Text('Yes'),
              //   padding: EdgeInsets.zero,
              // ),
            ],
          );
        },
      );
    }else{
      showToastMsg('Upcoming Booking');
    }
  }

  void _onTapCancelBooking(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: const Text('\nAre you sure want to\nCancel ?'),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
              padding: EdgeInsets.zero,
            ),
            CupertinoButton(
              onPressed: () async {
                Utils.showLoader(context);
                CancelBooking response = await postCancelBooking(
                    widget.data.floorMapBookingId.toString(),
                    '1',
                    '0',
                    Utils.userDetail!.userId.toString(),
                    Utils.userDetail!.roleformshowid.toString(),
                    context);
                if (response.status) {
                  Navigator.of(context).pop();
                  _showConfirmationDialog(context, "\nBooking Cancelled\nSuccessfully");
                }
              },
              child: const Text('Yes'),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context, String msg) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(msg),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop('reloadData');
              },
              child: const Text('Ok'),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }

  void api(String scanData) async{
    Utils.showLoader(context);
    CancelBooking response = await postCancelBooking(
        widget.data.floorMapBookingId.toString(),
        '0',
        scanData,
        Utils.userDetail!.userId.toString(),
        Utils.userDetail!.roleformshowid.toString(),
        context);
    showToastMsg(response.message);
    if (response.status) {
      _showConfirmationDialog(context, "\nBooking Scanned\nSuccessfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'Booking Details',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 70,
          color: primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(15),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.grey)
                                      .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '${widget.data.locationName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.black)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Building',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.grey)
                                      .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '${widget.data.buildingName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.black)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Floor',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.grey)
                                      .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '${widget.data.floorName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.black)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Wing',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.grey)
                                      .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '${widget.data.wingName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.apply(color: Colors.black)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Workstation No',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.grey)
                                  .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.data.book[0].workstationName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.black)
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'From',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.apply(color: Colors.black)
                            .copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.data.book[0].date,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.black)
                                  .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.data.book[0].startTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: textDarkGrey)
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'To',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.apply(color: Colors.black)
                            .copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.data.book[0].date,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.black)
                                  .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.data.book[0].toTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: textDarkGrey)
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    CustomButton(
                      buttonText: 'Scan Now',
                      buttonType: ButtonType.third,
                      smallText: true,
                      onPressed: () {
                        _onTapScanNow(context);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      buttonText: 'Cancel Booking',
                      smallText: true,
                      onPressed: () {
                        _onTapCancelBooking(context);
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
