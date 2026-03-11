import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/case_info/data/models/single_case_model.dart';
import 'package:find_me_app/features/case_info/data/source/single_case_remote.dart';

class SingleCaseRepo {
  final SingleCaseRemote _SingleCaseRemote;
  SingleCaseRepo(this._SingleCaseRemote);

  Future<Either<Failure, SingleCaseResponse>> getCaseByIdResponseData(
      String id) {
    return executeFunctionality<SingleCaseResponse>(
      function: () async {
        final jsonString = await _SingleCaseRemote.getCaseByIdResponseData(id);

        final decodedJson = jsonDecode(jsonString);

        final result = SingleCaseResponse.fromMap(decodedJson);

        print(" ID = ${result.data.id}");
        print(" Name = ${result.data.firstName} ${result.data.lastName}");

        return result;
      },
    );
  }
}
