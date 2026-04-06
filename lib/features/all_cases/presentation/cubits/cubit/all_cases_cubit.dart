import 'dart:convert';
import 'dart:developer';

import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/add_case/data/repo/delete_case_repo.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/repo/all_cases_repo.dart';
import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'all_cases_state.dart';

class AllCasesCubit extends HydratedCubit<AllCasesState> {
  AllCasesCubit(this._repo) : super(AllCasesState.initial()) {
    _allCases = List<CaseInfoModel>.from(state.cachedAllCases);
  }

  @override
  AllCasesState? fromJson(Map<String, dynamic> json) {
    try {
      final cachedAllCases = (json['cachedAllCases'] as List<dynamic>? ?? [])
          .map((e) => CaseInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      final filtered = (json['filtered'] as List<dynamic>? ?? [])
          .map((e) => CaseInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return AllCasesState(
        status: AllCasesStatus.success,
        imageSearchStatus: AllCasesStatus.initial,
        filtered: filtered.isNotEmpty ? filtered : cachedAllCases,
        cachedAllCases: cachedAllCases,
        activeFilter: AllCasesFilter.values[json['activeFilter'] as int? ?? 0],
        isScroll: json['isScroll'] as bool? ?? false,
        searchMessage: json['searchMessage'] as String?,
        isImageSearch: json['isImageSearch'] as bool? ?? false,
      );
    } catch (_) {
      return AllCasesState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AllCasesState state) {
    try {
      return {
        'cachedAllCases': state.cachedAllCases.map((e) => e.toJson()).toList(),
        'filtered': state.filtered.map((e) => e.toJson()).toList(),
        'activeFilter': state.activeFilter.index,
        'isScroll': state.isScroll,
        'searchMessage': state.searchMessage,
        'isImageSearch': state.isImageSearch,
      };
    } catch (_) {
      return null;
    }
  }

  final AllCasesRepo _repo;

  List<CaseInfoModel> _allCases = [];

  void updateCaseInList(CaseInfoModel updatedCase) {
    _allCases = _allCases.map((c) {
      if (c.id == updatedCase.id) return updatedCase;
      return c;
    }).toList();
    applyFilters();
  }

  // void deleteCaseFromList(int caseId) {
  //   _allCases = _allCases.where((c) => c.id != caseId).toList();

  //   final filtered = _allCases.where((c) {
  //     return true;
  //   }).toList();

  //   emit(state.copyWith(
  //     filtered: filtered,
  //   ));
  // }

//   void deleteCaseFromList(int caseId) {
//   _allCases.removeWhere((c) => c.id == caseId);
//   applyFilters();
// }

  void addNewCase(CaseInfoModel newCase) {
    _allCases.insert(0, newCase);
    applyFilters();

    // emit(state.copyWith(
    //   allCasesResponse: state.allCasesResponse?.copyWith(
    //     allCases: List.from(_allCases),
    //   ),
    // ));
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

  // Future<void> toggleLike(int id) async {
  //   try {
  //     final isLiked = await _repo.toggleLike(id);

  //     final updatedList = state.filtered.map((c) {
  //       if (c.id == id) {
  //         return c.copyWith(isLiked: isLiked);
  //       }
  //       return c;
  //     }).toList();

  //     emit(state.copyWith(filtered: updatedList));
  //   } catch (e) {
  //     log('LIKE ERROR: $e');
  //   }
  // }

  Future<void> toggleLike(int id) async {
    try {
      final isLiked = await _repo.toggleLike(id);

      _allCases = _allCases.map((c) {
        if (c.id == id) {
          return c.copyWith(isLiked: isLiked);
        }
        return c;
      }).toList();

      applyFilters();
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
        if (isClosed) return;
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

  Future<void> deleteCaseOptimistic({
    required BuildContext context,
    required CaseInfoModel caseModel,
  }) async {
    final currentState = state;
    final id = caseModel.id;
    if (id == null) return;

    // old data
    final oldAllCases =
        List<CaseInfoModel>.from(state.allCasesResponse?.allCases ?? []);
    final oldFiltered = List<CaseInfoModel>.from(state.filtered);

    final indexAll = oldAllCases.indexWhere((c) => c.id == id);
    final indexFiltered = oldFiltered.indexWhere((c) => c.id == id);

    // remove instantly (optimistic)
    final newAllCases = List<CaseInfoModel>.from(oldAllCases)
      ..removeWhere((c) => c.id == id);

    final newFiltered = List<CaseInfoModel>.from(oldFiltered)
      ..removeWhere((c) => c.id == id);

    emit(currentState.copyWith(
      allCasesResponse: state.allCasesResponse?.copyWith(allCases: newAllCases),
      filtered: newFiltered,
    ));

    final repo = sl<DeleteCaseRepo>();
    final result = await repo.deleteCase(id);

    result.fold(
      (error) {
        // rollback
        final rollbackAll =
            List<CaseInfoModel>.from(state.allCasesResponse?.allCases ?? []);
        final rollbackFiltered = List<CaseInfoModel>.from(state.filtered);

        if (indexAll >= 0 && indexAll <= rollbackAll.length) {
          rollbackAll.insert(indexAll, caseModel);
        } else {
          rollbackAll.add(caseModel);
        }

        if (indexFiltered >= 0 && indexFiltered <= rollbackFiltered.length) {
          rollbackFiltered.insert(indexFiltered, caseModel);
        } else {
          rollbackFiltered.add(caseModel);
        }

        emit(state.copyWith(
          allCasesResponse:
              state.allCasesResponse?.copyWith(allCases: rollbackAll),
          filtered: rollbackFiltered,
        ));

        showAlertSnackBar(context, error.msg, AlertType.error);
      },
      (message) {
        showAlertSnackBar(context, message, AlertType.success);
      },
    );
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

    emit(state.copyWith(
      filtered: result,
      cachedAllCases: List<CaseInfoModel>.from(_allCases),
    ));
  }

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

  // onInit() async {
  //   getAllCasesResponseData();
  // }

  Future<void> onInit() async {
    if (state.cachedAllCases.isNotEmpty) {
      _allCases = List<CaseInfoModel>.from(state.cachedAllCases);
      applyFilters();
    }

    await getAllCasesResponseData();
  }
}
