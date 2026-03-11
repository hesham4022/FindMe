// import 'package:dartz/dartz.dart';
// import 'package:find_me_app/core/error_management/failure.dart';
// import 'package:find_me_app/core/networking/functions.dart';
// import 'package:find_me_app/features/add_case/data/model/create_report.dart';
// import 'package:find_me_app/features/add_case/data/model/update_report.dart';
// import 'package:find_me_app/features/add_case/data/source/update_case_remote.dart';

// class UpdateReportRepo {
//   final UpdateReportRemote _updateReportRemote;
//   UpdateReportRepo(this._updateReportRemote);

//   Future<Either<Failure, UpdateReportResponse>> updateReport(
//     String id,
//     CreateReportRequest request,
//   ) {
//     print('📡 [UpdateReportRepo] Sending update request: ${request.toJson()}');
//     return executeFunctionality<UpdateReportResponse>(
//       function: () async {
//         final json = await _updateReportRemote.updateReport(id, request);
//         final response = UpdateReportResponse.fromMap(json);
//         print('📩 [UpdateReportRepo] Update Response: ${response}');
//         return response;
//       },
//     );
//   }
// }
