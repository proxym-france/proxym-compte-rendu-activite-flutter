import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/route/routes.dart';
import 'package:mycra_timesheet_app/core/utils/date_extensions.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_card_model.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/timecard_filter.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/timecard_item_widget.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TimeCardList extends ConsumerStatefulWidget {
  const TimeCardList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TimeCardListState();
}

class TimeCardListState extends ConsumerState<TimeCardList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final timeCardNotifier = ref.watch(timeCardNotifierProvider);
    final routerNotifier = ref.read(goRouterNotifierProvider.notifier);
    final filterKey = GlobalKey(debugLabel: 'timecard filter');
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          (MediaQuery.platformBrightnessOf(context) == Brightness.light) ? "assets/images/full_logo_light.png" : 'assets/images/full_logo_dark.png',
          height: 43,
        ),
        actions: [
          /*IconButton(
              onPressed: () => showModalBottomSheet(context: context, builder: (context) => TimeCardFilters()),
              icon: const Icon(Icons.filter_list_alt)),*/
          IconButton(onPressed: () => ref.read(timeCardNotifierProvider.notifier).logout(), icon: const Icon(Icons.power_settings_new)),
        ],
        backgroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        bottom: (routerNotifier.state.isAdmin && timeCardNotifier.collabs is Success) || (!routerNotifier.state.isAdmin)
            ? PreferredSize(
                preferredSize: Size.fromHeight(56 * (routerNotifier.state.isAdmin ? 3 : 2)),
                child: TimeCardFilters(key: filterKey),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.goNamed(createActivity.name,
              pathParameters: {"firstDayOfWeek": timeCardNotifier.selectedDate.atFirstDayOfTheMonth().toIso8601String()});
        },
        label: Text(S.of(context).fillCra),
        icon: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(timeCardNotifierProvider.notifier).fetchCraPerDate(shouldShowLoader: false);
        },
        child: switch (timeCardNotifier.cra) {
          Success(data: var craModel) || Success<List<CraCardModel>>(data: var craModel) => Flexible(
              child: ListView.builder(
                itemCount: craModel.length,
                itemBuilder: (context, index) => CraCardWidget(
                    projectName: (craModel[index].title == "Available") ? S.of(context).available : craModel[index].title,
                    type: craModel[index].type,
                    period: craModel[index].range,
                    percentage: craModel[index].percentage),
              ),
            ),
          Error(error: var error) => SingleChildScrollView(
              child: ErrorWidget(error ?? Exception(S.of(context).unkownError)),
            ),
          _ => Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) => CraCardWidget(
                  projectName: S.of(context).craTypes(CraType.blank),
                  type: CraType.blank,
                  period: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
                  percentage: 0,
                ),
              ),
            ),
        },
      ),
    );
  }
}
