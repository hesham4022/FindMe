part of 'host_cubit.dart';

enum HostStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

class HostState extends Equatable {
  final AuthedUser? user;
  final int selectedIndex;
  final HostStatus status;
  final Failure? failure;

  const HostState({
    required this.user,
    required this.selectedIndex,
    this.status = HostStatus.initial,
    this.failure,
  });

  factory HostState.initial(int index) {
    return HostState(
      selectedIndex: index,
      user: null,
      status: HostStatus.initial,
      failure: null,
    );
  }

  bool get isLoading => status == HostStatus.loading;
  bool get isAuthenticated => status == HostStatus.authenticated;
  bool get isUnauthenticated => status == HostStatus.unauthenticated;
  bool get isError => status == HostStatus.failure;

  HostState copyWith({
    AuthedUser? user,
    int? selectedIndex,
    HostStatus? status,
    Failure? failure,
    bool clearFailure = false,
    bool clearUser = false,
  }) {
    return HostState(
      user: clearUser ? null : (user ?? this.user),
      selectedIndex: selectedIndex ?? this.selectedIndex,
      status: status ?? this.status,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [
        user,
        selectedIndex,
        status,
        failure,
      ];
}
