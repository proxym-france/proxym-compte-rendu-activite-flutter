import 'dart:convert';

import 'package:mycra_timesheet_app/data/models/absence_model.dart';
import 'package:mycra_timesheet_app/data/models/activity_model.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:mycra_timesheet_app/data/models/holiday_model.dart';

class CraModel {
  final List<HolidayModel> holidays;
  final List<AbsenceModel> absences;
  final List<ActivityModel> activites;
  final int etat;
  final String status;
  final int id;
  final int month;
  final int year;
  final DateTime date;
  final CollabModel collab;

  CraModel({
    required this.holidays,
    required this.absences,
    required this.activites,
    required this.etat,
    required this.status,
    required this.id,
    required this.month,
    required this.year,
    required this.date,
    required this.collab,
  });

  CraModel copyWith({
    List<HolidayModel>? holidays,
    List<AbsenceModel>? absences,
    List<ActivityModel>? activites,
    int? etat,
    String? status,
    int? id,
    int? month,
    int? year,
    DateTime? date,
    CollabModel? collab,
  }) =>
      CraModel(
        holidays: holidays ?? this.holidays,
        absences: absences ?? this.absences,
        activites: activites ?? this.activites,
        etat: etat ?? this.etat,
        status: status ?? this.status,
        id: id ?? this.id,
        month: month ?? this.month,
        year: year ?? this.year,
        date: date ?? this.date,
        collab: collab ?? this.collab,
      );

  factory CraModel.fromRawJson(String str) =>
      CraModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CraModel.fromJson(Map<String, dynamic> json) => CraModel(
        holidays: List<HolidayModel>.from(
            json["_holidays"].map((x) => HolidayModel.fromJson(x))),
        absences: List<AbsenceModel>.from(
            json["_absences"].map((x) => AbsenceModel.fromJson(x))),
        activites: List<ActivityModel>.from(
            json["_activites"].map((x) => ActivityModel.fromJson(x))),
        etat: json["_etat"],
        status: json["_status"],
        id: json["_id"],
        month: json["_month"],
        year: json["_year"],
        date: DateTime.parse(json["_date"]),
        collab: CollabModel.fromJson(json["_collab"]),
      );

  Map<String, dynamic> toJson() => {
        "_holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
        "_absences": List<dynamic>.from(absences.map((x) => x.toJson())),
        "_activites": List<dynamic>.from(activites.map((x) => x.toJson())),
        "_etat": etat,
        "_status": status,
        "_id": id,
        "_month": month,
        "_year": year,
        "_date": date.toIso8601String(),
        "_collab": collab.toJson(),
      };
}
