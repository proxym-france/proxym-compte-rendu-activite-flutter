import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/di/provider.dart';
import 'package:mycra_timesheet_app/core/network/network_notifier.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';
import 'package:talker_flutter/talker_flutter.dart';

final goRouterNotifierProvider = ChangeNotifierProvider<GoRouterNotifier>((ref) {
  return GoRouterNotifier(ref, ref.read(collabRepoProvider), ref.read(talkerProvider))..init();
});

class GoRouterNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  late RouterStateModel state;

  GoRouterNotifier(this.ref, this.collabRepo, this.talker);

  final Talker talker;

  final CollabRepo collabRepo;

  Future<void> init() async {
    state = RouterStateModel.initial();
    state = state.copyWith(isOnline: ref.watch(connectivityStateProvider) != NetworkStatus.none);

    await checkIsLoggedIn();
  }

  Future<void> checkIsLoggedIn() async {
    await collabRepo.getSavedCollab().then((value) {
      state = state.copyWith(isLoggedIn: value != null, isAdmin: value?.isAdmin, activeUser: value);
      FlutterNativeSplash.remove();
      talker.error('collab was fetch : $value');

      return notifyListeners();
    }).onError((error, stackTrace) {
      (error);
      state = state.copyWith(isLoggedIn: false, isAdmin: false, activeUser: null);
      return notifyListeners();
    });
  }
}

class RouterStateModel {
  final bool isOnline;
  final bool isLoggedIn;
  final bool isAdmin;
  final Collab? activeUser;

  RouterStateModel({
    required this.isOnline,
    required this.isLoggedIn,
    required this.isAdmin,
    this.activeUser,
  });

  RouterStateModel.initial({
    this.isOnline = false,
    this.isLoggedIn = false,
    this.isAdmin = false,
    this.activeUser,
  });

  RouterStateModel copyWith({
    bool? isOnline,
    bool? isLoggedIn,
    bool? isAdmin,
    Collab? activeUser,
  }) =>
      RouterStateModel(
        isOnline: isOnline ?? this.isOnline,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        isAdmin: isAdmin ?? this.isAdmin,
        activeUser: activeUser ?? this.activeUser,
      );
}
