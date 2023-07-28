import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/network/network_notifier.dart';

final goRouterNotifierProvider = Provider((ref) {
  return GoRouterNotifier(ref);
});

class GoRouterNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  late bool _isOnline;
  late NetworkNotifier networkProvider;

  GoRouterNotifier(ProviderRef ref) {
    networkProvider = ref.watch(connectivityStateProvider);
    isOnline = NetworkStatus.NONE != networkProvider.lastResult;

    networkProvider.addListener(() {
      isOnline = NetworkStatus.NONE != networkProvider.lastResult;
    });
  }

  bool get isLoggedIn => _isLoggedIn;

  bool get isOnline => _isOnline;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

    set isOnline(bool value) {
      _isOnline = value;
    notifyListeners();
  }
}
