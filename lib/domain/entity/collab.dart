import 'package:equatable/equatable.dart';
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
    return Collab(
        firstName: model.name,
        lastName: model.lastName ?? '',
        email: model.email);
  }

  @override
  List<Object> get props => [firstName, lastName, email];
}
