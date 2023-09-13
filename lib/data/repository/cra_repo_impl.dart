import 'package:collection/collection.dart';
import 'package:mycra_timesheet_app/data/data_source/remote/cra_data_source.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/timecard.dart';
import 'package:mycra_timesheet_app/domain/repository/cra_repo.dart';

class CraRepoImpl implements CraRepo {
  final CraRemoteDataSource craRemoteDataSource;

  CraRepoImpl(this.craRemoteDataSource);

  @override
  Future<TimeCard> fetchCurrentCraPerMonth(String user, int month, int year) async {
    final craModel = await craRemoteDataSource.getCurrentCraPerUser(user, month, year);
    return TimeCard.fromCraModel(craModel);
  }

  @override
  Future<List<Cra>> fetchCras(String user, int month, int year) async {
    final model = await craRemoteDataSource.getCurrentCraPerUser(user, month, year);
    final data = [...model.activites, ...model.absences, ...model.holidays, ...model.available]
        .sortedBy((element) => element.date)
        .map((e) => Cra.fromModel(e))
        .toList();
    return data;
  }

  @override
  Future<Map<DateTime, List<Cra>>> fetchCraPerUserPerMonth(String user, int month, int year) async {
    final model = await craRemoteDataSource.getCurrentCraPerUser(user, month, year);

    final data = [...model.activites, ...model.absences, ...model.holidays, ...model.available]
        .sortedBy((element) => element.date)
        .groupListsBy((element) => element.date)
        .map((key, crasPerDay) {
      return MapEntry(
        key,
        crasPerDay.toSet().map((e) => Cra.fromModel(e)).toList(),
      );
    });
    return data;
  }

  @override
  Future<Map<String, List<Cra>>> fetchCraPerUserPerProject(String user, int month, int year) async {
    final model = await craRemoteDataSource.getCurrentCraPerUser(user, month, year);

    final data = [
      ...model.activites.map((e) => Cra.fromActivity(e)),
      ...model.absences.map((e) => Cra.fromLeave(e)),
      ...model.holidays.map((e) => Cra.fromHoliday(e)),
      /*...model.available.map((e) => Cra.fromAvailable(e)),*/
    ].sortedBy((element) => element.date).groupListsBy((element) => element.title).map((key, crasPerProject) {
      return MapEntry(key, crasPerProject);
    });
    return data;
  }
}
