import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';

void forgotPasswordListener(BuildContext context, ForgotPasswordState state) {
  if (state.isSuccess) {
    // أولاً نعرض رسالة النجاح
    showAlertSnackBar(
      context,
      state.success?.message ?? 'تم إرسال رمز التحقق إلى بريدك الإلكتروني ✅',
      AlertType.success,
    );

    // بعد فترة بسيطة (نصف ثانية) ننتقل لصفحة التحقق
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
