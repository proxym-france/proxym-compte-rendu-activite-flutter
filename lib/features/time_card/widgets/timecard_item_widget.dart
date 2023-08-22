import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({super.key, required this.projectName, required this.type, required this.period});

  final String projectName;
  final CraType type;
  final DateTimeRange period;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AspectRatio(
        aspectRatio: 4.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(tileColor: type.color, minVerticalPadding: 0, title: const SizedBox(height: double.infinity))),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Card(
                color: colorScheme.surfaceVariant,
                elevation: 1,
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  minVerticalPadding: 0,
                  onTap: () {},
                  leading: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Jiffy.parseFromDateTime(period.start).format(pattern: 'dd MMM'), style: textTheme.titleLarge),
                      if (period.start != period.end)
                        Text(Jiffy.parseFromDateTime(period.end).format(pattern: 'dd MMM'), style: textTheme.titleLarge),
                    ],
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(projectName, maxLines: 2, overflow: TextOverflow.ellipsis, style: textTheme.titleLarge),
                      Text(S.of(context).craTypes(type), style: textTheme.titleLarge?.copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
