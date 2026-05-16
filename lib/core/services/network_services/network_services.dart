import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  void startListening(Function(bool isConnected) onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      final isConnected = result != ConnectivityResult.none;
      onChange(isConnected);
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}