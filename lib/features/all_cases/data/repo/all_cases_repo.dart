import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/data/source/all_cases_remote.dart';
import 'package:find_me_app/features/auth/data/model/activate_account.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:find_me_app/features/auth/data/model/change_password.dart';
import 'package:find_me_app/features/auth/data/model/reset_password.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/data/source/auth_remote.dart';

class AllCasesRepo {
  final AllCasesRemote _allCasesRemote;
  AllCasesRepo(this._allCasesRemote);

  Future<Either<Failure, AllCasesResponse>> getAllCasesResponseData() {
    return executeFunctionality<AllCasesResponse>(
      function: () async {
        final jsonString = await _allCasesRemote.getAllCasesResponseData();

        // الخط ده كان بيعمل JSON Decode بالفعل، فمش لازم تدي String تاني لـ fromJson
        final decodedJson = jsonDecode(jsonString);

        // ✅ استخدم fromMap مش fromJson
        final result = AllCasesResponse.fromMap(decodedJson);

        print("عدد الحالات = ${result.allCases.length}");
        print("أول اسم = ${result.allCases.first.firstName}");

        return result;
      },
    );
  }
}
