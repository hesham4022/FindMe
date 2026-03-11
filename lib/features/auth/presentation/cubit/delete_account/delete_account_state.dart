part of 'delete_account_cubit.dart';

enum DeleteAccountStatus {
  initial,
  loading,
  success,
  error,
}

class DeleteAccountState extends Equatable {
  final DeleteAccountStatus status;
  final DeleteAccountResponse? success;
  final Failure? error;
  const DeleteAccountState({
    this.status = DeleteAccountStatus.initial,
    this.error,
    this.success,
  });
  DeleteAccountState copyWith({
    DeleteAccountStatus? status,
    final DeleteAccountResponse? success,
    final Failure? error,
  }) {
    return DeleteAccountState(
        status: status ?? this.status,
        error: error ?? this.error,
        success: success ?? this.success);
  }

  bool get isInitial => status == DeleteAccountStatus.initial;
  bool get isLoading => status == DeleteAccountStatus.loading;
  bool get isSuccess => status == DeleteAccountStatus.success;
  bool get isError => status == DeleteAccountStatus.error;
  @override
  List<Object?> get props => [
        status,
        error,
        success,
      ];
}
