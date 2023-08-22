import 'package:json_annotation/json_annotation.dart';

enum RoleModel {
  @JsonValue("admin")
  admin,
  @JsonValue("collab")
  collab
}
