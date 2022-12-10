import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponseSettingDetails.dart';
import 'package:optdesk/models/ResponseUserList.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';
import 'package:optdesk/widgets/textfield.dart';

import '../api/network_utils.dart';
import '../models/ResponseCancelBooking.dart';
import '../models/response_check_booking.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late ResponseLogin responseLogin;

  late List<CompanyDetail> companyDetails;
  late List<LocationDetail> locationDetails;
  late List<BuildingDetail> buildingDetails;
  late List<FloorDetail> floorDetails;
  List<String> userRoles = ['Admin', 'User'];
  late List<UserDetail1> masterUserList;
  late List<UserDetail1> userList;

  late CompanyDetail? selectedCompany;
  late LocationDetail? selectedLocation;
  late BuildingDetail? selectedBuilding;
  late FloorDetail? selectedFloor;
  late String? selectedUserRole;
  late UserDetail1? selectedUser;

  late SettingDetail settingDetail;
  var departmentId;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.LOGIN_RESPONSE, '')
        .then((response) => {
              responseLogin = responseLoginFromJson(response),
              Utils.responseLogin = responseLogin,
              Utils.userDetail = responseLogin.returnData.userDetails[0],
              companyDetails = responseLogin.returnData.companyDetails,
              setState(() {})
            });

    SharedPreferencesHelper.getPrefString(
            SharedPreferencesHelper.DEPARTMENTID, '')
        .then((response) => {departmentId = response, setState(() {})});
    super.initState();
  }

  Future<void> _showCompanies(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                companyDetails =
                                    responseLogin.returnData.companyDetails;
                              } else {
                                companyDetails = [];
                                for (int i = 0;
                                    i <
                                        responseLogin
                                            .returnData.companyDetails.length;
                                    i++) {
                                  CompanyDetail company = responseLogin
                                      .returnData.companyDetails[i];
                                  String s = ("${company.companyName}")
                                      .toLowerCase()
                                      .trim();
                                  if (s.contains(val.toLowerCase())) {
                                    companyDetails.add(company);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: companyDetails.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                selectedCompany = companyDetails[index];
                                _setTheState();
                                Navigator.of(context).pop();
                                _getLocation();
                              },
                              title: Text(
                                '${companyDetails[index].companyName}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _showLocations(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                locationDetails =
                                    responseLogin.returnData.locationDetails;
                              } else {
                                locationDetails = [];
                                for (int i = 0;
                                    i <
                                        responseLogin
                                            .returnData.locationDetails.length;
                                    i++) {
                                  LocationDetail locDetail = responseLogin
                                      .returnData.locationDetails[i];
                                  String s = ("${locDetail.locationName}")
                                      .toLowerCase()
                                      .trim();
                                  if (s.contains(val.toLowerCase())) {
                                    locationDetails.add(locDetail);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: locationDetails.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                selectedLocation = locationDetails[index];
                                _setTheState();
                                Navigator.of(context).pop();
                                _getBuilding(selectedCompany!);
                              },
                              title: Text(
                                '${locationDetails[index].locationName}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _showBuildings(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, SetState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                buildingDetails =
                                    responseLogin.returnData.buildingDetails;
                              } else {
                                buildingDetails = [];
                                for (int i = 0;
                                    i <
                                        responseLogin
                                            .returnData.buildingDetails.length;
                                    i++) {
                                  BuildingDetail buildDetail = responseLogin
                                      .returnData.buildingDetails[i];
                                  String s = ("${buildDetail.buildingName}")
                                      .toLowerCase()
                                      .trim();
                                  if (s.contains(val.toLowerCase())) {
                                    buildingDetails.add(buildDetail);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: buildingDetails.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                selectedBuilding = buildingDetails[index];
                                _setTheState();
                                Navigator.of(context).pop();
                                _getFloor();
                              },
                              title: Text(
                                '${buildingDetails[index].buildingName}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _showFloors(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                floorDetails =
                                    responseLogin.returnData.floorDetails;
                              } else {
                                floorDetails = [];
                                for (int i = 0;
                                    i <
                                        responseLogin
                                            .returnData.floorDetails.length;
                                    i++) {
                                  FloorDetail floorDetail =
                                      responseLogin.returnData.floorDetails[i];
                                  String s = ("${floorDetail.floorName}")
                                      .toLowerCase()
                                      .trim();
                                  if (s.contains(val.toLowerCase())) {
                                    floorDetails.add(floorDetail);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: floorDetails.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                setState(() {
                                  selectedFloor = this.floorDetails[index];
                                });
                                Navigator.of(context).pop();
                                _setTheState();
                              },
                              title: Text(
                                '${floorDetails[index].floorName}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _showUserRoles(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (contextt) {
          return StatefulBuilder(
            builder: (contextt, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                userRoles = ['Admin', 'User'];
                              } else {
                                userRoles = [];
                                for (int i = 0; i < userRoles.length; i++) {
                                  String s =
                                      ("${userRoles[i]}").toLowerCase().trim();
                                  if (s.contains(val.toLowerCase())) {
                                    userRoles.add(userRoles[i]);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: userRoles.length,
                            itemBuilder: (contextt, index) => ListTile(
                              onTap: () {
                                setState(() {
                                  selectedUserRole = this.userRoles[index];
                                });
                                Navigator.of(context).pop();
                                _setTheState();
                                if (selectedUserRole == 'User') {
                                  _getUserList(context);
                                } else {
                                  userList = [];
                                  selectedUser = null;
                                  _setTheState();
                                }
                              },
                              title: Text(
                                '${userRoles[index]}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _showUsersList(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: CustomTextField(
                            placeholder: "Search",
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (val) {
                              if (val == null || val == "") {
                                userList = masterUserList;
                              } else {
                                userList = [];
                                for (int i = 0;
                                    i < masterUserList.length;
                                    i++) {
                                  UserDetail1 userDetail = masterUserList[i];
                                  String s = ("${userDetail.emailId}")
                                      .toLowerCase()
                                      .trim();
                                  if (s.contains(val.toLowerCase())) {
                                    userList.add(userDetail);
                                  }
                                }
                              }
                              setState(() {});
                            },
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/optdesk/search-8.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: userList.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                setState(() {
                                  selectedUser = this.userList[index];
                                });
                                Navigator.of(context).pop();
                                _setTheState();
                              },
                              title: Text(
                                '${userList[index].emailId}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  void _onTapScanNow(BuildContext context) async {
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
            CupertinoButton(
              onPressed: () async {
                // Navigator.of(context).pop();
                // String scanData = await FlutterBarcodeScanner.scanBarcode(
                //     "#ff6666", "Cancel", false, ScanMode.QR);
                // api(scanData);
              },
              child: const Text('Yes'),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }

  void api(String scanData) async {
    Utils.showLoader(context);
    var email = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.USER_EMAIL, '');
    ResponseCheckBooking response = await checkCancelBooking(
        Utils.userDetail!.userId.toString(),
        Utils.userDetail!.roleformshowid.toString(),
        '$scanData',
        email,
        context);
    showToastMsg(response.message);
    if (response.status) {
      _showConfirmationDialog(context, "\nBooking Scanned\nSuccessfully");
    }
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
                // Navigator.of(context).pop('reloadData');
              },
              child: const Text('Ok'),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: sideMenu(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: CustomButton(
            onPressed: () async {
              if (selectedCompany != null &&
                  responseLogin != null &&
                  selectedLocation != null &&
                  selectedFloor != null) {
                if (Utils.userDetail!.roleformshowid == 1) {
                  if (selectedUserRole == 'Admin') {
                    _getSettingDetails(context);
                    SharedPreferencesHelper.selectedUser = "";
                  } else if (selectedUserRole == 'User') {
                    if (selectedUser != null) {
                      _getSettingDetails(context);
                      SharedPreferencesHelper.selectedUser =
                          selectedUser!.emailId;
                    } else {
                      showToastMsg('Please select user');
                    }
                  } else {
                    showToastMsg('Please select booking for');
                  }
                } else {
                  SharedPreferencesHelper.selectedUser = "";
                  _getSettingDetails(context);
                }
              } else {
                showToastMsg('Please Select Fields');
              }
            },
            buttonText: 'Continue',
            buttonType: ButtonType.secondary,
            smallText: true,
          ),
        ),
        appBar: customAppBar(
          context,
          title: Text(
            'Home',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: primary)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Image.asset(
                'assets/optdesk/menu bar-8.png',
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed('/my_bookings_screen');
                _onTapScanNow(context);
              },
              child: Image.asset(
                'assets/optdesk/QR code-8.png',
                height: 25,
                width: 25,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/optdesk/Notification-8.png',
                height: 25,
                width: 25,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 25),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: AutoSizeText(
                                  "${selectedCompany != null ? selectedCompany!.companyName : companyDetails != null ? companyDetails[0].companyName : 'Select Company'}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                  minFontSize: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/optdesk/downarrow-8.png',
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                        onPressed: () {
                          companyDetails =
                              responseLogin.returnData.companyDetails;
                          _showCompanies(context);
                        },

                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: AutoSizeText(
                                  '${selectedLocation != null ? selectedLocation!.locationName : 'Select Location'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                  minFontSize: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/optdesk/downarrow-8.png',
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (locationDetails != null) {
                            _showLocations(context);
                          } else {
                            showToastMsg(
                                "No Locations Available");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: AutoSizeText(
                                  '${selectedBuilding != null ? selectedBuilding!.buildingName : 'Select Building'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                  minFontSize: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/optdesk/downarrow-8.png',
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (buildingDetails != null) {
                            _showBuildings(context);
                          } else {
                            showToastMsg(
                                "No Buildings Available");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: AutoSizeText(
                                  '${selectedFloor != null ? selectedFloor!.floorName : 'Select Floor'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                  minFontSize: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/optdesk/downarrow-8.png',
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (floorDetails != null) {
                            _showFloors(context);
                          } else {
                            showToastMsg("No Floors Available");
                          }
                        },
                      ),
                    ),
                    Utils.userDetail!.roleformshowid == 1
                        ? Column(
                            children: <Widget>[
                              const SizedBox(height: 12),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: grey),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: AutoSizeText(
                                            '${selectedUserRole != null ? selectedUserRole : 'Booking For'}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                ),
                                            minFontSize: 7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        'assets/optdesk/downarrow-8.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    if (selectedCompany != null) {
                                      _showUserRoles(context);
                                    } else {
                                      showToastMsg(
                                          'Please select company');
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                              selectedUserRole == 'User'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: ElevatedButton(
                                        // elevation: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: AutoSizeText(
                                                  '${selectedUser != null ? selectedUser!.emailId : 'Select User'}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15,
                                                      ),
                                                  minFontSize: 7,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              'assets/optdesk/downarrow-8.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          _showUsersList(context);
                                        },
                                        // color: Colors.white,
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       new BorderRadius.circular(10.0),
                                        // ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sideMenu() {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: primary,
              height: 150,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 12),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 45,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AutoSizeText(
                        '${Utils.userDetail!.userFirstName != null ? Utils.userDetail!.userFirstName : 'Username'}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                        minFontSize: 11,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/my_bookings_screen');
              },
              leading: Image.asset(
                'assets/optdesk/mybookings-8.png',
                color: primary,
                height: 25,
                width: 25,
              ),
              title: Text(
                'MY BOOKINGS',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/cancelled_bookings_screen');
              },
              leading: Image.asset(
                'assets/optdesk/mybookings-8.png',
                color: primary,
                height: 25,
                width: 25,
              ),
              title: Text(
                'CANCELLED BOOKINGS',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/faqs_screen');
              },
              leading: Image.asset(
                'assets/optdesk/settings-8.png',
                color: primary,
                height: 25,
                width: 25,
              ),
              title: Text(
                'FAQS/HELP',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              ),
            ),
            ListTile(
              onTap: _logout,
              leading: Image.asset(
                'assets/optdesk/logout-8.png',
                color: primary,
                height: 25,
                width: 25,
              ),
              title: Text(
                'LOGOUT',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getLocation() async {
    Utils.showLoader(context);
    setState(() {
      locationDetails = [];
      buildingDetails = [];
      floorDetails = [];
      userList = [];

      selectedUserRole = null;
      selectedUser = null;
      selectedLocation = null;
      selectedBuilding = null;
      selectedFloor = null;
    });
    ResponseLogin response = await getLoginDetail(
      "0",
      "0",
      context,
      companyId: selectedCompany!.companyId.toString(),
      userId: responseLogin.returnData.userDetails[0].userId.toString(),
      roleId: responseLogin.returnData.userDetails[0].roleformshowid.toString(),
      buildingId: "0",
      floorId: "0",
      locationId: "0",
      departmentId: departmentId,
    );
    if (response.returnData.locationDetails.isNotEmpty) {
      locationDetails = response.returnData.locationDetails;

      selectedLocation = locationDetails[0];
      _getBuilding(selectedCompany!);
    } else {
      showToastMsg(response.message);
    }
    setState(() {});
    Utils.hideLoader();
  }

  void _getBuilding(CompanyDetail selectCompany) async {
    Utils.showLoader(context);
    setState(() {
      buildingDetails = [];
      floorDetails = [];

      selectedBuilding = null;
      selectedFloor = null;
    });
    ResponseLogin response = await getLoginDetail(
      "0",
      "0",
      context,
      companyId: selectedCompany!.companyId.toString(),
      userId: responseLogin.returnData.userDetails[0].userId.toString(),
      roleId: responseLogin.returnData.userDetails[0].roleformshowid.toString(),
      buildingId: "0",
      floorId: "0",
      locationId: selectedLocation!.locationId.toString(),
      departmentId: departmentId,
    );
    if (response.returnData.buildingDetails.isNotEmpty) {
      buildingDetails = response.returnData.buildingDetails;

      selectedBuilding = buildingDetails[0];
      _getFloor();
    } else {
      showToastMsg(response.message);
    }
    setState(() {});
    Utils.hideLoader();
  }

  void _getFloor() async {
    Utils.showLoader(context);
    setState(() {
      floorDetails = [];
      selectedFloor = null;
    });
    ResponseLogin response = await getLoginDetail(
      "0",
      "0",
      context,
      companyId: selectedCompany!.companyId.toString(),
      userId: responseLogin.returnData.userDetails[0].userId.toString(),
      roleId: responseLogin.returnData.userDetails[0].roleformshowid.toString(),
      buildingId: selectedBuilding!.buildingId.toString(),
      floorId: "0",
      locationId: selectedLocation!.locationId.toString(),
      departmentId: departmentId,
    );
    if (response.returnData.floorDetails.isNotEmpty) {
      floorDetails = response.returnData.floorDetails;
      selectedFloor = floorDetails[0];
    } else {
      showToastMsg(response.message);
    }
    setState(() {});
    Utils.hideLoader();
  }

  void _getUserList(BuildContext context) async {
    Utils.showLoader(context);
    setState(() {
      userList = [];
      selectedUser = null;
    });
    UserList response =
        await getUserList(selectedCompany!.companyId.toString(),context);
    if (response.returnData.userDetails.isNotEmpty) {
      userList = response.returnData.userDetails;
      masterUserList = response.returnData.userDetails;
      selectedUser = userList[0];
    } else {
      showToastMsg(response.message);
    }
    setState(() {});
    Utils.hideLoader();
  }

  void _getSettingDetails(BuildContext context) async {
    Utils.showLoader(context);
    SettingDetails response = await getSettingDetails(
        selectedCompany!.companyId.toString(),
        responseLogin.returnData.userDetails[0].roleformshowid.toString(),
        selectedLocation!.locationId.toString(),
        responseLogin.returnData.userDetails[0].userId.toString(),
        context);
    if (response.returnData.settingDetails.isNotEmpty) {
      settingDetail = response.returnData.settingDetails[0];
      Utils.settingDetail = settingDetail;

      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.selectedCompany,
          selectedCompany!.companyId.toString());
      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.selectedLocation,
          selectedLocation!.locationId.toString());
      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.selectedBuilding,
          selectedBuilding!.buildingId.toString());
      SharedPreferencesHelper.setPrefString(
          SharedPreferencesHelper.selectedFloor,
          selectedFloor!.floorId.toString());

      //Navigator.of(context).pushNamed('/covid_screen'); //For testing
      if (response.isShow == '1') {
        Navigator.of(context).pushNamed('/covid_screen');
      } else if (response.isShow == "-1") {
        Utils.showContactAdminDialog(context);
      } else {
        Navigator.of(context).pushNamed('/calender_screen');
      }
    } else {
      showToastMsg(response.message);
    }
    Utils.hideLoader();
  }

  void _setTheState() {
    setState(() {});
  }

  void _logout() {
    SharedPreferencesHelper.setPrefBool(
        SharedPreferencesHelper.IS_LOGIN, false);
    SharedPreferencesHelper.setPrefString(
        SharedPreferencesHelper.LOGIN_RESPONSE, '');
    Utils.responseLogin = null;
    Utils.userDetail = null;

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
