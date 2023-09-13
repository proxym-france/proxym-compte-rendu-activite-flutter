import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/features/common/widget/circle_button.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';
import 'package:mycra_timesheet_app/features/createActivity/controller/create_cra_controller.dart';

class WeekSelector extends ConsumerStatefulWidget {
  const WeekSelector({super.key});

  @override
  ConsumerState<WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends ConsumerState<WeekSelector> {
  late String _weekRange;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _weekRange = ref.read(createActivityControllerProvider.notifier).getDisplayWeekRange();
    });
  }

  @override
  Widget build(BuildContext context) {
    var createActivityStateNotifier = ref.watch(createActivityControllerProvider.notifier);
    ref.listen(createActivityControllerProvider, (previous, next) {
      setState(() {
        _weekRange = createActivityStateNotifier.getDisplayWeekRange();
      });
    });

    return SelectorWidget(
      title: Text(_weekRange),
      trailingIcon: Icons.chevron_right,
      onTrailingTap: createActivityStateNotifier.canGoNextWeek() ? () => setState(() => createActivityStateNotifier.nextWeek()) : null,
      leading: CircleIconButton(
        onPressed: createActivityStateNotifier.canGoPreviousWeek() ? () => setState(() => createActivityStateNotifier.previousWeek()) : null,
        icon: Icons.chevron_left,
      ),
    );
  }
}
