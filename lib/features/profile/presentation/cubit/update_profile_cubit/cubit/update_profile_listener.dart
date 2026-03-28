import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void updateProfileListener(BuildContext context, UpdateProfileState state) {
  if (state.isSuccess) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
          context, state.success?.message ?? "", AlertType.success);
    });
    context.read<UpdateProfileCubit>().resetStatus();
  }

  if (state.isError) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(context, state.error?.msg ?? "", AlertType.error);
    });
  }
}
