import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/shared_preferences_helper.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponseSettingDetails.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:optdesk/widgets/button.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late SettingDetail settingDetail;
  // late CalendarController _calendarController;

  late UserDetail userDetail;

  Map<DateTime, List> _events = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.LOGIN_RESPONSE, '')
        .then((response) => {
      userDetail = responseLoginFromJson(response).returnData.userDetails[0],
      setState(() {})
    });
    settingDetail = Utils.settingDetail!;
    // _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

  void _onContinue(BuildContext context) {
    final dates = _events.keys;
    if (_events.isNotEmpty) {
//      if(userDetail.roleformshowid == 2){
//        _usualCondition();
//      }else{
//
//      }
      if(settingDetail.isOddEven == false){
        // OddEven == False...So, Usual process
        _usualCondition();
      }else{
        // need to check future date
        bool isValid = true;
        dates.forEach((element) {
          if (Utils.calculateDifference(element).isNegative || Utils.calculateDifference(element) > 0) {
            isValid = false;
          }
        });
        if(isValid){
          _usualCondition();
        }else{
          showToastMsg('Future or Past dates are not allowed');
        }
      }
    } else {
      showToastMsg('Please Select Date');
    }
  }

  void _usualCondition(){
    final dates = _events.keys;
    bool isValidDate = true;
    dates.forEach((element) {
      if (Utils.calculateDifference(element).isNegative) {
        isValidDate = false;
      }
    });
    if (isValidDate) {
      if (int.parse(settingDetail.maxHours) >= dates.length) {
        bool flag = true;
        dates.forEach((element) {
          if (Utils.calculateDifference(element) >= settingDetail.priorDays) {
            flag = false;
          }
        });
        if (flag) {
          bool flag1 = true;
          print('Role id : ${userDetail.roleformshowid}');
          if (userDetail.roleformshowid == 2) {
            dates.forEach((element) {
              if(element.weekday == 6 || element.weekday == 7){
                flag1 = false;
              }
            });
          }
          if(flag1){
            Navigator.of(context)
                .pushNamed('/time_selection', arguments: _events);
          }else{
            showToastMsg('Unable to book Saturday & Sunday');
          }
        } else {
          showToastMsg('Prior Days Issue');
        }
      } else {
        showToastMsg('Maximum Date reached contact admin');
      }
    } else {
      showToastMsg('Please Select Valid Date');
    }
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      if (!_events.containsKey(day)) {
        _events.putIfAbsent(day, () => ['']);
      } else {
        _events.remove(day);
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
          'Book Your Workstation',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12),
              Text(
                'This user is allowed to book for maximum ${settingDetail != null ? settingDetail.maxHours : ''} days',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.apply(color: Colors.black)
                    .copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                    ),
              ),
              SizedBox(height: 12),
              // TableCalendar(
              //   calendarController: _calendarController,
              //   events: _events,
              //   daysOfWeekStyle: DaysOfWeekStyle(
              //     weekendStyle: Theme.of(context)
              //         .textTheme
              //         .subtitle1
              //         ?.apply(color: Colors.redAccent),
              //     weekdayStyle: Theme.of(context).textTheme.subtitle1,
              //   ),
              //   holidays: _events,
              //   calendarStyle: CalendarStyle(
              //     selectedColor: primary,
              //     todayColor: primary,
              //     markersColor: Colors.brown[700],
              //     outsideDaysVisible: false,
              //     highlightSelected: false,
              //     highlightToday: false,
              //     holidayStyle: Theme.of(context)
              //         .textTheme
              //         .bodyText2
              //         ?.apply(color: primary),
              //     weekendStyle: Theme.of(context)
              //         .textTheme
              //         .subtitle1
              //         ?.apply(color: Colors.redAccent),
              //     weekdayStyle: Theme.of(context).textTheme.subtitle1,
              //   ),
              //   headerStyle: HeaderStyle(
              //     centerHeaderTitle: true,
              //     formatButtonVisible: false,
              //     headerPadding: EdgeInsets.zero,
              //     decoration: BoxDecoration(color: primary),
              //   ),
              //   onDaySelected: (datetime, list) => _onDaySelected(datetime, list),
              // ),
              SizedBox(height: 36),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onPressed: () => _onContinue(context),
                  buttonText: 'Continue',
                  buttonType: ButtonType.secondary,
                  smallText: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
