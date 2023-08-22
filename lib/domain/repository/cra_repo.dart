import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';

abstract class CraRepo {
  Future<List<CraCardModel>> fetchCurrentCraPerMonth(String user, int month, int year);
}
