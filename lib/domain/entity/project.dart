import 'package:equatable/equatable.dart';
import 'package:mycra_timesheet_app/data/models/project_model.dart';

import 'collab.dart';

class Project extends Equatable {
  final String code;
  final List<Collab> collabs;

  const Project({
    required this.code,
    required this.collabs,
  });

  factory Project.fromModel(ProjectModel projectModel) => Project(
      code: projectModel.code,
      collabs: projectModel.collabs.map((e) => Collab.fromModel(e)).toList());

  Project copyWith({String? code, List<Collab>? collabs}) =>
      Project(
        code: code ?? this.code,
        collabs: collabs ?? this.collabs,
      );

  @override
  List<Object?> get props => [code, collabs];
}
