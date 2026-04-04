import 'package:find_me_app/features/add_case/presentation/cubits/case_action/cubit/case_action_state.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addCaseListener(BuildContext context, CaseActionState state) {
  if (state.status == CaseActionStatus.success) {
    final allCasesCubit = context.read<AllCasesCubit>();

    if (state.actionType == CaseActionType.add) {
      final caseInfoModel = state.success.data;
      if (caseInfoModel != null) {
        allCasesCubit.addNewCase(caseInfoModel);
      }
      Navigator.pop(context);
    } else if (state.actionType == CaseActionType.update) {
      final caseInfoModel = state.success.data;
      if (caseInfoModel != null) {
        allCasesCubit.updateCaseInList(caseInfoModel);
      }
      Navigator.pop(context);
    }
  }

  if (state.status == CaseActionStatus.error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.error?.msg ?? 'Something went wrong'),
      ),
    );
  }
}
