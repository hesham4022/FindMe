import 'dart:convert';
import 'dart:developer';

import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/repo/all_cases_repo.dart';
import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_cases_state.dart';

class AllCasesCubit extends Cubit<AllCasesState> {
  AllCasesCubit(this._repo) : super(AllCasesState.initial());

  final AllCasesRepo _repo;

  List<CaseInfoModel> _allCases = [];

  void addNewCase(CaseInfoModel newCase) {
    _allCases.insert(0, newCase);

    emit(state.copyWith(
      allCasesResponse: state.allCasesResponse?.copyWith(
        allCases: List.from(_allCases),
      ),
    ));
  }

  void updateCaseLike(int id, bool isLiked) {
    _allCases = _allCases.map((c) {
      if (c.id == id) {
        return c.copyWith(isLiked: isLiked);
      }
      return c;
    }).toList();

    applyFilters();
  }

  Future<void> toggleLike(int id) async {
    try {
      final isLiked = await _repo.toggleLike(id);

      final updatedList = state.filtered.map((c) {
        if (c.id == id) {
          return c.copyWith(isLiked: isLiked);
        }
        return c;
      }).toList();

      emit(state.copyWith(filtered: updatedList));
    } catch (e) {
      log('LIKE ERROR: $e');
    }
  }

  List<CaseInfoModel> getLatestFiveCases() {
    final cases = List<CaseInfoModel>.from(_allCases);

    cases.sort((a, b) {
      final aDate = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(1900);
      final bDate = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(1900);
      return bDate.compareTo(aDate);
    });

    return cases.take(5).toList();
  }

  // void clearCases() {
  //   _allCases = [];
  //   emit(const AllCasesState());
  // }

  Future<bool> getAllCasesResponseData() async {
    emit(state.copyWith(
      status: AllCasesStatus.loading,
    ));

    final result = await _repo.getAllCasesResponseData();

    bool isSuccess = false;

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AllCasesStatus.error,
          failure: failure,
        ));
        isSuccess = false;
      },
      (success) {
        _allCases = success.allCases;
        _allCases.sort((a, b) {
          final dateA = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(0);
          final dateB = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(0);
          return dateB.compareTo(dateA);
        });
        emit(state.copyWith(
          status: AllCasesStatus.success,
          allCasesResponse: success,
        ));
        applyFilters();
        isSuccess = true;
      },
    );

    return isSuccess;
  }

  void toggleFilter(AllCasesFilter filter) {
    if (state.activeFilter == filter) {
      emit(state.copyWith(activeFilter: AllCasesFilter.all));
    } else {
      emit(state.copyWith(activeFilter: filter));
    }
    applyFilters();
  }

  void applyFilters() {
    var result = _allCases;

    switch (state.activeFilter) {
      case AllCasesFilter.male:
        result =
            result.where((c) => c.gender?.toLowerCase() == 'male').toList();
        break;
      case AllCasesFilter.female:
        result =
            result.where((c) => c.gender?.toLowerCase() == 'female').toList();
        break;
      case AllCasesFilter.favorites:
        result = result.where((c) => c.isLiked).toList();
        break;
      case AllCasesFilter.all:
        break;
    }

    emit(state.copyWith(filtered: result));
  }

  // void toggleFavoriteCard(int caseId) {
  //   _allCases = _allCases.map((c) {
  //     if (c.id == caseId) {
  //       return c.copyWith(isFavorite: !c.isFavorite);
  //     }
  //     return c;
  //   }).toList();

  //   applyFilters();
  // }

  void searchByName(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filtered: _allCases));
    } else {
      final result = _allCases
          .where((c) => "${c.firstName!}${c.lastName!}"
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      emit(state.copyWith(filtered: result));
    }
  }

  Future<void> searchByImage(String imagePath) async {
    emit(
      state.copyWith(
        status: AllCasesStatus.loading,
        isImageSearch: true,
      ),
    );

    try {
      final request = SearchByImageRequest(imagePath: imagePath);

      final result = await _repo.searchCasesByImage(request);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: AllCasesStatus.error,
              failure: failure,
            ),
          );
        },
        (response) {
          emit(
            state.copyWith(
              status: AllCasesStatus.success,
              filtered: response.cases, // ✅ النتائج
              searchMessage: response.message, // ✅ رسالة السيرفر
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllCasesStatus.error,
        ),
      );
    }
  }

  void resetSearch() {
    emit(state.copyWith(filtered: _allCases));
  }

  void clearFilter() {
    final allCases = state.allCasesResponse?.allCases ?? [];
    emit(state.copyWith(
      activeFilter: AllCasesFilter.all,
      filtered: allCases,
    ));
  }

  void updateScroll(double pixels) {
    if (pixels > 50 && !state.isScroll) {
      emit(state.copyWith(isScroll: true));
    } else if (pixels <= 50 && state.isScroll) {
      emit(state.copyWith(isScroll: false));
    }
  }

  onInit() async {
    getAllCasesResponseData();
  }
}
