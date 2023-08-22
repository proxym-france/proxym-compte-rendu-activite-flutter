import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class CraCardWidget extends StatelessWidget {
  const CraCardWidget({super.key, required this.projectName, required this.type, required this.period});

  final String projectName;
  final CraType type;
  final DateTimeRange period;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
      child: SizedBox(
        height: size.height * .10,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                color: type.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                color: colorScheme.surfaceVariant,
                elevation: 1,
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                  minVerticalPadding: 0,
                  onTap: () {},
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: (period.start != period.end) ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                        children: [
                          Text(Jiffy.parseFromDateTime(period.start).format(pattern: 'dd MMM'), style: textTheme.titleMedium),
                          if (period.start != period.end)
                            Text(Jiffy.parseFromDateTime(period.end).format(pattern: 'dd MMM'), style: textTheme.titleMedium),
                        ],
                      ),
                      VerticalDivider(color: colorScheme.onSurface),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(S.of(context).craTypes(type), style: textTheme.titleMedium?.copyWith(color: Colors.grey)),
                  ),
                  title: Text(projectName,
                      maxLines: 2, overflow: TextOverflow.ellipsis, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
