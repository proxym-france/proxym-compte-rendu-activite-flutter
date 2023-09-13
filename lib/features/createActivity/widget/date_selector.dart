import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectorWidget(
      title: Text(S.of(context).selectDate),
      trailingIcon: Icons.date_range_outlined,
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoDatePicker(
              onDateTimeChanged: (value) {},
              mode: CupertinoDatePickerMode.monthYear,
            );
          }),
    );
  }
}
