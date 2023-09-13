import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String code;
  final String name;
  final String client;

  const ProjectModel({
    required this.code,
    required this.name,
    required this.client,
  });

  factory ProjectModel.fromRawJson(String str) => ProjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      code: json["_code"],
      name: json["_name"],
      client: json["_client"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_code": code,
        "_name": name,
        "_client": client,
      };

/*
  factory ProjectModel.fromProject(Project project) => ProjectModel(
        code: project.code, name: project.,
      );*/

  @override
  List<Object?> get props => [code, name, client];
}
