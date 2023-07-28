import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { WIFI, DATA, NONE, UNKOWN }

final connectivityStateProvider =
    ChangeNotifierProvider<NetworkNotifier>((ref) => NetworkNotifier());

class NetworkNotifier extends ChangeNotifier {
  late NetworkStatus lastResult = NetworkStatus.UNKOWN;
  late NetworkStatus newState;

  NetworkNotifier() {
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
      if(newState != lastResult){
        lastResult = newState;
        notifyListeners();

      }
    });

  }
}
