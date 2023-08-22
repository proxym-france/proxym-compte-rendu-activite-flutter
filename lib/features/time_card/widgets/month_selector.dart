import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';

class MonthSelectorWidget extends ConsumerWidget {
  const MonthSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(timeCardNotifierProvider);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(timeCardNotifierProvider.notifier).goPreviousMonth();
            },
            shape: const CircleBorder(),
            elevation: 0,
            child: const Icon(Icons.keyboard_arrow_left),
          ),
          Text(
            Jiffy.parseFromDateTime(cardState.selectedDate).yMMMM,
            textAlign: TextAlign.center,
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(timeCardNotifierProvider.notifier).goNextMonth();
            },
            shape: const CircleBorder(),
            elevation: 0,
            child: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
