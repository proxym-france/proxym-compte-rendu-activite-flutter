import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { wifi, data, none, unknown }

final connectivityStateProvider = StateNotifierProvider<NetworkNotifier, NetworkStatus>((ref) => NetworkNotifier());

class NetworkNotifier extends StateNotifier<NetworkStatus> {
  late NetworkStatus newState;

  NetworkNotifier() : super(NetworkStatus.unknown) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      switch (event) {
        case ConnectivityResult.wifi:
          newState = NetworkStatus.data;
          break;
        case ConnectivityResult.mobile:
          newState = NetworkStatus.data;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.none;
          break;
        default:
          newState = NetworkStatus.unknown;
          break;
      }
      if (newState != state) {
        state = newState;
      }
    });
  }
}
