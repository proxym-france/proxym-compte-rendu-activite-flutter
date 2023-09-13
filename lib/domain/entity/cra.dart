import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/data/models/base_cra_model.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';

class Cra extends Equatable {
  ///activity = project's name
  ///leave = Leave (hardcoded)
  ///holiday = holiday's name
  final String title;
  final CraType type;
  final int percentage;
  final DateTime date;
  final Project project;

  const Cra(this.title, this.type, this.date, this.percentage, this.project);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type.value,
      "percentage": percentage,
      "date": date.toIso8601String(),
    };
  }

  Cra copyWith({String? title, CraType? type, DateTime? date, int? percentage, Project? project}) =>
      Cra(title ?? this.title, type ?? this.type, date ?? this.date, percentage ?? this.percentage, project ?? this.project);

  //todo update project model
  factory Cra.fromActivity(ActivityModel model) =>
      Cra(model.project.name, CraType.project, DateUtils.dateOnly(model.date), model.percentage, Project.fromModel(model.project));

  factory Cra.fromLeave(AbsenceModel model) {
    final type = CraType.values.firstWhere((element) => element.value == model.raison);
    return Cra(model.raison, type, DateUtils.dateOnly(model.date), model.percentage, Project.fromLeave(type));
  }

  factory Cra.fromHoliday(HolidayModel model) =>
      Cra(model.name, CraType.holiday, DateUtils.dateOnly(model.date), model.percentage, Project.fromLeave(CraType.holiday));

  factory Cra.fromAvailable(AvailableModel model) =>
      Cra('Available', CraType.blank, DateUtils.dateOnly(model.date), model.percentage, Project.fromLeave(CraType.blank));

  factory Cra.fromModel(BaseCraModel model) => switch (model) {
        ActivityModel() => Cra.fromActivity(model),
        HolidayModel() => Cra.fromHoliday(model),
        AbsenceModel() => Cra.fromLeave(model),
        AvailableModel() => Cra.fromAvailable(model)
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [title, type, date, percentage, project];
}
