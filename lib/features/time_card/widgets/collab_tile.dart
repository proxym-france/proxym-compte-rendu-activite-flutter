import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/features/common/widget/short_name_tile_item.dart';

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
  Widget build(BuildContext context) => ShortNameTileItem(
        title: collab.fullName,
        shortName: collab.shortName,
        color: color,
        subtitle: collab.email,
        onTap: onTap,
        trailing: trailing,
      );
}
