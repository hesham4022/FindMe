import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';

void forgotPasswordListener(BuildContext context, ForgotPasswordState state) {
  if (state.isSuccess) {
    showAlertSnackBar(
      context,
      state.success?.message ?? 'تم إرسال رمز التحقق إلى بريدك الإلكتروني ✅',
      AlertType.success,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      context.toNamed(
        AppRoutes.resetPasswordRoute1,
        arguments: ResetPasswordArgs(
          email: state.email ?? '',
        ),
      );
    });
  }

  if (state.isError && state.error != null) {
    showAlertSnackBar(
      context,
      state.error!.msg,
      AlertType.error,
    );
  }
}
