import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_action/cubit/case_action_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_action/cubit/case_action_state.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addCaseListener(BuildContext context, CaseActionState state) {
  if (state.status == CaseActionStatus.success) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
        context,
        state.success?.message ?? "",
        AlertType.success,
      );

      // تحديث الليست حسب نوع العملية
      final allCasesCubit = context.read<AllCasesCubit>();

      if (state.actionType == CaseActionType.add) {
        final caseModel = state.success?.data;
        if (caseModel != null) {
          allCasesCubit.addNewCase(caseModel);
        }
      } else if (state.actionType == CaseActionType.update) {
        final caseModel = state.success?.data;
        if (caseModel != null) {
          allCasesCubit.updateCaseInList(caseModel);
        }
      } else if (state.actionType == CaseActionType.deleteCase) {
        // لو انت بتمرير id في مكان تاني
        // allCasesCubit.removeCaseFromList(caseId);
      }

      context.read<CaseActionCubit>().resetStatus();

      Navigator.pop(context); // يقفل الشاشة بعد النجاح
    });
  }

  if (state.status == CaseActionStatus.error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
        context,
        state.error?.msg ?? "",
        AlertType.error,
      );
    });
  }
}
