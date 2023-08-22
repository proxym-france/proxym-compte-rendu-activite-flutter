import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:mycra_timesheet_app/data/models/role_model.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';

part 'collab_type.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CollabType extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "email")
  final String email;
  @HiveField(1)
  @JsonKey(name: "name")
  final String name;
  @HiveField(2)
  @JsonKey(name: "lastname")
  final String lastName;
  @HiveField(3)
  @JsonKey(name: "isAdmin")
  final bool isAdmin;

  CollabType({required this.name, required this.lastName, required this.email, required this.isAdmin});

  CollabType copyWith({String? lastName, String? name, String? email, bool? isAdmin}) => CollabType(
        lastName: lastName ?? this.lastName,
        name: name ?? this.name,
        email: email ?? this.email,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  static CollabType fromModel(CollabModel collabModel) => CollabType(
        lastName: collabModel.lastName,
        name: collabModel.name,
        email: collabModel.email,
        isAdmin: collabModel.role == RoleModel.admin,
      );

  static CollabType fromEntity(Collab collab) => CollabType(
        lastName: collab.lastName,
        name: collab.firstName,
        email: collab.email,
        isAdmin: collab.isAdmin,
      );

  factory CollabType.fromJson(Map<String, dynamic> json) => _$CollabTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CollabTypeToJson(this);
}
