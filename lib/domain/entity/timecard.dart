import 'package:collection/collection.dart';
import 'package:mycra_timesheet_app/data/models/base_cra_model.dart';
import 'package:mycra_timesheet_app/data/models/cra_model.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_card_model.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_filter.dart';

class TimeCard {
  final List<CraCardModel> cras;

  final MapEntry<TimecardFilter, double> available;
  final MapEntry<TimecardFilter, double> activity;
  final MapEntry<TimecardFilter, double> leave;

  MapEntry<TimecardFilter, double> get all => MapEntry(TimecardFilter.all, activity.value + available.value + leave.value);

  TimeCard(this.cras, double available, double activity, double leave)
      : available = MapEntry(TimecardFilter.notFilled, available),
        activity = MapEntry(TimecardFilter.activity, activity),
        leave = MapEntry(TimecardFilter.leave, leave);

  static TimeCard fromCraModel(CraModel model) {
    final Map<DateTime, List<Cra>> data = [
      ...model.activites,
      ...model.absences,
      ...model.holidays,
      ...model.available,
    ].map((e) => Cra.fromModel(e)).groupListsBy((element) => element.date);

    return TimeCard(
      CraCardModel.mapToCraCardModel(data.values.map((e) => e.toSet().toList()).toList().sortedBy((element) => element[0].date)),
      extractDaysFromCra(model.available),
      extractDaysFromCra(model.activites),
      extractDaysFromCra(model.absences),
    );
  }

  static double extractDaysFromCra(List<BaseCraModel> cras) {
    return cras.map((e) => e.percentage).sum / 100;
  }

  double getCountPerFilter(TimecardFilter filter) => switch (filter) {
        TimecardFilter.all => all.value,
        TimecardFilter.activity => activity.value,
        TimecardFilter.notFilled => available.value,
        TimecardFilter.leave => leave.value,
      };
}
