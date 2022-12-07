import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/network_utils.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseConfirmationBooking.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponseMultipleSave.dart';
import 'package:optdesk/models/ResponseMultipleTimeValidation.dart';
import 'package:optdesk/widgets/shared/app_bar.dart';
import 'package:optdesk/widgets/shared/button.dart';

class WorkstationScreen extends StatefulWidget {
  final MultipleTimeValidation data;

  WorkstationScreen({@required this.data});

  @override
  _WorkstationScreenState createState() => _WorkstationScreenState();
}

class _WorkstationScreenState extends State<WorkstationScreen> {
  List<WorkstationList> selectedWorkstationList = [];
  late ConfirmationBooking bookingDetails;
  late List<ValidationWorkstation> validationWorkstation;
  late ResponseLogin responseLogin;

  late String selectedCompanyId;
  late String selectedBuildingId;
  late String selectedFloorId;
  late String selectedLocationId;
  var departmentName;

  bool isConfirmBtnEnabled = true;
  int radioBtnValue = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.LOGIN_RESPONSE, '')
        .then((response) =>
            {responseLogin = responseLoginFromJson(response), setState(() {})});

    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.DEPARTMENTNAME, "")
        .then((value) => {departmentName = value, setState(() {})});

    validationWorkstation = widget.data.returnData.validationWorkstation;
  }

  void _bookSeat(BuildContext context) async {
    if (selectedWorkstationList.length > 0) {
      // Check user role. 1 for Admin, 2 for user
      if (Utils.userDetail.roleformshowid == 1) {
        if ((Utils.settingDetail.bookingcount <
            Utils.settingDetail.numberofBooking)) {
          String selectedCompanyId =
              await SharedPreferencesHelper.getPrefString(
                  SharedPreferencesHelper.selectedCompany, '');
          String selectedBuildingId =
              await SharedPreferencesHelper.getPrefString(
                  SharedPreferencesHelper.selectedBuilding, '');
          String selectedFloorId = await SharedPreferencesHelper.getPrefString(
              SharedPreferencesHelper.selectedFloor, '');
          String selectedLocationId =
              await SharedPreferencesHelper.getPrefString(
                  SharedPreferencesHelper.selectedLocation, '');

          this.selectedCompanyId = selectedCompanyId;
          this.selectedLocationId = selectedLocationId;
          this.selectedBuildingId = selectedBuildingId;
          this.selectedFloorId = selectedFloorId;

          List<Map<String, String>> book = [];
          for (int i = 0; i < validationWorkstation.length; i++) {
            for (int j = 0;
                j < validationWorkstation[i].workstationList.length;
                j++) {
              TimeOfDay strTime = TimeOfDay.fromDateTime(DateFormat('HH:mm:ss')
                  .parse(validationWorkstation[i].startTime));
              TimeOfDay endTime = TimeOfDay.fromDateTime(DateFormat('HH:mm:ss')
                  .parse(validationWorkstation[i].endTime));

              // Booking status 2 - Selected Seats
              if (validationWorkstation[i].workstationList[j].bookingStatus ==
                  2) {
                book.add({
                  'StartTime': '${strTime.hour}:${strTime.minute}:00',
                  'EndTime': '${endTime.hour}:${endTime.minute}:00',
                  'StartDate': DateFormat('yyyy-MM-dd')
                      .format(validationWorkstation[i].date),
                  'WorkstationId': validationWorkstation[i]
                      .workstationList[j]
                      .workstationId
                      .toString(),
                });
              }
            }
          }

          Utils.showLoader(context);
          ConfirmationBooking response = await postConfirmBooking(
              selectedCompanyId,
              selectedFloorId,
              selectedBuildingId,
              responseLogin.returnData.userDetails[0].roleformshowid.toString(),
              selectedLocationId,
              responseLogin.returnData.userDetails[0].userId.toString(),
              book,
              context);

          if (response.returnData.confirmationDetails.length > 0) {
            this.bookingDetails = response;
            _showBookingDialog(context, book);
          } else {
            Utils.showToastMsg(response.message, context);
          }
          Utils.hideLoader();
        } else {
          Utils.showToastMsg('Booking limit exceeds for this month', context);
        }
      } else {
        if (selectedWorkstationList.length <= Utils.settingDetail.workstation) {
          if ((Utils.settingDetail.bookingcount <
              Utils.settingDetail.numberofBooking)) {
            String selectedCompanyId =
                await SharedPreferencesHelper.getPrefString(
                    SharedPreferencesHelper.selectedCompany, '');
            String selectedBuildingId =
                await SharedPreferencesHelper.getPrefString(
                    SharedPreferencesHelper.selectedBuilding, '');
            String selectedFloorId =
                await SharedPreferencesHelper.getPrefString(
                    SharedPreferencesHelper.selectedFloor, '');
            String selectedLocationId =
                await SharedPreferencesHelper.getPrefString(
                    SharedPreferencesHelper.selectedLocation, '');

            this.selectedCompanyId = selectedCompanyId;
            this.selectedLocationId = selectedLocationId;
            this.selectedBuildingId = selectedBuildingId;
            this.selectedFloorId = selectedFloorId;

            List<Map<String, String>> book = [];
            for (int i = 0; i < validationWorkstation.length; i++) {
              for (int j = 0;
                  j < validationWorkstation[i].workstationList.length;
                  j++) {
                TimeOfDay strTime = TimeOfDay.fromDateTime(
                    DateFormat('HH:mm:ss')
                        .parse(validationWorkstation[i].startTime));
                TimeOfDay endTime = TimeOfDay.fromDateTime(
                    DateFormat('HH:mm:ss')
                        .parse(validationWorkstation[i].endTime));

                // Booking status 2 - Selected Seats
                if (validationWorkstation[i].workstationList[j].bookingStatus ==
                    2) {
                  book.add({
                    'StartTime': '${strTime.hour}:${strTime.minute}:00',
                    'EndTime': '${endTime.hour}:${endTime.minute}:00',
                    'StartDate': DateFormat('yyyy-MM-dd')
                        .format(validationWorkstation[i].date),
                    'WorkstationId': validationWorkstation[i]
                        .workstationList[j]
                        .workstationId
                        .toString(),
                  });
                }
              }
            }

            Utils.showLoader(context);
            ConfirmationBooking response = await postConfirmBooking(
                selectedCompanyId,
                selectedFloorId,
                selectedBuildingId,
                responseLogin.returnData.userDetails[0].roleformshowid
                    .toString(),
                selectedLocationId,
                responseLogin.returnData.userDetails[0].userId.toString(),
                book,
                context);

            if (response.returnData.confirmationDetails.length > 0) {
              this.bookingDetails = response;
              _showBookingDialog(context, book);
            } else {
              Utils.showToastMsg(response.message, context);
            }
            Utils.hideLoader();
          } else {
            Utils.showToastMsg('Booking limit exceeds for this month', context);
          }
        } else {
          Utils.showToastMsg('Maximum booking limit reached', context);
        }
      }
    } else {
      Utils.showToastMsg('Please select seat', context);
    }
  }

  void _confirmSeat(
      BuildContext context, List<Map<String, String>> book) async {
    setState(() {
      isConfirmBtnEnabled = false;
    });
    String foodPref = '';
    if (radioBtnValue == 1) {
      foodPref = 'Veg';
    } else if (radioBtnValue == 2) {
      foodPref = 'Non-Veg';
    } else if (radioBtnValue == 3) {
      foodPref = 'None';
    } else {
      foodPref = '';
    }

    Utils.showLoader(context);
    MultipleSave response = await postMultipleSave(
        SharedPreferencesHelper.selectedUser,
        selectedCompanyId,
        selectedFloorId,
        selectedBuildingId,
        responseLogin.returnData.userDetails[0].roleformshowid.toString(),
        selectedLocationId,
        responseLogin.returnData.userDetails[0].userId.toString(),
        book,
        foodPref,
        context);

    if (response.status) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/booking_confirmation', ModalRoute.withName('/home'));
    } else {
      Utils.showToastMsg(response.message, context);
    }
    setState(() {
      isConfirmBtnEnabled = true;
    });
  }

  Future<void> _showBookingDialog(
      BuildContext context, List<Map<String, String>> book) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          //shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: <Widget>[
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
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              bookingDetails
                                                  .returnData
                                                  .confirmationDetails[0]
                                                  .locationName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .apply(color: Colors.black)
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
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
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              bookingDetails
                                                  .returnData
                                                  .confirmationDetails[0]
                                                  .buildingName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: Colors.black)
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Utils.settingDetail.isVegNonVeg
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 12),
                                            Text(
                                              'Please choose your food preference',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: Colors.grey)
                                                  .copyWith(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            RadioListTile(
                                              value: 1,
                                              groupValue: radioBtnValue,
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                'Veg',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.apply(color: Colors.black)
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  radioBtnValue = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile(
                                              value: 2,
                                              groupValue: radioBtnValue,
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                'Non-Veg',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.apply(color: Colors.black)
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  radioBtnValue = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile(
                                              value: 3,
                                              groupValue: radioBtnValue,
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                'None',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.apply(color: Colors.black)
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  radioBtnValue = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(height: 12),
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
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              bookingDetails
                                                  .returnData
                                                  .confirmationDetails[0]
                                                  .floorName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: Colors.black)
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Department Name',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: Colors.grey)
                                                  .copyWith(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              departmentName != null
                                                  ? departmentName
                                                  : "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: Colors.black)
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: ListView.builder(
                                //physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: bookingDetails.returnData
                                    .confirmationDetails[0].book.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Workstation No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: Colors.black)
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  bookingDetails
                                                      .returnData
                                                      .confirmationDetails[0]
                                                      .book[index]
                                                      .workstationName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: Colors.black)
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'From',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.apply(color: Colors.black)
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  DateFormat('dd-MMM-yyyy')
                                                      .format(bookingDetails
                                                          .returnData
                                                          .confirmationDetails[
                                                              0]
                                                          .book[index]
                                                          .date),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: Colors.black)
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  bookingDetails
                                                      .returnData
                                                      .confirmationDetails[0]
                                                      .book[index]
                                                      .startTime
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: textDarkGrey)
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'To',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.apply(color: Colors.black)
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  DateFormat('dd-MMM-yyyy')
                                                      .format(bookingDetails
                                                          .returnData
                                                          .confirmationDetails[
                                                              0]
                                                          .book[index]
                                                          .date),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: Colors.black)
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  bookingDetails
                                                      .returnData
                                                      .confirmationDetails[0]
                                                      .book[index]
                                                      .toTime
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.apply(
                                                          color: textDarkGrey)
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          const Divider(),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: CustomButton(
                      buttonText: 'Click to Confirm',
                      onPressed: isConfirmBtnEnabled
                          ? () => _confirmSeat(context, book)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'Workstation',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              String floorId = await SharedPreferencesHelper.getPrefString(
                  SharedPreferencesHelper.selectedFloor, '');

              Navigator.of(context).pushNamed('/view_floor_map_screen',
                  arguments: int.parse(floorId));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Image.asset(
                'assets/optdesk/location-8.png',
                color: primary,
                height: 23,
                width: 23,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: validationWorkstation.length,
          itemBuilder: (BuildContext context, int index) => Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 45,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Text(
                          "Your Booking on : ${DateFormat('dd-MMM-yyyy').format(validationWorkstation[index].date)}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.apply(color: Colors.white)
                              .copyWith(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: AutoSizeText(
                          "    ${_getSeats(index)}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.apply(color: green)
                              .copyWith(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          minFontSize: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: validationWorkstation[index].workstationList.length,
                itemBuilder: (context, workstationIndex) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (validationWorkstation[index]
                              .workstationList[workstationIndex]
                              .bookingStatus ==
                          0) {
                        validationWorkstation[index]
                            .workstationList[workstationIndex]
                            .bookingStatus = 2;
                        selectedWorkstationList.add(validationWorkstation[index]
                            .workstationList[workstationIndex]);
                      } else if (validationWorkstation[index]
                              .workstationList[workstationIndex]
                              .bookingStatus ==
                          1) {
                        Utils.showToastMsg(
                            '${validationWorkstation[index].workstationList[workstationIndex].workstationName} seat already booked',
                            context);
                      } else if (validationWorkstation[index]
                              .workstationList[workstationIndex]
                              .bookingStatus ==
                          2) {
                        validationWorkstation[index]
                            .workstationList[workstationIndex]
                            .bookingStatus = 0;
                        selectedWorkstationList.remove(
                            validationWorkstation[index]
                                .workstationList[workstationIndex]);
                      }
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset(
                        validationWorkstation[index]
                                    .workstationList[workstationIndex]
                                    .bookingStatus ==
                                1
                            ? 'assets/optdesk/filled color-8.png'
                            : validationWorkstation[index]
                                        .workstationList[workstationIndex]
                                        .bookingStatus ==
                                    2
                                ? 'assets/optdesk/yellow color-8.png'
                                : 'assets/optdesk/white color-8.png',
                        height: 70,
                        width: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          validationWorkstation[index]
                              .workstationList[workstationIndex]
                              .workstationName
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.apply(color: textDarkGrey)
                              .copyWith(
                                  fontSize: 9, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getSeats(int index) {
    List<String> seats = [];
    for (int i = 0;
        i < validationWorkstation[index].workstationList.length;
        i++) {
      if (validationWorkstation[index].workstationList[i].bookingStatus == 0) {
        seats.add(validationWorkstation[index]
            .workstationList[i]
            .bookingStatus
            .toString());
      }
    }
    return '${seats.length} - of - ${validationWorkstation[index].workstationList.length}';
  }

  Widget _bottomNavBar() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/optdesk/remember uncheck-8.png',
                      color: Colors.grey.withOpacity(0.5),
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: AutoSizeText(
                          'Available Seat',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 11),
                          minFontSize: 5,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.grey.shade400,
                      child: Image.asset(
                        'assets/optdesk/remember uncheck-8.png',
                        color: Colors.grey,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: AutoSizeText(
                          'Booked Seat',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 11),
                          minFontSize: 5,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/optdesk/remember uncheck-8.png',
                      color: primary,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: AutoSizeText(
                          'Selected Seat',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 11),
                          minFontSize: 5,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width * 1,
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Book your seat',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            ),
            onPressed: () => _bookSeat(context),

          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
