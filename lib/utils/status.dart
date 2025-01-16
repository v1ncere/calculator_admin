enum Status { initial, loading, success, failure, connected, disconnected }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isConnected => this == Status.connected;
  bool get isDisconnected => this == Status.disconnected;
}