abstract class NetworkState {}

class NetworkInitial implements NetworkState {
  NetworkInitial();
}

class NetworkConnected implements NetworkState {
  NetworkConnected();
}

class NetworkDisconnected implements NetworkState {
  NetworkDisconnected();
}
