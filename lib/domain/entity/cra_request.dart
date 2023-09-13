import 'package:equatable/equatable.dart';

class CraRequest extends Equatable {
  final String user;
  final DateTime monthYear;

  const CraRequest({required this.user, required this.monthYear});

  @override
  List<Object?> get props => [user, monthYear];
}
