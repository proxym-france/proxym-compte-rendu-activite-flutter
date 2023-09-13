import 'package:equatable/equatable.dart';
import 'package:mycra_timesheet_app/data/models/project_model.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

class Project extends Equatable {
  final String code;
  final String name;
  final String client;
  final CraType craType;

  factory Project.fromModel(ProjectModel projectModel) =>
      Project(code: projectModel.code, name: projectModel.name, client: projectModel.client, craType: CraType.project);

  @override
  List<Object?> get props => [code, craType];

  const Project({required this.code, required this.name, required this.client, required this.craType});

  factory Project.fromLeave(CraType craType) => Project(code: craType.value, name: craType.value, client: 'Proxym', craType: craType);

  Project copyWith({String? code, String? name, String? client, CraType? craType}) =>
      Project(code: code ?? this.code, name: name ?? this.name, client: client ?? this.client, craType: craType ?? this.craType);
}
