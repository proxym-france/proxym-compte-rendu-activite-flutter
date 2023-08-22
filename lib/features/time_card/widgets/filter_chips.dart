import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      itemCount: 4,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ChoiceChip(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          avatar: const Icon(Icons.list),
          label: const Text('overview'),
          selectedColor: colorScheme.primary,
          labelStyle: textTheme.bodySmall?.copyWith(color: colorScheme.onBackground),
          selected: index == 0,
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16),
    );
  }
}
