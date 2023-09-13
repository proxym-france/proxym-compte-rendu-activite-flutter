import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'project_model.dart';

sealed class BaseCraModel extends Equatable {
  final DateTime date;
  final int percentage;

  const BaseCraModel({required this.date, required this.percentage});
}

class ActivityModel extends BaseCraModel {
  final ProjectModel project;

  const ActivityModel({
    required super.percentage,
    required super.date,
    required this.project,
  });

  ActivityModel copyWith({
    int? percentage,
    DateTime? date,
    ProjectModel? project,
  }) =>
      ActivityModel(
        percentage: percentage ?? this.percentage,
        date: date ?? this.date,
        project: project ?? this.project,
      );

  factory ActivityModel.fromRawJson(String str) => ActivityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        percentage: json["percentage"],
        date: DateTime.parse(json["date"]),
        project: ProjectModel.fromJson(json["project"]),
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "date": date.toIso8601String(),
        "project": project.toJson(),
      };

  @override
  List<Object?> get props => [date, project];
}

class AbsenceModel extends BaseCraModel {
  final String raison;

  const AbsenceModel({
    required super.date,
    required this.raison,
    required super.percentage,
  });

  AbsenceModel copyWith({
    int? percentage,
    DateTime? date,
    String? raison,
  }) =>
      AbsenceModel(
        percentage: percentage ?? this.percentage,
        date: date ?? this.date,
        raison: raison ?? this.raison,
      );

  factory AbsenceModel.fromRawJson(String str) => AbsenceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AbsenceModel.fromJson(Map<String, dynamic> json) => AbsenceModel(
        percentage: json["percentage"],
        date: DateTime.parse(json["date"]),
        raison: json["raison"],
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "date": date.toIso8601String(),
        "raison": raison,
      };

  @override
  List<Object?> get props => [date, raison];
}

class HolidayModel extends BaseCraModel {
  final int id;
  final String name;

  const HolidayModel({
    required this.id,
    required super.date,
    required this.name,
    required super.percentage,
  });

  HolidayModel copyWith({
    int? id,
    DateTime? date,
    String? name,
    int? percentage,
  }) =>
      HolidayModel(
        id: id ?? this.id,
        date: date ?? this.date,
        name: name ?? this.name,
        percentage: percentage ?? this.percentage,
      );

  factory HolidayModel.fromRawJson(String str) => HolidayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        id: json["_id"],
        date: DateTime.parse(json["_date"]),
        name: json["_name"],
        percentage: json["_percentage"] ?? 100,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_date": date.toIso8601String(),
        "_name": name,
      };

  @override
  List<Object?> get props => [date, name, id];
}

class AvailableModel extends BaseCraModel {
  const AvailableModel({required super.date, required super.percentage});

  factory AvailableModel.fromJson(Map<String, dynamic> json) => AvailableModel(
        date: DateTime.parse(json["date"]),
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "percentage": percentage,
      };

  @override
  List<Object?> get props => [date];
}
