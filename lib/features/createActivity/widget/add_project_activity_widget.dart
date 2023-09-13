import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class AddProjectWidget extends ConsumerStatefulWidget {
  const AddProjectWidget({super.key, this.onItemAdded, required this.projects, required List<Cra> cras});

  final Function(Collab)? onItemAdded;
  final List<Project> projects;

  @override
  ConsumerState<AddProjectWidget> createState() => _AddCollabWidgetState();
}

class _AddCollabWidgetState extends ConsumerState<AddProjectWidget> {
  late Project project;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Project? project;
    TextEditingController? controller;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Autocomplete<Project>(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return [];
                } else {
                  return widget.projects.where((element) {
                    return element.code.toUpperCase().contains(textEditingValue.text.toUpperCase());
                  });
                }
              },
              onSelected: (option) {
                setState(() {
                  controller?.clear();
                  FocusScope.of(context).unfocus();
                });
              },
              displayStringForOption: (option) => option.code,
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                controller = textEditingController;
                return TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                  ),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (value) {
                    if (project != null && project?.code != value) {
                      textEditingController.clear();
                      project = null;
                    }
                  },
                );
              },
            ),
          ),
          TextButton(onPressed: () => setState(() {}), child: Text(S.of(context).save))
        ],
      ),
    );
  }
}
