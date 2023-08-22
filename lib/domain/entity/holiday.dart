import 'package:equatable/equatable.dart';

class Holiday extends Equatable {
  final num id;
  final String name;
  final DateTime date;

  const Holiday({
    required this.id,
    required this.name,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, date];
}
