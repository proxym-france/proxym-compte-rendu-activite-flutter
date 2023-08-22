import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/collab_selector_widget.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/filter_chips.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/month_selector.dart';

class TimeCardFilters extends StatelessWidget {
  const TimeCardFilters({
    super.key,
    required this.shouldShowCollab,
  });

  final bool shouldShowCollab;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 60,
          child: FilterChips(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: MonthSelectorWidget(),
        ),
        if (shouldShowCollab)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CollabSelectorWidget(),
          ),
      ],
    );
  }
}
