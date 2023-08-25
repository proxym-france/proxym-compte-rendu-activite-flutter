import 'package:mycra_timesheet_app/domain/entity/Timecard.dart';

abstract class CraRepo {
  Future<TimeCard> fetchCurrentCraPerMonth(String user, int month, int year);
}
