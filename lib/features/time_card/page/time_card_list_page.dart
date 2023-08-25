import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/timecard_filter.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/timecard_item_widget.dart';

class TimeCardList extends ConsumerStatefulWidget {
  const TimeCardList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TimeCardListState();
}

class TimeCardListState extends ConsumerState<TimeCardList> {
  var brightness;

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
                preferredSize: const Size.fromHeight(56 * 2),
                child: TimeCardFilters(key: filterKey),
              )
            : null,
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
                  projectName: craModel[index].title,
                  type: craModel[index].type,
                  period: craModel[index].range,
                ),
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
