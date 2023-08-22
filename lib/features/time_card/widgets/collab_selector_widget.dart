import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/features/time_card/controllers/controller.dart';
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShortNameCircleAvatar(
            color: Colors.accents[state.selectedCollabIndex % Colors.accents.length],
            shortName: state.selectedCollab?.shortName ?? '',
            radius: 28,
          ),
          Text(
            state.selectedCollab?.fullName ?? '',
            textAlign: TextAlign.center,
          ),
          FloatingActionButton(
            onPressed: () {
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
/*                              setState(() {
                                ref.read(selectedCollabProvider.notifier).update((state) => widget.collabs[index]);
                                ref.refresh(craControllerProvider.notifier);
                                Navigator.pop(context);
                                _animationController.reverse(from: .5);
                              });*/
                      },
                    ),
                  ),
                ),
              );
            },
            shape: const CircleBorder(),
            elevation: 0,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
        ],
      ),
    );
  }
}
