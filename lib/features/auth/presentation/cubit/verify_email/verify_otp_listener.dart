import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void verifyOTPListener(BuildContext context, VerifyOTPState state) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (state.isVerifyOTPSuccess) {
      showAlertSnackBar(
        context,
        state.success?.msg ?? "تم تفعيل الحساب بنجاح ✅",
        AlertType.success,
      );
      await context.read<HostCubit>().loadCachedUser();
      context.toNamed(AppRoutes.hostRoute);
    } else if (state.isVerifyOTPError && state.error != null) {
      showAlertSnackBar(
        context,
        state.error!.msg,
        AlertType.error,
      );
    }
  });
}

// void verifyOTPListener(BuildContext context, VerifyOTPState state) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     // ✅ في حالة النجاح
//     if (state.isVerifyOTPSuccess && state.error == null) {
//       showAlertSnackBar(
//         context,
//         "تم تفعيل الحساب بنجاح ✅",
//         AlertType.success,
//       );

//       context.toNamed(AppRoutes.hostRoute);
//       return;
//     }

//     // ❌ في حالة الخطأ
//     if (state.isVerifyOTPError && state.error != null) {
//       showAlertSnackBar(
//         context,
//         state.error!.msg,
//         AlertType.error,
//       );
//       return;
//     }

//     // 🔁 عند نجاح إعادة إرسال OTP
//     if (state.isResendOTPSuccess) {
//       showAlertSnackBar(
//         context,
//         "تم إرسال رمز تحقق جديد إلى بريدك الإلكتروني 📩",
//         AlertType.success,
//       );
//       return;
//     }

//     // ⚠️ في حالة فشل إعادة إرسال OTP
//     if (state.isResendOTPError && state.error != null) {
//       showAlertSnackBar(
//         context,
//         state.error!.msg,
//         AlertType.error,
//       );
//     }
//   });
// }
