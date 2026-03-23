import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/repo/all_cases_repo.dart';

part 'recent_cases_state.dart';

class RecentCasesCubit extends Cubit<RecentCasesState> {
  RecentCasesCubit(this._repo) : super(RecentCasesState.initial());

  final AllCasesRepo _repo;

  List<CaseInfoModel> _allRecentCases = [];

  Future<bool> getRecentCases() async {
    emit(state.copyWith(
      status: RecentCasesStatus.loading,
      failure: null,
    ));

    final result = await _repo.getAllCasesResponseData();

    bool isSuccess = false;

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: RecentCasesStatus.error,
          failure: failure,
        ));
        isSuccess = false;
      },
      (success) {
        _allRecentCases = List<CaseInfoModel>.from(success.allCases);
        emit(state.copyWith(
          status: RecentCasesStatus.success,
          recentCases: _allRecentCases,
        ));

        isSuccess = true;
      },
    );

    return isSuccess;
  }

  void toggleFavoriteCard(int caseId) {
    _allRecentCases = _allRecentCases.map((c) {
      if (c.id == caseId) {
        return c.copyWith(isFavorite: !c.isFavorite);
      }
      return c;
    }).toList();

    emit(
        state.copyWith(recentCases: List<CaseInfoModel>.from(_allRecentCases)));
  }

  void refreshRecentCases() {
    emit(state.copyWith(
      recentCases: List<CaseInfoModel>.from(_allRecentCases),
    ));
  }

  Future<void> onInit() async {
    await getRecentCases();
  }
}
