/*
 * Copyright (c) 2023.
 * created by Sofien Touati
 * at: 11/09/2023, 15:09
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mycra_timesheet_app/core/utils/name_parse.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/features/common/widget/short_name_tile_item.dart';
import 'package:mycra_timesheet_app/features/createActivity/controller/create_cra_controller.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class AddActivityButton extends ConsumerWidget {
  const AddActivityButton({
    super.key,
    required this.projects,
    required this.cras,
  });

  final List<Project> projects;
  final Map<int, Map<Project, List<Cra>>> cras;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createActivityController = ref.watch(createActivityControllerProvider);
    return FilledButton.icon(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                var newProjects = projects.toSet().difference(cras[createActivityController.weekOfYear]?.keys.toSet() ?? <Project>{}).toList();

                return ListView.builder(
                  itemCount: newProjects.length,
                  itemBuilder: (context, index) {
                    final item = newProjects[index];
                    return ShortNameTileItem(
                      onTap: () {
                        ref.read(createActivityControllerProvider.notifier).addProjectToWeek(item);
                        context.pop();
                      },
                      title: ((item.craType == CraType.project) ? item.name : S.of(context).craTypes(item.craType)),
                      shortName: ((item.craType == CraType.project) ? item.name : S.of(context).craTypes(item.craType)).shortName().toUpperCase(),
                      subtitle: item.client,
                      color: item.craType.color,
                    );
                  },
                );
              });
        },
        icon: const Icon(Icons.add),
        label: Text(S.of(context).addActivity));
  }
}
