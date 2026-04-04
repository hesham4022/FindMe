import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';

enum CaseActionType { add, update, deleteCase }

enum CaseActionStatus { initial, loading, success, error }

class CaseActionState extends Equatable {
  final CaseActionType? actionType;
  final CaseActionStatus status;
  final dynamic success;
  final Failure? error;

  const CaseActionState({
    this.actionType,
    this.status = CaseActionStatus.initial,
    this.success,
    this.error,
  });

  factory CaseActionState.initial() {
    return const CaseActionState();
  }

  bool get isLoading => status == CaseActionStatus.loading;
  bool get isSuccess => status == CaseActionStatus.success;
  bool get isError => status == CaseActionStatus.error;

  CaseActionState copyWith({
    CaseActionType? actionType,
    CaseActionStatus? status,
    dynamic success,
    Failure? error,
  }) {
    return CaseActionState(
      actionType: actionType ?? this.actionType,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error,
    );
  }

  @override
  List<Object?> get props => [actionType, status, success, error];
}
