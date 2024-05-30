import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityStatus _status = ConnectivityStatus.disconnected;

  ConnectivityStatus get status => _status;

  ConnectivityProvider() {
    Connectivity().onConnectivityChanged.listen((status) {
      _getNetworkStatus(status.first);
    });
  }

  void _getNetworkStatus(ConnectivityResult status) {
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi ||
        status == ConnectivityResult.other) {
      _status = ConnectivityStatus.connected;
    } else {
      _status = ConnectivityStatus.disconnected;
    }
    notifyListeners();
  }
}
