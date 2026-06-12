import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:find_me_app/core/networking/network_state.dart';

// abstract class NetworkInfo {
//   void listenToConnection();
//   Future<bool> get isConnected;
// }

/// Using InternetConnectionChecker package
class NetworkInfo extends Cubit<NetworkState> {
  final InternetConnectionChecker _connectionChecker;

  late final StreamSubscription<InternetConnectionStatus> _listener;

  NetworkInfo(
    this._connectionChecker,
  ) : super(NetworkInitial());

  listenToConnection() async {
    final connected = await _connectionChecker.hasConnection;
    if (!isClosed) {
      emit(connected ? NetworkConnected() : NetworkDisconnected());
    }
    _listener = _connectionChecker.onStatusChange.listen((status) {
      if (isClosed) return;
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(NetworkConnected());

          break;
        case InternetConnectionStatus.disconnected:
          emit(NetworkDisconnected());
          break;
        default:
          break;
      }
    });
  }

  Future<bool> get isConnected => _connectionChecker.hasConnection;

  @override
  Future<void> close() async {
    await _listener.cancel();
    return super.close();
  }
}
