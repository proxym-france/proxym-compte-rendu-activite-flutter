import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/short_name_circle_avatar.dart';

class CollabTile extends StatelessWidget {
  const CollabTile({
    super.key,
    this.onTap,
    required this.collab,
    required this.color,
    this.trailing,
  });

  final Collab collab;
  final GestureTapCallback? onTap;
  final Widget? trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(collab.fullName),
      subtitle: Text(collab.email),
      leading: ShortNameCircleAvatar(
        shortName: collab.shortName,
        color: color,
      ),
      trailing: trailing,
    );
  }
}
