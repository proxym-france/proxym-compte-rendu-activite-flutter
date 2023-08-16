import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/usecase/collab_use_case.dart';

class TimeCardList extends ConsumerWidget {
  const TimeCardList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Collab>> allCollabRef = ref.watch(getAllCollabsUseCase);

    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primaryContainer,
          title: const Text('Timecards'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56 * 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    itemCount: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        avatar: const Icon(Icons.list),
                        label: const Text('overview'),
                        selectedColor: colorScheme.primary,
                        labelStyle: textTheme.bodySmall
                            ?.copyWith(color: colorScheme.onBackground),
                        selected: index == 0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          elevation: 0,
                          child: const Icon(Icons.keyboard_arrow_left),
                        ),
                        const Text(
                          'February 2023',
                          textAlign: TextAlign.center,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          elevation: 0,
                          child: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            'https://source.unsplash.com/1000x1000?face',
                          ),
                        ),
                        const Text(
                          'Mohamed Taher Ben Torkia (Me)',
                          textAlign: TextAlign.center,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          elevation: 0,
                          child: const Icon(Icons.keyboard_arrow_up),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: InkWell(
          onTap: () => ref.refresh(getAllCollabsUseCase),
          child: allCollabRef.when(
            data: (items) => Column(
              children: items
                  .map((e) => Text("${e.firstName} ${e.lastName}"))
                  .toList(),
            ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ));
  }
}
