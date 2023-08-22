import 'package:equatable/equatable.dart';
import 'package:mycra_timesheet_app/core/utils/name_parse.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:mycra_timesheet_app/data/models/role_model.dart';
import 'package:mycra_timesheet_app/data/models/type/collab_type.dart';

class Collab extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final bool isAdmin;

  const Collab({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isAdmin,
  });

  factory Collab.fromModel(CollabModel model) {
    return Collab(firstName: model.name, lastName: model.lastName, email: model.email, isAdmin: model.role == RoleModel.admin);
  }

  factory Collab.fromType(CollabType model) {
    return Collab(firstName: model.name, lastName: model.lastName, email: model.email, isAdmin: model.isAdmin);
  }

  String get fullName => '$firstName $lastName';

  String get shortName => fullName.shortName();

  @override
  List<Object> get props => [firstName, lastName, email, isAdmin];
}
