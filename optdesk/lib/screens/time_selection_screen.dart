import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/network_utils.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponseMultipleTimeValidation.dart';
import 'package:optdesk/models/ResponseSettingDetails.dart';
import 'package:optdesk/widgets/shared/app_bar.dart';
import 'package:optdesk/widgets/shared/button.dart';
import 'package:toast/toast.dart';

class TimeSelectionScreen extends StatefulWidget {
  final Map<DateTime, List> events;

  TimeSelectionScreen({@required this.events});

  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  late SettingDetail settingDetail;
  late ResponseLogin responseLogin;

  List<DateTime> dates = [];
  List<Time> slots = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingDetail = Utils.settingDetail;

    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.LOGIN_RESPONSE, '')
        .then((response) =>
            {responseLogin = responseLoginFromJson(response), setState(() {})});

    setState(() {
      dates.addAll(widget.events.keys);
      dates.sort((a, b) {
        return a.compareTo(b);
      });
      dates.forEach((element) {
        // Check it is today or not.
        final difference = Utils.calculateDifference(element);
        if (difference == 0) {
          slots.add(Time(
              startTime: TimeOfDay.fromDateTime(DateTime.now()),
              endTime: TimeOfDay.fromDateTime(
                  DateFormat('HH:mm:ss').parse(settingDetail.endTime))));
        } else {
          slots.add(Time(
              startTime: TimeOfDay.fromDateTime(
                  DateFormat('HH:mm:ss').parse(settingDetail.startTime)),
              endTime: TimeOfDay.fromDateTime(
                  DateFormat('HH:mm:ss').parse(settingDetail.endTime))));
        }
      });
    });
  }

  void _btnContinueTap(BuildContext context) {
    List<int> flags = [];
    List<Map<String, String>> book = [];

    for (int i = 0; i < slots.length; i++) {
      var slot = slots[i];

      if (slot.startTime != null && slot.endTime != null) {
        double strTime =
            (slot.startTime.hour.toDouble() + (slot.startTime.minute / 60))
                .toPrecision(4);
        double endTime =
            (slot.endTime.hour.toDouble() + (slot.endTime.minute / 60))
                .toPrecision(4);
        print('@@@ $strTime, $endTime : ${(endTime - strTime).toPrecision(4)}');
        print('settingDetail = ${int.parse(settingDetail.minSlot).toDouble()}');
        if ((endTime - strTime) > 0) {
          if ((endTime - strTime).toPrecision(4) >=
              int.parse(settingDetail.minSlot).toDouble()) {
            var currentTime = TimeOfDay.fromDateTime(DateTime.now())
                    .hour
                    .toDouble() +
                TimeOfDay.fromDateTime(DateTime.now()).minute.toDouble() / 60;
            var officeStrTime = TimeOfDay.fromDateTime(
                        DateFormat('HH:mm:ss').parse(settingDetail.startTime))
                    .hour
                    .toDouble() +
                TimeOfDay.fromDateTime(DateFormat('HH:mm:ss')
                            .parse(settingDetail.startTime))
                        .minute
                        .toDouble() /
                    60;
            var officeEndTime = TimeOfDay.fromDateTime(
                        DateFormat('HH:mm:ss').parse(settingDetail.endTime))
                    .hour
                    .toDouble() +
                TimeOfDay.fromDateTime(
                            DateFormat('HH:mm:ss').parse(settingDetail.endTime))
                        .minute
                        .toDouble() /
                    60;
            bool isValid;

            if (dates[i].day == DateTime.now().day) {
              if (strTime >= officeStrTime &&
                  strTime <= officeEndTime &&
                  strTime >= currentTime &&
                  endTime >= officeStrTime &&
                  endTime <= officeEndTime) {
                isValid = true;
              } else {
                isValid = false;
              }
            } else {
              if (strTime >= officeStrTime &&
                  strTime <= officeEndTime &&
                  endTime >= officeStrTime &&
                  endTime <= officeEndTime) {
                isValid = true;
              } else {
                isValid = false;
              }
            }

            if (isValid) {
              book.add({
                'StartTime':
                    '${slot.startTime.hour}:${slot.startTime.minute}:00',
                'EndTime': '${slot.endTime.hour}:${slot.endTime.minute}:00',
                'StartDate': DateFormat('yyyy-MM-dd').format(dates[i]),
              });
              flags.add(1);
            } else {
              flags.add(0);
              Utils.showToastMsg('Please check office hours', context);
            }
          } else {
            Utils.showToastMsg('Please Check Min Time slot', context);
            flags.add(0);
          }
        } else {
          Utils.showToastMsg('EndTime is Greater than StartTime', context);
          flags.add(0);
        }
      } else {
        Utils.showToastMsg('Please select Time', context);
        flags.add(0);
      }
    }

    if (!flags.contains(0)) {
      print(book);
      _postMultipleTimeValidation(book, context);
    }
  }

  void _pickStartTime(int index, BuildContext context) async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: slots[index].startTime != null
          ? slots[index].startTime
          : TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context)?.copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (t != null) {
      setState(() {
        slots[index].startTime = TimeOfDay(hour: t.hour, minute: t.minute);
      });
    }
  }

  void _pickEndTime(int index, BuildContext context) async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime:
          slots[index].endTime != null ? slots[index].endTime : TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context)?.copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (t != null) {
      setState(() {
        slots[index].endTime = TimeOfDay(hour: t.hour, minute: t.minute);
      });
    }
  }

  void _postMultipleTimeValidation(
      List<Map<String, String>> book, BuildContext context) async {
    String selectedCompanyId = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.selectedCompany, '');
    String selectedFloorId = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.selectedFloor, '');
    String selectedLocationId = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.selectedLocation, '');
    String selectedDepartmentId = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.DEPARTMENTID, '');
    String selectedDepartmentName = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.DEPARTMENTNAME, '');

    Utils.showLoader(context);
    //print("${selectedCompanyId} ${selectedCompanyId} ${responseLogin.returnData.userDetails[0].roleformshowid} ${selectedLocationId} ${responseLogin.returnData.userDetails[0].roleformshowid} ${book}");
    MultipleTimeValidation response = await postMultipleTimeValidation(
        selectedCompanyId,
        selectedFloorId,
        responseLogin.returnData.userDetails[0].roleformshowid.toString(),
        selectedLocationId,
        responseLogin.returnData.userDetails[0].roleformshowid.toString(),
        book,
        selectedDepartmentId,
        context);

    print(response);

    if (response.returnData.validationWorkstation.length > 0) {
      print(response.returnData.validationWorkstation[0].date);
      Navigator.of(context).pushNamed('/workstation', arguments: response);
      if (Utils.userDetail.roleformshowid != 1) {
        Toast.show(
            'Booked times ${Utils.settingDetail.bookingcount} out of ${Utils.settingDetail.numberofBooking}',
            context,
            duration: 3);
      }
    } else {
      Utils.showToastMsg(response.message, context);
    }
    Utils.hideLoader();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: CustomButton(
            onPressed: () => _btnContinueTap(context),
            buttonText: 'Continue',
            smallText: true,
            buttonType: ButtonType.secondary,
          ),
        ),
        appBar: customAppBar(
          context,
          centerTitle: false,
          title: Text(
            'Select Time Slot',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: primary)
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: slots.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/optdesk/calendar-8.png',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "These times are available for ${DateFormat('dd-MMM-yyyy').format(dates[index])}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.white)
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Start Time",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.white)
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "End Time",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: Colors.white)
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/optdesk/time-8.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        slots[index].startTime != null
                                            ? '${slots[index].startTime.hour.toString().padLeft(2, '0')}:${slots[index].startTime.minute.toString().padLeft(2, '0')}:00'
                                            : 'Start Time',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 11,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/optdesk/downarrow-8.png',
                                    height: 17,
                                    width: 17,
                                  ),
                                ],
                              ),
                              onPressed: () => _pickStartTime(index, context),

                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 50,
                          width: 1,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/optdesk/time-8.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        slots[index].endTime != null
                                            ? '${slots[index].endTime.hour.toString().padLeft(2, '0')}:${slots[index].endTime.minute.toString().padLeft(2, '0')}:00'
                                            : 'End Time',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 11,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/optdesk/downarrow-8.png',
                                    height: 17,
                                    width: 17,
                                  ),
                                ],
                              ),
                              onPressed: () => _pickEndTime(index, context),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Time {
  Time({
    this.startTime,
    this.endTime,
  });

  TimeOfDay startTime;
  TimeOfDay endTime;
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
