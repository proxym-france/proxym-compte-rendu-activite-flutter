import 'package:equatable/equatable.dart';
import 'package:mycra_timesheet_app/core/utils/nameParse.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';

class Collab extends Equatable {
  final String firstName;
  final String lastName;
  final String email;

  const Collab({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Collab.fromModel(CollabModel model) {
    var splitName = model.name.splitName();
    return Collab(
        firstName: splitName['name'] ?? '',
        lastName: "${splitName['lastName']} ${splitName['secondLastName']}",
        email: model.email);
  }

  @override
  List<Object> get props => [firstName, lastName, email];
}
