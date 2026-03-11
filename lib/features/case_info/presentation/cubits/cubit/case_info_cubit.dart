import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/case_info/data/repo/single_case_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'case_info_state.dart';

class CaseInfoCubit extends Cubit<CaseInfoState> {
  final SingleCaseRepo _singleCaseRepo;
  CaseInfoCubit(this._singleCaseRepo) : super(CaseInfoState.initial());

  Future<void> getCaseById(String id) async {
    emit(state.copyWith(status: CaseInfoStatus.laoding));

    final result = await _singleCaseRepo.getCaseByIdResponseData(id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CaseInfoStatus.error,
          failure: failure,
        ));
      },
      (success) {
        final caseData = success.data;

        emit(state.copyWith(
          status: CaseInfoStatus.success,
          selectedCase: caseData,
        ));
      },
    );
  }
}
