// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:find_me_app/core/error_management/failure.dart';
// import 'package:find_me_app/core/networking/functions.dart';
// import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
// import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';
// import 'package:find_me_app/features/search_case/data/source/search_image_remote.dart';

// class SearchImageRepo {
//   final SearchImageRemote _searchImageRemote;
//   SearchImageRepo(this._searchImageRemote);

//   Future<Either<Failure, List<CaseInfoModel>>> searchCasesByImage(
//     SearchByImageRequest request,
//   ) {
//     print('📡 [AllCasesRepo] Searching by image: ${request.imagePath}');

//     return executeFunctionality<List<CaseInfoModel>>(
//       function: () async {
//         // 🧩 استدعاء الـ Remote
//         final json = await _searchImageRemote.searchByImage(request);

//         // 🧩 تحويل البيانات إلى SearchByImageResponse
//         final response = SearchByImageResponse.fromMap(json);
//         print(
//             '📩 [AllCasesRepo] Search Result: ${response.cases.length} cases found');

//         // ✅ إرجاع قائمة الحالات المشابهة
//         return response.cases;
//       },
//     );
//   }
// }
