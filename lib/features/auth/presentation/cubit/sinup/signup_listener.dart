import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';

void signUpListener(BuildContext context, SinupState state) {
  // if (state.status == SinUpStatus.success && state.error == null) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (state.emailVerification != null &&
  //         state.emailVerification!.isNotEmpty) {
  //       // المستخدم غير مفعل → صفحة OTP
  //       context.toNamed(
  //         AppRoutes.verifyOTPRoute,
  //         arguments: VerifyOTPArgs(username: state.email ?? ''),
  //       );
  //     } else {
  //       // المستخدم مفعل → صفحة Host
  //       context.toNamed(AppRoutes.hostRoute);
  //     }
  //   });
  // }

  if (state.status == SinUpStatus.error && state.error != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
        context,
        state.error!.msg, // الرسالة جاية من السيرفر
        AlertType.error,
      );
    });
  }
}

// git fetch origin
//git reset --hard origin/main
