import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/features/createActivity/widget/date_item.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/short_name_circle_avatar.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class CreateActivityCard extends StatefulWidget {
  const CreateActivityCard({
    super.key,
    required this.item,
    this.onExpansionChanged,
    required this.isExpanded,
  });

  final bool isExpanded;
  final MapEntry<Project, List<Cra>> item;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<CreateActivityCard> createState() => _CreateActivityCardState();
}

class _CreateActivityCardState extends State<CreateActivityCard> {
  late bool isCollapsed;

  @override
  void initState() {
    super.initState();
    isCollapsed = true;
  }

  @override
  Widget build(BuildContext context) {
    final expandController = ExpansionTileController();
    return Card(
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: (value) => setState(() => isCollapsed = !value),
              initiallyExpanded: widget.isExpanded,
              controller: expandController,
              title: Text((widget.item.value[0].type == CraType.project) ? widget.item.key.name : S.of(context).craTypes(widget.item.key.craType)),
              children: [
                ...widget.item.value.map(
                  (cra) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DateItem(cra: cra),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isCollapsed) ...[
            InkWell(
              onTap: () {
                expandController.expand();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.item.value
                      .mapIndexed((index, e) => Row(
                            children: [
                              Column(
                                children: [
                                  ShortNameCircleAvatar(color: e.type.color, shortName: "${e.percentage}%"),
                                  Text(Jiffy.parseFromDateTime(e.date).format(pattern: 'E dd')),
                                ],
                              ),
                              // if (index < widget.item.value.length)
                              const VerticalDivider(color: Colors.greenAccent)
                            ],
                          ))
                      .toList(),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
