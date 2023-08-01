import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';

final getAllCollabsUseCase = FutureProvider<List<Collab>>((ref) {
  var provider = ref.read(collabRepoProvider);
  return provider.getAll();
});
