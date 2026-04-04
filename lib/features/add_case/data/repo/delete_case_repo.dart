import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/add_case/data/source/delete_case_remote.dart';

class DeleteCaseRepo {
  final DeleteCaseRemote _deleteCasesRemote;
  DeleteCaseRepo(this._deleteCasesRemote);

  Future<Either<Failure, String>> deleteCase(int caseId) {
    print('🗑️ [AuthRepo] Sending delete account request');

    return executeFunctionality<String>(
      function: () async {
        final result = await _deleteCasesRemote.deleteCase(caseId);
        print('✅ [AuthRepo] Delete Account Response: $result');
        return result;
      },
    );
  }
}
