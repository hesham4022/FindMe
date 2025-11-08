import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_state.dart';

void resetPasswordListener(BuildContext context, ResetPasswordState state) {
  if (state.isSuccess) {
    // ✅ نجاح
    showAlertSnackBar(
      context,
      state.success?.message ?? 'تم تغيير كلمة المرور بنجاح ✅',
      AlertType.success,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      context.offAllNamed(AppRoutes.signinRoute);
    });
  } else if (state.isError) {
    final errorMsg =
        state.error?.msg ?? 'حدث خطأ أثناء إعادة تعيين كلمة المرور';
    showAlertSnackBar(
      context,
      errorMsg,
      AlertType.error,
    );
  }
}
