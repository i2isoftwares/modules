import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'color.dart';

final now = DateTime.now();
final formatter = DateFormat('dd MMM yyyy');
final sendFormatter = DateFormat('MM/dd/yyyy');

//Today Date
String getTodayDate() {
  return getPastDay(0);
}

//Yesterday Date
String getYesterdayDate() {
  return getPastDay(1);
}

//Last 7 days
String getLastSevenDays() {
  return '${getPastDay(7)} - ${getPastDay(0)}';
}

//Last 30Days
String getLastThirtyDays() {
  return '${getPastDay(30)} - ${getPastDay(0)}';
}

String getPastDay(int day) {
  return formatter.format(now.subtract(Duration(days: day)));
}

int getId(Map<String, int> map, String selectedItem) {
  return map[selectedItem] ?? -1;
}

Future<DateTimeRange?> customDateRange(DateTimeRange? dates) async {
  return await showDateRangePicker(
    context: Get.context!,
    initialDateRange: dates,
    firstDate: DateTime(2020),
    lastDate: now,
    locale: const Locale('en', "IN"),
    fieldStartHintText: 'dd/MM/yyyy',
    fieldEndHintText: 'dd/MM/yyyy',
  );
}
