import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';

class ProjectModel extends Equatable {
  final String code;
  final List<CollabModel> collabs;

  const ProjectModel({
    required this.code,
    required this.collabs,
  });

  factory ProjectModel.fromRawJson(String str) => ProjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        code: json["_code"],
        collabs: List<CollabModel>.from(json["_collabs"].map((x) => CollabModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_code": code,
        "_collabs": List<dynamic>.from(collabs.map((x) => x.toJson())),
      };

  factory ProjectModel.fromProject(Project project) =>
      ProjectModel(code: project.code, collabs: project.collabs.map((e) => CollabModel.fromCollab(e)).toList());

  @override
  List<Object?> get props => [code, collabs];
}
