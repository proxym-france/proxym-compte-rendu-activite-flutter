import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { WIFI, DATA, NONE, UNKOWN }

final connectivityStateProvider = StateNotifierProvider<NetworkNotifier, NetworkStatus>((ref) => NetworkNotifier());

class NetworkNotifier extends StateNotifier<NetworkStatus> {
  late NetworkStatus newState;

  NetworkNotifier() : super(NetworkStatus.UNKOWN) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      switch (event) {
        case ConnectivityResult.wifi:
          newState = NetworkStatus.DATA;
          break;
        case ConnectivityResult.mobile:
          newState = NetworkStatus.DATA;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.NONE;
          break;
        default:
          newState = NetworkStatus.UNKOWN;
          break;
      }
      if (newState != state) {
        state = newState;
      }
    });
  }
}
