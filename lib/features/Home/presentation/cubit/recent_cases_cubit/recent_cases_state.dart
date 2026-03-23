part of 'recent_cases_cubit.dart';

enum RecentCasesStatus { initial, loading, success, error }

class RecentCasesState extends Equatable {
  final List<CaseInfoModel> recentCases;
  final RecentCasesStatus status;
  final Failure? failure;
  final bool isScroll;

  bool get isInitial => status == RecentCasesStatus.initial;
  bool get isLoading => status == RecentCasesStatus.loading;
  bool get isSuccess => status == RecentCasesStatus.success;
  bool get isError => status == RecentCasesStatus.error;

  const RecentCasesState({
    required this.recentCases,
    required this.status,
    this.failure,
    this.isScroll = false,
  });

  factory RecentCasesState.initial() {
    return const RecentCasesState(
      recentCases: [],
      status: RecentCasesStatus.initial,
    );
  }

  RecentCasesState copyWith({
    List<CaseInfoModel>? recentCases,
    RecentCasesStatus? status,
    Failure? failure,
    bool? isScroll,
  }) {
    return RecentCasesState(
      recentCases: recentCases ?? this.recentCases,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      isScroll: isScroll ?? this.isScroll,
    );
  }

  @override
  List<Object?> get props => [
        recentCases,
        status,
        failure,
        isScroll,
      ];
}
