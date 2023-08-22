import 'dart:convert';

import 'package:mycra_timesheet_app/data/models/project_model.dart';

class ActivityModel {
  final bool matin;
  final DateTime date;
  final ProjectModel project;

  ActivityModel({
    required this.matin,
    required this.date,
    required this.project,
  });

  ActivityModel copyWith({
    bool? matin,
    DateTime? date,
    ProjectModel? project,
  }) =>
      ActivityModel(
        matin: matin ?? this.matin,
        date: date ?? this.date,
        project: project ?? this.project,
      );

  factory ActivityModel.fromRawJson(String str) =>
      ActivityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        matin: json["matin"],
        date: DateTime.parse(json["date"]),
        project: ProjectModel.fromJson(json["project"]),
      );

  Map<String, dynamic> toJson() => {
        "matin": matin,
        "date": date.toIso8601String(),
        "project": project.toJson(),
      };
}
