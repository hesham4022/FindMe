import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';

import 'package:find_me_app/features/add_case/data/source/update_case_remote.dart';

class UpdateCaseRepo {
  final UpdateCaseRemote _updateCasesRemote;
  UpdateCaseRepo(this._updateCasesRemote);

  Future<Either<Failure, CreateReportResponse>> updateCase(
    CreateReportRequest request,
    int id,
  ) {
    print('📡 [AuthRepo] Sending signup request again: ${request.toJson()}');
    return executeFunctionality<CreateReportResponse>(
      function: () async {
        final json = await _updateCasesRemote.updateCase(request, id);
        final response = CreateReportResponse.fromMap(json);
        print('📩 [AuthRepo] Signup Response: ${response}');

        return response;
      },
    );
  }

  Future<Either<Failure, String>> deleteCase(int caseId) {
    print('🗑️ [AuthRepo] Sending delete account request');

    return executeFunctionality<String>(
      function: () async {
        final result = await _updateCasesRemote.deleteCase(caseId);
        print('✅ [AuthRepo] Delete Account Response: $result');
        return result;
      },
    );
  }
}
