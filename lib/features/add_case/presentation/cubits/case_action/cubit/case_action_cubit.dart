import 'dart:developer';

import 'package:find_me_app/features/add_case/presentation/cubits/case_form/cubit/case_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/add_case/data/repo/add_case_repo.dart';
import 'package:find_me_app/features/add_case/data/repo/update_case_repo.dart';

import 'case_action_state.dart';

class CaseActionCubit extends Cubit<CaseActionState> {
  final AddCasesRepo _addRepo;
  final UpdateCaseRepo _updateRepo;

  CaseActionCubit(this._addRepo, this._updateRepo)
      : super(CaseActionState.initial());

  void resetStatus() {
    emit(CaseActionState.initial());
  }

  CreateReportRequest _buildRequest(CaseFormState formState) {
    return CreateReportRequest(
      firstName: formState.firstName ?? '',
      lastName: formState.lastName ?? '',
      address: formState.address ?? '',
      age: formState.age ?? 0,
      gender: formState.gender ?? '',
      weight: formState.weight,
      height: formState.height,
      description: formState.description,
      dateLastSeen: formState.dateLastSeen,
      lastSeenLocation: formState.lastSeenLocation,
      fullBreakdownDetails: formState.fullBreakdownDetails,
      vehicleDetails: formState.vehicleDetails,
      hasVehicle: formState.hasVehicle,
      confirmInformation: formState.confirmInformation,
      consentToShare: formState.consentToShare,
      photos: formState.photos,
    );
  }

  Future<void> addCase(CaseFormState formState) async {
    if (state.isLoading) return;

    emit(state.copyWith(
      actionType: CaseActionType.add,
      status: CaseActionStatus.loading,
      error: null,
    ));

    final request = _buildRequest(formState);
    log('📤 Sending Add Request: ${request.toJson()}');

    final result = await _addRepo.addCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          actionType: CaseActionType.add,
          status: CaseActionStatus.error,
          error: failure,
        ));
      },
      (response) {
        emit(state.copyWith(
          actionType: CaseActionType.add,
          status: CaseActionStatus.success,
          success: response,
          error: null,
        ));
      },
    );
  }

  Future<void> updateCase(CaseFormState formState, int id) async {
    if (state.isLoading) return;

    emit(state.copyWith(
      actionType: CaseActionType.update,
      status: CaseActionStatus.loading,
      error: null,
    ));

    final request = _buildRequest(formState);
    log('📤 Sending Update Request: ${request.toJson()}');

    final result = await _updateRepo.updateCase(request, id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          actionType: CaseActionType.update,
          status: CaseActionStatus.error,
          error: failure,
        ));
      },
      (response) {
        emit(state.copyWith(
          actionType: CaseActionType.update,
          status: CaseActionStatus.success,
          success: response,
          error: null,
        ));
      },
    );
  }

  Future<void> deleteCase(int caseId) async {
    if (state.isLoading) return;

    emit(state.copyWith(
      actionType: CaseActionType.deleteCase,
      status: CaseActionStatus.loading,
      error: null,
    ));

    final result = await _updateRepo.deleteCase(caseId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          actionType: CaseActionType.deleteCase,
          status: CaseActionStatus.error,
          error: failure,
        ));
      },
      (response) {
        emit(state.copyWith(
          actionType: CaseActionType.deleteCase,
          status: CaseActionStatus.success,
          success: response,
          error: null,
        ));
      },
    );
  }
}
