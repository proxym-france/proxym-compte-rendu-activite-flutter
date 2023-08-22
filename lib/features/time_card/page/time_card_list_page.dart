import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/timecard_item_widget.dart';

import '../widgets/timecard_filter.dart';

class TimeCardList extends ConsumerWidget {
  final bool isAdmin;

  const TimeCardList({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    final timeCardNotifier = ref.watch(timeCardNotifierProvider);
    final routerNotifier = ref.read(goRouterNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: const Text('Timecards'),
        actions: [IconButton(onPressed: () => ref.read(timeCardNotifierProvider.notifier).logout(), icon: const Icon(Icons.power_settings_new))],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        bottom: (routerNotifier.state.isAdmin && timeCardNotifier.collabs is Success) || (!routerNotifier.state.isAdmin)
            ? PreferredSize(
                preferredSize: Size.fromHeight(56 * ((routerNotifier.state.isAdmin) ? 3 : 2)),
                child: TimeCardFilters(shouldShowCollab: routerNotifier.state.isAdmin),
              )
            : null,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(timeCardNotifierProvider.notifier).fetchCraPerDate(shouldShowLoader: false);
        },
        child: switch (timeCardNotifier.cra) {
          Success(data: var craModel) || Success<List<CraCardModel>>(data: var craModel) => ListView.builder(
              itemCount: craModel.length,
              itemBuilder: (context, index) => CraCardWidget(
                projectName: craModel[index].title,
                type: craModel[index].type,
                period: craModel[index].range,
              ),
            ),
          Error(error: var error) => SingleChildScrollView(
              child: ErrorWidget(error ?? Exception('Unkown Error')),
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
    );
  }
}
