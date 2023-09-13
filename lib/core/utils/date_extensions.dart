import 'package:flutter/material.dart';
import 'package:week_of_year/date_week_extensions.dart';
import 'package:week_of_year/datetime_from_week_number.dart';

extension DateExtensions on DateTime {
  DateTime atFirstDayOfTheMonth() => copyWith(day: 1);

  DateTime atLastDayOfTheMonth() => copyWith(month: month + 1, day: 0);

  ({DateTime end, DateTime start}) getWeekWithinMonth([int? weekYear]) {
    var start = dateTimeFromWeekNumber(year, weekYear ?? weekOfYear, DateTime.monday);
    if (start.month != month) {
      start = atFirstDayOfTheMonth();
    }
    var end = dateTimeFromWeekNumber(year, weekYear ?? weekOfYear, DateTime.friday);
    if (end.month != month) {
      end = atLastDayOfTheMonth();
    }
    return (start: DateUtils.dateOnly(start), end: DateUtils.dateOnly(end));
  }

  List<DateTime> generateListToDate(DateTime start) {
    final count = difference(start).inDays + 1;
    return List.generate(count, (index) => start.add(Duration(days: index)));
  }
}
