import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';
import 'package:mycra_timesheet_app/domain/repository/cra_repo.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_filter.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_state.dart';

final timeCardNotifierProvider = StateNotifierProvider.autoDispose<TimeCardNotifier, TimeCardStateModel>((ref) {
  return TimeCardNotifier(ref.read(craRepoProvider), ref.read(collabRepoProvider), ref.read(goRouterNotifierProvider))..refresh();
});

class TimeCardNotifier extends StateNotifier<TimeCardStateModel> {
  TimeCardNotifier(this.craRepo, this.collabRepo, this.routerNotifier) : super(TimeCardStateModel.initial());

  final CraRepo craRepo;
  final CollabRepo collabRepo;
  final GoRouterNotifier routerNotifier;

  Future<void> refresh() async {
    if (routerNotifier.state.isAdmin) {
      fetchCollabs();
    } else {
      state = state.copyWith(selectedCollab: routerNotifier.state.activeUser, selectedCollabIndex: 0);
      fetchCraPerDate();
    }
  }

  void switchCollab(int index, Collab collab) {
    // if (state.cra is Loading == false) {
    state = state.copyWith(selectedCollab: collab, selectedCollabIndex: index);
    fetchCraPerDate();
    // }
  }

  void setSelectedShip(TimecardFilter value) {
    final State<List<CraCardModel>> cra = switch (state.timeCard) {
      Success(data: var timecard) => Success(timecard.cras.where((element) => value.type.contains(element.type)).toList()),
      Error(error: var error) => Error(error),
      Loading() => Loading(),
      Initial() => Initial()
    };
    state = state.copyWith(selectedChip: value, cra: cra);
  }

  void goNextMonth() {
    if (state.cra is Loading == false) {
      state = state.copyWith(selectedDate: Jiffy.parseFromDateTime(state.selectedDate).add(months: 1).dateTime);
      fetchCraPerDate();
    }
  }

  void goPreviousMonth() {
    if (state.cra is Loading == false) {
      state = state.copyWith(selectedDate: Jiffy.parseFromDateTime(state.selectedDate).subtract(months: 1).dateTime);
      fetchCraPerDate();
    }
  }

  Future<void> fetchCraPerDate({bool shouldShowLoader = true}) async {
    if (shouldShowLoader) state = state.copyWith(cra: Loading(shouldBeVisible: shouldShowLoader));
    await Future.delayed(const Duration(seconds: 2));
    await craRepo
        .fetchCurrentCraPerMonth(state.selectedCollab!.email, state.selectedDate.month, state.selectedDate.year)
        .then((value) => state = state.copyWith(
              cra: Success(value.cras.where((element) => state.selectedChip.type.contains(element.type)).toList()),
              timeCard: Success(value),
            ))
        .onError((error, stackTrace) {
      return state = state.copyWith(cra: Error(error), timeCard: Error(error));
    });
  }

  Future<void> fetchCollabs() async {
    state = state.copyWith(cra: Loading());
    await Future.delayed(const Duration(seconds: 2));
    await collabRepo.getAll().then((value) {
      state = state.copyWith(collabs: Success(value));
      return switchCollab(state.selectedCollabIndex, value[state.selectedCollabIndex]);
    }).onError((error, stackTrace) => state = state.copyWith(cra: Error(error)));
  }

  Future<void> logout() async {
    state = state.copyWith(cra: Loading());
    await collabRepo.clearSavedCollab();
    await routerNotifier.checkIsLoggedIn();
  }
}
