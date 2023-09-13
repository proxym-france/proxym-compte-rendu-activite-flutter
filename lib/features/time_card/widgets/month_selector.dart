import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/features/common/widget/circle_button.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';

class MonthSelectorWidget extends ConsumerWidget {
  const MonthSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(timeCardNotifierProvider);
    return SelectorWidget(
      title: Text(
        Jiffy.parseFromDateTime(cardState.selectedDate).yMMMM,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoDatePicker(
            onDateTimeChanged: (value) {},
            mode: CupertinoDatePickerMode.monthYear,
          ),
        );
      },
      onTrailingTap: () => ref.read(timeCardNotifierProvider.notifier).goNextMonth(),
      trailingIcon: Icons.keyboard_arrow_right,
      leading: CircleIconButton(
        icon: Icons.keyboard_arrow_left,
        onPressed: () => ref.read(timeCardNotifierProvider.notifier).goPreviousMonth(),
      ),
    );
  }
}
