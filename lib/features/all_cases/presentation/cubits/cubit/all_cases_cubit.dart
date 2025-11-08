// all_cases_cubit.dart
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/enums/gender.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/repo/all_cases_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_cases_state.dart';

class AllCasesCubit extends Cubit<AllCasesState> {
  AllCasesCubit(this._repo) : super(AllCasesState.initial());

  final AllCasesRepo _repo;
  List<CaseInfoModel> _allCases = [];

  // List<CaseInfoModel> _allCases = [
  //   CaseInfoModel(
  //     name: "Mariam Ali",
  //     location: "Egypt, Cairo",
  //     imageUrl: 'https://i.pravatar.cc/120?img=12',
  //     gender: Gender.female,
  //     id: "1",
  //     eyeColor: 'green eyes',
  //     old: 10,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "20",
  //     duration: "13",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  //   CaseInfoModel(
  //     name: "Khaled Safwat",
  //     location: "Egypt, Giza",
  //     imageUrl: 'https://i.pravatar.cc/120?img=18',
  //     gender: Gender.male,
  //     id: "2",
  //     eyeColor: 'black eyes',
  //     old: 15,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "15",
  //     duration: "4",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat .',
  //   ),
  //   CaseInfoModel(
  //     name: "Youssef Ahmed",
  //     location: "Egypt, Gharbia",
  //     imageUrl: 'https://i.pravatar.cc/120?img=7',
  //     gender: Gender.male,
  //     id: "3",
  //     eyeColor: 'blue eyes',
  //     old: 20,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "black skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "10",
  //     duration: "3",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  //   CaseInfoModel(
  //     name: "Mariam Ali",
  //     location: "Egypt, Cairo",
  //     imageUrl: 'https://i.pravatar.cc/120?img=12',
  //     gender: Gender.female,
  //     id: "1",
  //     eyeColor: 'green eyes',
  //     old: 10,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "20",
  //     duration: "13",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  //   CaseInfoModel(
  //     name: "Khaled Safwat",
  //     location: "Egypt, Giza",
  //     imageUrl: 'https://i.pravatar.cc/120?img=18',
  //     gender: Gender.male,
  //     id: "2",
  //     eyeColor: 'black eyes',
  //     old: 15,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "15",
  //     duration: "4",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat .',
  //   ),
  //   CaseInfoModel(
  //     name: "Youssef Ahmed",
  //     location: "Egypt, Gharbia",
  //     imageUrl: 'https://i.pravatar.cc/120?img=7',
  //     gender: Gender.male,
  //     id: "3",
  //     eyeColor: 'blue eyes',
  //     old: 20,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "black skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "10",
  //     duration: "3",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  //   CaseInfoModel(
  //     name: "Mariam Ali",
  //     location: "Egypt, Cairo",
  //     imageUrl: 'https://i.pravatar.cc/120?img=12',
  //     gender: Gender.female,
  //     id: "1",
  //     eyeColor: 'green eyes',
  //     old: 10,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "20",
  //     duration: "13",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  //   CaseInfoModel(
  //     name: "Khaled Safwat",
  //     location: "Egypt, Giza",
  //     imageUrl: 'https://i.pravatar.cc/120?img=18',
  //     gender: Gender.male,
  //     id: "2",
  //     eyeColor: 'black eyes',
  //     old: 15,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "white skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "15",
  //     duration: "4",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat .',
  //   ),
  //   CaseInfoModel(
  //     name: "Youssef Ahmed",
  //     location: "Egypt, Gharbia",
  //     imageUrl: 'https://i.pravatar.cc/120?img=7',
  //     gender: Gender.male,
  //     id: "3",
  //     eyeColor: 'blue eyes',
  //     old: 20,
  //     height: "125cm",
  //     hairColor: 'yollow hair',
  //     skinColor: "black skin",
  //     birthMark: "Birth mark on his right arm",
  //     views: "10",
  //     duration: "3",
  //     lastSeenWearing:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsOfPerpetrator:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //     detailsWhatHappene:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //   ),
  // ];

  Future<bool> getAllCasesResponseData() async {
    emit(state.copyWith(
      status: AllCasesStatus.loading,
    ));

    final result = await _repo.getAllCasesResponseData();

    // Declare a variable to store the return value
    bool isSuccess = false;

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AllCasesStatus.error,
          failure: failure,
        ));
        isSuccess = false; // Explicitly set to false
      },
      (success) {
        _allCases = success.allCases;

        emit(state.copyWith(
          status: AllCasesStatus.success,
          allCasesResponse: success,
        ));

        applyFilters(); // ✅ دي اللي هتخلي الكروت تظهر فعلاً
        isSuccess = true;
      },
    );

    return isSuccess; // Now correctly returning true or false
  }

  void toggleFilter(AllCasesFilter filter) {
    if (state.activeFilter == filter) {
      emit(state.copyWith(activeFilter: AllCasesFilter.all));
    } else {
      emit(state.copyWith(activeFilter: filter));
    }

    applyFilters();
  }

  // void applyFilters() {
  //   var result = _allCases;
  //   print("🔍 gender = ${_allCases.first.gender}");
  //   switch (state.activeFilter) {
  //     case AllCasesFilter.male:
  //       result = result.where((c) => c.gender == Gender.male.name).toList();
  //       break;
  //     case AllCasesFilter.female:
  //       result = result.where((c) => c.gender == Gender.female.name).toList();
  //       break;
  //     case AllCasesFilter.favorites:
  //       result = result.where((c) => c.isFavorite).toList();
  //       break;
  //     case AllCasesFilter.all:
  //       break;
  //   }
  //   emit(state.copyWith(filtered: result));
  // }

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
        result = result.where((c) => c.isFavorite).toList();
        break;
      case AllCasesFilter.all:
        break;
    }

    emit(state.copyWith(filtered: result));
  }

  void toggleFavoriteCard(int caseId) {
    _allCases = _allCases.map((c) {
      if (c.id == caseId) {
        return c.copyWith(isFavorite: !c.isFavorite);
      }
      return c;
    }).toList();

    applyFilters();
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
