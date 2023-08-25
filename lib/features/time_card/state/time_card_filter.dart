import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

enum TimecardFilter {
  all('All', CraType.values),
  notFilled('Not filled', [CraType.blank]),
  activity('Activity', [CraType.project, CraType.formation]),
  leave('Leave', [
    CraType.paidLeave,
    CraType.unpaidLeave,
    CraType.rTT,
    CraType.sickLeave,
    CraType.exceptional,
  ]);

  const TimecardFilter(this.name, this.type);

  final String name;
  final List<CraType> type;
}
