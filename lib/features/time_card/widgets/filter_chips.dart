import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_filter.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var timecardConstoller = ref.watch(timeCardNotifierProvider);
    return ListView.separated(
      itemCount: TimecardFilter.values.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return switch (timecardConstoller.timeCard) {
          Success(data: var data) => FilterChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
              selected: TimecardFilter.values[index] == timecardConstoller.selectedChip,
              label: Text("${S.of(context).craFilters(TimecardFilter.values[index])} ${data.getCountPerFilter(TimecardFilter.values[index])}"),
              showCheckmark: false,
              selectedColor: colorScheme.primary,
              labelStyle: TextStyle(
                  color: TimecardFilter.values[index] == timecardConstoller.selectedChip ? colorScheme.onPrimary : colorScheme.onBackground),
              onSelected: (bool value) {
                ref.read(timeCardNotifierProvider.notifier).setSelectedShip(TimecardFilter.values[index]);
              },
            ),
          _ => null
        };
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
    );
  }
}
