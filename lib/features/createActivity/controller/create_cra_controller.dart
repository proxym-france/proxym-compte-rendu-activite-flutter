import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/core/exception/collab_not_found_exception.dart';
import 'package:mycra_timesheet_app/core/utils/date_extensions.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';
import 'package:mycra_timesheet_app/domain/repository/cra_repo.dart';
import 'package:mycra_timesheet_app/domain/repository/project_repo.dart';
import 'package:mycra_timesheet_app/features/createActivity/state/create_activity_state.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:week_of_year/date_week_extensions.dart';
import 'package:week_of_year/datetime_from_week_number.dart';

final createActivityControllerProvider = StateNotifierProvider.autoDispose<CreateActivityController, CreateActivityState>((ref) {
  return CreateActivityController(ref.read(projectRepoProvider), ref.read(collabRepoProvider), ref.read(craRepoProvider), ref.read(talkerProvider));
});

class CreateActivityController extends StateNotifier<CreateActivityState> {
  CreateActivityController(this.projectRepo, this.collabRepo, this.craRepo, this.talker)
      : super(CreateActivityState.initial(activeMonth: DateTime.now()));

  final ProjectRepo projectRepo;
  final CollabRepo collabRepo;
  final CraRepo craRepo;
  final Talker talker;

  Future<void> init(DateTime weekOfYear) async {
    state = state.copyWith(activeMonth: weekOfYear, weekOfYear: weekOfYear.weekOfYear);
    await fetchUserProjects();
    await getCras();
  }

  Future<void> fetchUserProjects() async {
    state = state.copyWith(userProjects: Loading());
    await Future.delayed(const Duration(seconds: 2));

    if (await collabRepo.getSavedCollab() case var collab?) {
      state = await projectRepo.getProjectsByUser(collab.email).then((value) {
        talker.debug(value);
        value.addAll(CraType.mapToProject());
        return state.copyWith(userProjects: Success(value));
      }).catchError((error, stackTrace) {
        talker.error('error fetching projects', error, stackTrace);
        return state.copyWith(userProjects: Error(error));
      });
    } else {
      state = state.copyWith(userProjects: Error(CollabNotFoundException()));
    }
  }

  Future<void> getCras() async {
    state = state.copyWith(cras: Loading());
    await Future.delayed(const Duration(seconds: 2));
    if (await collabRepo.getSavedCollab() case var collab?) {
      state = await craRepo.fetchCras(collab.email, state.activeMonth.month, state.activeMonth.year).then((cras) {
        //move all leave days into a seperate list
        final List<Cra> holidays = cras.where((element) => element.type == CraType.holiday).toList();

        final crasPerWeekPerProject = groupCrasByWeek(cras).map((key, value) => MapEntry(key, groupCrasByProject(value, holidays)));
        var summary = calculateWeekSum(crasPerWeekPerProject);
        return state.copyWith(cras: Success(crasPerWeekPerProject), summary: summary);
      }).onError((error, stackTrace) {
        talker.error('fetch cra', error, stackTrace);
        return state.copyWith(cras: Error(error));
      });
    } else {
      state = state.copyWith(userProjects: Error(CollabNotFoundException()));
    }
  }

  bool isWithinWeek(({DateTime end, DateTime start}) weekdays, Cra element) {
    final start = weekdays.start.isBefore(element.date) || weekdays.start == element.date;
    final end = weekdays.end.isAfter(element.date) || weekdays.end == element.date;
    return start && end;
  }

  bool canGoNextWeek() {
    return dateTimeFromWeekNumber(state.activeMonth.year, state.weekOfYear + 1, DateTime.monday).month == state.activeMonth.month;
  }

  bool canGoPreviousWeek() {
    return dateTimeFromWeekNumber(state.activeMonth.year, state.weekOfYear - 1, DateTime.friday).month == state.activeMonth.month;
  }

  void nextWeek() {
    state = state.copyWith(weekOfYear: state.weekOfYear + 1);
  }

  void previousWeek() {
    state = state.copyWith(weekOfYear: state.weekOfYear - 1);
  }

  String getDisplayWeekRange() {
    return "${Jiffy.parseFromDateTime(state.activeMonth.getWeekWithinMonth(state.weekOfYear).start).format(pattern: 'dd/MM')} - ${Jiffy.parseFromDateTime(state.activeMonth.getWeekWithinMonth(state.weekOfYear).end).format(pattern: 'dd/MM')}";
  }

  Map<Project, List<Cra>> groupCrasByProject(List<Cra> cras, List<Cra> holidays) {
    final weekdays = cras.first.date.getWeekWithinMonth();
    final daysCount = weekdays.end.difference(weekdays.start).inDays;
    return cras.whereNot((element) => [CraType.blank, CraType.holiday].contains(element.type)).groupListsBy((element) => element.project).map(
          (key, value) => MapEntry(
            key,
            List.generate(daysCount + 1, (index) {
              final currentDate = weekdays.start.add(Duration(days: index));
              return [...value, ...holidays].firstWhereOrNull((element) => element.date == currentDate) ??
                  value.first.copyWith(date: currentDate, percentage: 0);
            }),
          ),
        );
  }

  Future<void> updateCra(Cra cra) async {
    final List<Cra> cras = (state.cras as Success).data[cra.date.weekOfYear][cra.project];
    final index = cras.indexWhere((element) => element.date == cra.date);
    cras[index] = cra;

    state = state.copyWith(summary: calculateWeekSum());
  }

  Map<int, List<Cra>> groupCrasByWeek(List<Cra> cras) {
    return cras.groupListsBy((element) => element.date.weekOfYear);
  }

  void addProjectToWeek(Project item) {
    Map<Project, List<Cra>> data = (state.cras as Success).data[state.weekOfYear];
    var weekdays = state.activeMonth.getWeekWithinMonth(state.weekOfYear);
    var cras = weekdays.end.generateListToDate(weekdays.start).map((e) => Cra(item.name, item.craType, e, 0, item)).toList();
    data.putIfAbsent(item, () => cras);
    state = state.copyWith();
  }

  Map<int, List<({DateTime date, int percentage})>> calculateWeekSum([Map<int, Map<Project, List<Cra>>>? cras]) {
    Map<int, Map<Project, List<Cra>>> data = cras ?? (state.cras as Success).data;
    var summary = data.map((key, week) {
      var weekdays = state.activeMonth.getWeekWithinMonth(key);
      final list = weekdays.end.generateListToDate(weekdays.start).mapIndexed((index, e) {
        final percentage = week.values.map((cra) {
          return cra[index].percentage;
        }).sum;
        return (date: e, percentage: percentage);
      }).toList();
      talker.debug(list);
      return MapEntry(key, list);
    });
    talker.debug(summary);
    return summary;
  }
}
