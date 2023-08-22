import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mycra_timesheet_app/data/models/role_model.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';

part 'collab_model.g.dart';

@JsonSerializable()
class CollabModel extends Equatable {
  @JsonKey(name: "_lastname")
  final String lastName;
  @JsonKey(name: "_name")
  final String name;
  @JsonKey(name: "_email")
  final String email;
  @JsonKey(name: "_role")
  final RoleModel role;

  const CollabModel({
    required this.lastName,
    required this.name,
    required this.email,
    required this.role,
  });

  factory CollabModel.fromRawJson(String str) => CollabModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CollabModel copyWith({
    String? lastName,
    String? name,
    String? email,
    RoleModel? role,
  }) =>
      CollabModel(
        lastName: lastName ?? this.lastName,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
      );

  factory CollabModel.fromJson(Map<String, dynamic> json) => _$CollabModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollabModelToJson(this);

  factory CollabModel.fromCollab(Collab collab) => CollabModel(
        name: collab.firstName,
        lastName: collab.lastName,
        email: collab.email,
        role: collab.isAdmin ? RoleModel.admin : RoleModel.collab,
      );

  @override
  List<Object?> get props => [name, lastName, email, role];
}
