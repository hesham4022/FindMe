part of 'case_info_cubit.dart';

enum CaseInfoStatus { initial, laoding, success, error }

class CaseInfoState extends Equatable {
  final CaseInfoModel? selectedCase;
  final CaseInfoStatus? status;
  final Failure? failure;

  const CaseInfoState({this.selectedCase, this.status, this.failure});

  factory CaseInfoState.initial() {
    return const CaseInfoState(
      status: CaseInfoStatus.initial,
    );
  }

  CaseInfoState copyWith({
    final CaseInfoModel? selectedCase,
    final CaseInfoStatus? status,
    final Failure? failure,
  }) {
    return CaseInfoState(
      selectedCase: selectedCase ?? selectedCase,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, selectedCase, failure];
}
