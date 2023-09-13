import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/timecard_controller.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/collab_tile.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/short_name_circle_avatar.dart';

class CollabSelectorWidget extends ConsumerWidget {
  const CollabSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(timeCardNotifierProvider);
    var collabs = (state.collabs as Success<List<Collab>>).data;
    return SelectorWidget(
      title: Text(
        state.selectedCollab?.fullName ?? '',
        textAlign: TextAlign.center,
      ),
      leading: ShortNameCircleAvatar(
        color: Colors.accents[state.selectedCollabIndex % Colors.accents.length],
        shortName: state.selectedCollab?.shortName ?? '',
        radius: 28,
      ),
      trailingIcon: Icons.keyboard_arrow_down,
      onTap: () {
        showBottomSheet(context, collabs, ref);
      },
      onTrailingTap: () {
        showBottomSheet(context, collabs, ref);
      },
    );
  }

  void showBottomSheet(BuildContext context, List<Collab> collabs, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Card(
        child: ListView.builder(
          itemCount: collabs.length,
          itemBuilder: (context, index) => CollabTile(
            color: Colors.accents[index % Colors.accents.length],
            collab: collabs[index],
            onTap: () {
              ref.read(timeCardNotifierProvider.notifier).switchCollab(index, collabs[index]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
