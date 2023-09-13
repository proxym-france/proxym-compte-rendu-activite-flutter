import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class ProjectSelectWidget extends ConsumerWidget {
  const ProjectSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectorWidget(
      title: Text(
        S.of(context).selectAnActivity,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Card(
            child: ListView.builder(
              itemBuilder: (context, index) => const Placeholder(),
            ),
          ),
        );
      },
      trailingIcon: Icons.keyboard_arrow_down,
    );
  }
}
