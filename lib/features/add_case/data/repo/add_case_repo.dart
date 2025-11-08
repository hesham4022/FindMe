import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/add_case/data/source/add_case_remote.dart';

class AddCasesRepo {
  final AddCaseRemote _addCasesRemote;
  AddCasesRepo(this._addCasesRemote);

  Future<Either<Failure, CreateReportResponse>> addCase(
    CreateReportRequest request,
  ) {
    print('📡 [AuthRepo] Sending signup request again: ${request.toJson()}');
    return executeFunctionality<CreateReportResponse>(
      function: () async {
        final json = await _addCasesRemote.addCase(request);
        final response = CreateReportResponse.fromMap(json);
        print('📩 [AuthRepo] Signup Response: ${response}');

        return response;
      },
    );
  }
}
