import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/data/models/absence_model.dart';
import 'package:mycra_timesheet_app/data/models/activity_model.dart';
import 'package:mycra_timesheet_app/data/models/cra_model.dart';
import 'package:mycra_timesheet_app/data/models/holiday_model.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

class Cra extends Equatable {
  ///activity = project's name
  ///leave = Leave (hardcoded)
  ///holiday = holiday's name
  final String title;
  final CraType type;
  final DateTime date;

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type.value,
        "date": date.toIso8601String(),
      };

  Cra(this.title, this.type, this.date);

  //todo update project model
  factory Cra.fromActivity(ActivityModel model) => Cra(model.project.code, CraType.project, DateUtils.dateOnly(model.date));

  factory Cra.fromLeave(AbsenceModel model) =>
      Cra(model.raison, CraType.values.firstWhere((element) => element.value == model.raison), DateUtils.dateOnly(model.date));

  factory Cra.fromHoliday(HolidayModel model) => Cra(model.name, CraType.holiday, DateUtils.dateOnly(model.date));

  factory Cra.fromAvailable(DateTime date) => Cra('Available', CraType.blank, DateUtils.dateOnly(date));

  static List<CraCardModel> fromModel(CraModel model) {
    final Map<DateTime, List<Cra>> data = [
      ...model.activites.map((e) => Cra.fromActivity(e)).toList(),
      ...model.absences.map((e) => Cra.fromLeave(e)).toList(),
      ...model.holidays.map((e) => Cra.fromHoliday(e)).toList(),
      ...model.available.map((e) => Cra.fromAvailable(e)).toList(),
    ].groupListsBy((element) => element.date).map((key, value) => MapEntry(key, value.toSet().toList()));

    return CraCardModel.mapToCraCardModel(data.values.flattened.toSet());
  }

  @override
  List<Object?> get props => [title, type, date];
}
