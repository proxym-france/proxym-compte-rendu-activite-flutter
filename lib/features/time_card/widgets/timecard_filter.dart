import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/collab_selector_widget.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/filter_chips.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/month_selector.dart';

class TimeCardFilters extends ConsumerWidget {
  const TimeCardFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerNotifier = ref.read(goRouterNotifierProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        //todo add filter;
        const SizedBox(
          height: 60,
          child: FilterChips(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: MonthSelectorWidget(),
        ),
        if (routerNotifier.state.isAdmin)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CollabSelectorWidget(),
          ),
      ],
    );
  }
}
