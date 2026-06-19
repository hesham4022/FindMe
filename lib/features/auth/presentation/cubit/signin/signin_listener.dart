import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/pages/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void signInListener(BuildContext context, SignInState state) async {
  if (state.isError) {
    showAlertSnackBar(
      context,
      state.error?.msg ?? "Error",
      AlertType.error,
    );
    context.read<SignInCubit>().resetState();
  }

  if (state.status == SignInStatus.needVerifyEmail) {
    Navigator.pushNamed(
      context,
      AppRoutes.verifyOTPRoute,
      arguments: VerifyOTPArgs(
        username: state.username ?? '',
      ),
    );
  }

  if (state.isSuccess) {
    context.read<HostCubit>().setAuthenticatedUser(state.user!);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const HostView(currentIndex: 0),
      ),
      (_) => false,
    );
  }
}
