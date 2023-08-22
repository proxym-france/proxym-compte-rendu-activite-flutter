import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';

final authenticationControllerProvider = StateNotifierProvider.autoDispose<AuthenticationController, State<Collab>>(
    (ref) => AuthenticationController(ref.read(collabRepoProvider), ref.read(goRouterNotifierProvider.notifier)));

class AuthenticationController extends StateNotifier<State<Collab>> {
  AuthenticationController(this.collabRepo, this.routerNotifier) : super(Initial());

  final CollabRepo collabRepo;
  final GoRouterNotifier routerNotifier;

  Future<void> getCollabByEmail(String email) async {
    state = Loading();
    await Future.delayed(const Duration(seconds: 2));
    await collabRepo.findById(email).then((value) async {
      await collabRepo.saveCurrentCollab(value);
      await routerNotifier.checkIsLoggedIn();
      state = Success(value);
    }).onError((error, stackTrace) {
      state = Error(error);
    });
  }
}
