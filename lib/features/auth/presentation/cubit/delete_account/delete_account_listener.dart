import 'package:find_me_app/features/auth/presentation/cubit/delete_account/delete_account_cubit.dart';
import 'package:find_me_app/features/auth/presentation/pages/signin.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteAccountListener(BuildContext context, DeleteAccountState state) {
  if (state.isSuccess) {
    context.read<HostCubit>().logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => SigninView(),
      ),
      (route) => false,
    );
    showAlertSnackBar(
      context,
      state.success?.message ?? 'Delete Account Done',
      AlertType.success,
    );
  }

  if (state.isError && state.error != null) {
    showAlertSnackBar(
      context,
      state.error!.msg,
      AlertType.error,
    );
  }
}
