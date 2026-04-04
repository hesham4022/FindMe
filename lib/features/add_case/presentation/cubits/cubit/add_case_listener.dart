import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addCaseListener(BuildContext context, AddCaseState state) {
  if (state.isSuccess) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
          context, state.success?.message ?? "", AlertType.success);
      context.read<AddCaseCubit>().resetStatus();
      // context.toNamed(AppRoutes.hostRoute);
    });
  }

  if (state.isError) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(context, state.error?.msg ?? "", AlertType.error);
    });
  }
}
