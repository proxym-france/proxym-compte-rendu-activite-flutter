import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/timecard.dart';

abstract class CraRepo {
  Future<TimeCard> fetchCurrentCraPerMonth(String user, int month, int year);

  Future<Map<DateTime, List<Cra>>> fetchCraPerUserPerMonth(String user, int month, int year);

  Future<Map<String, List<Cra>>> fetchCraPerUserPerProject(String user, int month, int year);

  Future<List<Cra>> fetchCras(String user, int month, int year);
}
