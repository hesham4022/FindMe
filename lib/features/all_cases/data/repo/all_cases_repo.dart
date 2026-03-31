import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/source/all_cases_remote.dart';
import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';

class AllCasesRepo {
  final AllCasesRemote _allCasesRemote;

  AllCasesRepo(this._allCasesRemote);

  Future<Either<Failure, AllCasesResponse>> getAllCasesResponseData() {
    return executeFunctionality<AllCasesResponse>(
      function: () async {
        final jsonString = await _allCasesRemote.getAllCasesResponseData();

        final decodedJson = jsonDecode(jsonString);

        final result = AllCasesResponse.fromMap(decodedJson);

        print("عدد الحالات = ${result.allCases.length}");
        print("أول اسم = ${result.allCases.first.firstName}");

        return result;
      },
    );
  }

  Future<Either<Failure, SearchByImageResponse>> searchCasesByImage(
    SearchByImageRequest request,
  ) {
    print('📡 [AllCasesRepo] Searching by image: ${request.imagePath}');

    return executeFunctionality<SearchByImageResponse>(
      function: () async {
        final json = await _allCasesRemote.searchByImage(request);

        final response = SearchByImageResponse.fromMap(json);

        print(
          '📩 [AllCasesRepo] Search Result: ${response.cases.length} cases found',
        );

        return response;
      },
    );
  }
  // Future<Either<Failure, AllCasesResponse>> getCaseByIdResponseData(String id) {
  //   return executeFunctionality<AllCasesResponse>(
  //     function: () async {
  //       final jsonString = await _allCasesRemote.getCaseByIdResponseData(id);

  //       final decodedJson = jsonDecode(jsonString);

  //       final result = AllCasesResponse.fromMap(decodedJson);

  //       print("عدد الحالات = ${result.allCases.length}");
  //       print("أول اسم = ${result.allCases.first.firstName}");

  //       return result;
  //     },
  //   );
  // }

  Future<bool> toggleLike(int reportId) async {
    try {
      // يجيب isLiked من الريموت مباشرة
      final isLiked = await _allCasesRemote.toggleLike(reportId);
      return isLiked;
    } catch (e) {
      log('ToggleLike Error: $e');
      rethrow;
    }
  }
}
