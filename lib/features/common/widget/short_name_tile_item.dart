/*
 * Copyright (c) 2023.
 * created by Sofien Touati
 * at: 04/09/2023, 10:05
 */

import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/short_name_circle_avatar.dart';

class ShortNameTileItem extends StatelessWidget {
  const ShortNameTileItem({
    super.key,
    required this.title,
    required this.shortName,
    required this.color,
    this.onTap,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String shortName;
  final Widget? trailing;
  final Color color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: (subtitle != null) ? Text(subtitle ?? '') : null,
        leading: ShortNameCircleAvatar(
          shortName: shortName,
          color: color,
        ),
        trailing: trailing,
      );
}
