// all_cases_state.dart
part of 'all_cases_cubit.dart';

enum AllCasesStatus { initial, loading, success, error }

enum AllCasesFilter { all, male, female, favorites }

class AllCasesState extends Equatable {
  final AllCasesResponse? allCasesResponse;
  final List<CaseInfoModel> filtered;
  final AllCasesFilter activeFilter;
  final AllCasesStatus status;
  final AllCasesStatus imageSearchStatus;
  final CaseInfoModel? selectedCase;
  final String? searchMessage;
  final bool isImageSearch;
  final List<CaseInfoModel> cachedAllCases;
  final String? selectedImagePath;
  final String? selectedImageName;

  // final SuccessResponse? success;
  final Failure? failure;
  final bool isScroll;
  bool get isInitial => status == AllCasesStatus.initial;
  bool get isLoading => status == AllCasesStatus.loading;
  bool get isSuccess => status == AllCasesStatus.success;
  bool get isError => status == AllCasesStatus.error;

  bool get isImageSearchLoading => imageSearchStatus == AllCasesStatus.loading;
  bool get isImageSearchSuccess => imageSearchStatus == AllCasesStatus.success;
  bool get isImageSearchError => imageSearchStatus == AllCasesStatus.error;

  const AllCasesState({
    required this.filtered,
    this.activeFilter = AllCasesFilter.all,
    required this.status,
    this.selectedCase,
    this.isScroll = false,
    // this.success,
    this.failure,
    this.allCasesResponse,
    this.searchMessage,
    this.isImageSearch = false,
    this.imageSearchStatus = AllCasesStatus.initial,
    required this.cachedAllCases,
    this.selectedImagePath,
    this.selectedImageName,
  });

  factory AllCasesState.initial() {
    return const AllCasesState(
      status: AllCasesStatus.initial,
      filtered: [],
      cachedAllCases: [],
      selectedImagePath: null,
      selectedImageName: null,
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
    AllCasesStatus? imageSearchStatus,
    String? searchMessage,
    bool? isImageSearch,
    List<CaseInfoModel>? cachedAllCases,
    String? selectedImagePath,
    String? selectedImageName,
    bool clearFailure = false,
    bool clearSearchMessage = false,
    bool clearSelectedImage = false,
  }) {
    return AllCasesState(
      filtered: filtered ?? this.filtered,
      activeFilter: activeFilter ?? this.activeFilter,
      status: status ?? this.status,
      selectedCase: selectedCase ?? this.selectedCase,
      isScroll: isScroll ?? this.isScroll,
      // success: success ?? this.success,
      // failure: failure ?? this.failure,
      allCasesResponse: allCasesResponse ?? this.allCasesResponse,
      imageSearchStatus: imageSearchStatus ?? this.imageSearchStatus,
      searchMessage: searchMessage ?? this.searchMessage,
      isImageSearch: isImageSearch ?? this.isImageSearch,
      cachedAllCases: cachedAllCases ?? this.cachedAllCases,
      selectedImagePath: clearSelectedImage
          ? null
          : (selectedImagePath ?? this.selectedImagePath),
      selectedImageName: clearSelectedImage
          ? null
          : (selectedImageName ?? this.selectedImageName),
      failure: clearFailure ? null : (failure ?? this.failure),
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
        imageSearchStatus,
        searchMessage,
        isImageSearch,
        cachedAllCases,
        selectedImagePath,
        selectedImageName,
      ];
}
