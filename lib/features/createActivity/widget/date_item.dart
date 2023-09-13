import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/features/common/widget/value_picker_widget.dart';
import 'package:mycra_timesheet_app/features/createActivity/controller/create_cra_controller.dart';

class DateItem extends ConsumerWidget {
  final ValueChanged<int>? onValueChanged;
  final Cra cra;

  const DateItem({
    super.key,
    this.onValueChanged,
    required this.cra,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createActivityControllerProvider);
    ({DateTime date, int percentage})? filledPercentage = state.summary[state.weekOfYear]?.firstWhere((element) => element.date == cra.date);
    return ListTile(
        title: Text(Jiffy.parseFromDateTime(cra.date).format(pattern: 'EEEE, dd MMMM')),
        trailing: SizedBox(
          width: MediaQuery.sizeOf(context).width * .4,
          child: (cra.type != CraType.holiday)
              ? ValuePickerWidget(
                  initialValue: cra.percentage.toDouble(),
                  multiplier: 25,
                  maxValue: (100 - (state.summary[state.weekOfYear]?.firstWhere((element) => element.date == cra.date).percentage ?? 0)).toDouble(),
                  onValueChanged: (value) {
                    // todo add validation
                    ref.read(createActivityControllerProvider.notifier).updateCra(cra.copyWith(percentage: value.floor()));
                  },
                )
              : Center(child: Text(cra.title)),
        ));
  }
}
