import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mycra_timesheet_app/core/theme/colors.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/features/createActivity/controller/create_cra_controller.dart';
import 'package:mycra_timesheet_app/features/createActivity/widget/add_activity_button.dart';
import 'package:mycra_timesheet_app/features/createActivity/widget/create_activity_item.dart';
import 'package:mycra_timesheet_app/features/createActivity/widget/week_selector.dart';
import 'package:mycra_timesheet_app/features/time_card/widgets/short_name_circle_avatar.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({super.key, required this.firstDayOfWeek});

  final DateTime firstDayOfWeek;

  @override
  ConsumerState createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends ConsumerState<CreateActivityPage> {
  late int expandedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(createActivityControllerProvider.notifier).init(widget.firstDayOfWeek);
    });
    expandedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    final createActivityController = ref.watch(createActivityControllerProvider);

    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        title: Text(S.of(context).addActivity),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(56), child: WeekSelector()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: switch ((createActivityController.cras, createActivityController.userProjects)) {
            (Success(data: var cras), Success(data: var projects)) => Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: createActivityController.summary[createActivityController.weekOfYear]!
                            .mapIndexed((index, e) => Column(
                                  children: [
                                    ShortNameCircleAvatar(
                                        color: switch (e.percentage) {
                                          0 => AppColors.pinkF06B96,
                                          100 => AppColors.blue30C9C6,
                                          _ => AppColors.orangeD38430
                                        },
                                        shortName: "${e.percentage}%"),
                                    Text(Jiffy.parseFromDateTime(e.date).format(pattern: 'E dd')),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AddActivityButton(projects: projects, cras: cras),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cras[createActivityController.weekOfYear]?.entries.length,
                    itemBuilder: (context, index) {
                      var item = cras[createActivityController.weekOfYear]?.entries.toList()[index];
                      return (item != null && item.value.isNotEmpty)
                          ? CreateActivityCard(
                              item: item,
                              isExpanded: expandedIndex == index,
                              onExpansionChanged: (value) => setState(() => expandedIndex = value ? index : -1),
                            )
                          : null;
                    },
                  ),
                ],
              ),
            (Error(error: var error), _) || (_, Error(error: var error)) => ErrorWidget(error!),
            _ => Skeletonizer(
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(onPressed: null, icon: const Icon(Icons.add), label: Text(S.of(context).addActivity))),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return CreateActivityCard(
                            item: MapEntry(Project.fromLeave(CraType.blank),
                                List.generate(5, (index) => Cra('    ', CraType.blank, DateTime(2023), 0, Project.fromLeave(CraType.blank)))),
                            isExpanded: expandedIndex == index,
                            onExpansionChanged: (value) {
                              setState(() {
                                expandedIndex = value ? index : -1;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
          },
        ),
      ),
    );
  }
}
