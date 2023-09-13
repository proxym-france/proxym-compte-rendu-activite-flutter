import 'dart:convert';

import 'package:mycra_timesheet_app/core/utils/date_extensions.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:week_of_year/date_week_extensions.dart';

class CreateActivityState {
  final State<List<Project>> userProjects;
  final State<Map<int, Map<Project, List<Cra>>>> cras;

  final List<Cra> added;
  final List<Cra> holidays;
  final int weekOfYear;
  final DateTime activeMonth;
  final Map<int, List<({DateTime date, int percentage})>> summary;

  CreateActivityState.initial({
    State<List<Project>>? userProjects,
    State<Map<int, Map<Project, List<Cra>>>>? cras,
    List<Cra>? added,
    List<Cra>? holidays,
    List<Cra>? deleted,
    int? weekOfYear,
    Map<String, List<Cra>>? weekCras,
    Map<DateTime, List<Cra>>? crasPerDate,
    Map<String, List<Cra>>? crasPerProject,
    required this.activeMonth,
    Map<int, List<({DateTime date, int percentage})>>? summary,
  })  : userProjects = userProjects ?? Loading(),
        cras = cras ?? Loading(),
        added = added ?? [],
        holidays = holidays ?? [],
        weekOfYear = weekOfYear ?? activeMonth.atFirstDayOfTheMonth().weekOfYear,
        summary = summary ?? {};

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "userProjects": userProjects,
      "cras": cras,
      "added": jsonEncode(added),
      "holidays": jsonEncode(holidays),
      "weekOfYear": weekOfYear,
      "activeMonth": activeMonth.toIso8601String(),
      "summary": summary,
    };
  }

  const CreateActivityState({
    required this.userProjects,
    required this.cras,
    required this.added,
    required this.holidays,
    required this.weekOfYear,
    required this.activeMonth,
    required this.summary,
  });

  CreateActivityState copyWith({
    State<List<Project>>? userProjects,
    State<Map<int, Map<Project, List<Cra>>>>? cras,
    List<Cra>? added,
    List<Cra>? holidays,
    int? weekOfYear,
    DateTime? activeMonth,
    Map<int, List<({DateTime date, int percentage})>>? summary,
  }) {
    return CreateActivityState(
      userProjects: userProjects ?? this.userProjects,
      cras: cras ?? this.cras,
      added: added ?? this.added,
      holidays: holidays ?? this.holidays,
      weekOfYear: weekOfYear ?? this.weekOfYear,
      activeMonth: activeMonth ?? this.activeMonth,
      summary: summary ?? this.summary,
    );
  }
}
