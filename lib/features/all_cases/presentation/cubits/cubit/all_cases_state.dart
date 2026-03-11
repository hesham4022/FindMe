// all_cases_state.dart
part of 'all_cases_cubit.dart';

enum AllCasesStatus { initial, loading, success, error }

enum AllCasesFilter { all, male, female, favorites }

class AllCasesState extends Equatable {
  final AllCasesResponse? allCasesResponse;
  final List<CaseInfoModel> filtered;
  final AllCasesFilter activeFilter;
  final AllCasesStatus status;
  final CaseInfoModel? selectedCase;
  // final SuccessResponse? success;
  final Failure? failure;

  final bool isScroll;
  bool get isInitial => status == AllCasesStatus.initial;
  bool get isLoading => status == AllCasesStatus.loading;
  bool get isSuccess => status == AllCasesStatus.success;
  bool get isError => status == AllCasesStatus.error;

  const AllCasesState({
    required this.filtered,
    this.activeFilter = AllCasesFilter.all,
    required this.status,
    this.selectedCase,
    this.isScroll = false,
    // this.success,
    this.failure,
    this.allCasesResponse,
  });

  factory AllCasesState.initial() {
    return const AllCasesState(
      status: AllCasesStatus.initial,
      filtered: [],
    );
  }

  AllCasesState copyWith({
    List<CaseInfoModel>? filtered,
    AllCasesFilter? activeFilter,
    AllCasesStatus? status,
    final CaseInfoModel? selectedCase,
    bool? isScroll,
    // SuccessResponse? success,
    AllCasesResponse? allCasesResponse,
    Failure? failure,
  }) {
    return AllCasesState(
      filtered: filtered ?? this.filtered,
      activeFilter: activeFilter ?? this.activeFilter,
      status: status ?? this.status,
      selectedCase: selectedCase ?? this.selectedCase,
      isScroll: isScroll ?? this.isScroll,
      // success: success ?? this.success,
      failure: failure ?? this.failure,
      allCasesResponse: allCasesResponse ?? allCasesResponse,
    );
  }

  @override
  List<Object?> get props => [
        filtered,
        activeFilter,
        status,
        selectedCase,
        isScroll,
        allCasesResponse,
        failure,
      ];
}
