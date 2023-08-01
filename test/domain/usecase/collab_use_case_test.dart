import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';
import 'package:mycra_timesheet_app/domain/usecase/collab_use_case.dart';

import '../../helper.dart';

class MockCollabRepo extends Mock implements CollabRepo {}

void main() {
  late ProviderContainer container;
  late CollabRepo collabRepo;
  late List<Collab> collabs;

  setUp(() async {
/*

    collabRepo = MockCollabRepo();
    container = ProviderContainer(overrides: [
      collabRepoProvider.overrideWithValue(collabRepo),
      getAllCollabsUseCase.overrideWith((ref) => collabRepo.getAll()),
    ]);
*/

    collabRepo = MockCollabRepo();
    collabs = [
      const Collab(firstName: 'firstName', lastName: 'lastName', email: 'email')
    ];
    container = makeProviderContainer(
        overrides: [collabRepoProvider.overrideWithValue(collabRepo)]);
  });

  test('Get All collabs', () async {
    when(() => collabRepo.getAll())
        .thenAnswer((realInvocation) async => collabs);

    final listener = ProviderListener<AsyncValue<List<Collab>>>();

    container.listen(getAllCollabsUseCase, listener, fireImmediately: true);

    //check state before completing
    verify(() => listener(null, const AsyncLoading<List<Collab>>()));
    expect(
      container.read(getAllCollabsUseCase),
      const AsyncLoading<List<Collab>>(),
    );

    //finish the future operation

    await container.read(getAllCollabsUseCase.future);

    verify(() => listener(
        const AsyncLoading<List<Collab>>(), AsyncData<List<Collab>>(collabs)));
    expect(
      container.read(getAllCollabsUseCase),
      AsyncData<List<Collab>>(collabs),
    );
    //no new status
    verifyNoMoreInteractions(listener);

    verify(() => collabRepo.getAll()).once();
  });

/*  group('get All collabs', () {
    test('get All collabs success', () async {
      when(collabRepo.getAll()).thenAnswer((invocation) async => collabs);
      container.listen(getAllCollabsUseCase.future,
          (previous, next) => expect(next, collabs));
    });
    test('get All collabs empty', () async {
      when(collabRepo.getAll()).thenThrow((invocation) async => []);
      container.listen(getAllCollabsUseCase.future,
              (previous, next) => expect(next, []));
    });

  });*/
}
