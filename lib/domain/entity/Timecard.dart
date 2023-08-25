import 'package:collection/collection.dart';
import 'package:mycra_timesheet_app/data/models/cra_model.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_filter.dart';

class TimeCard {
  final List<CraCardModel> cras;

  final MapEntry<TimecardFilter, double> available;
  final MapEntry<TimecardFilter, double> activity;
  final MapEntry<TimecardFilter, double> leave;

  MapEntry<TimecardFilter, double> get all => MapEntry(TimecardFilter.all, activity.value + available.value + leave.value);

  TimeCard(this.cras, double available, double activity, double leave)
      : this.available = MapEntry(TimecardFilter.notFilled, available),
        this.activity = MapEntry(TimecardFilter.activity, activity),
        this.leave = MapEntry(TimecardFilter.leave, leave);

  static TimeCard fromCraModel(CraModel model) {
    var activities = model.activites.map((e) => Cra.fromActivity(e)).toList();
    var leaves = model.absences.map((e) => Cra.fromLeave(e)).toList();
    var holidays = model.holidays.map((e) => Cra.fromHoliday(e)).toList();
    var available = model.available.map((e) => Cra.fromAvailable(e)).toList();

    final Map<DateTime, List<Cra>> data = [
      ...activities,
      ...leaves,
      ...holidays,
      ...available,
    ].groupListsBy((element) => element.date);
    return TimeCard(
      CraCardModel.mapToCraCardModel(data.values.map((e) => e.toSet().toList()).toList().sortedBy((element) => element[0].date)),
      extractDaysFromCra(available),
      extractDaysFromCra(activities),
      extractDaysFromCra(leaves),
    );
  }

  static double extractDaysFromCra(List<Cra> cras) {
    double result = 0;
    cras.groupListsBy((element) => element.date).values.forEach((element) {
      result += element.length;
    });

    return result;
  }

  double getCountPerFilter(TimecardFilter filter) => switch (filter) {
        TimecardFilter.all => all.value,
        TimecardFilter.activity => activity.value,
        TimecardFilter.notFilled => available.value,
        TimecardFilter.leave => leave.value,
      };
}
