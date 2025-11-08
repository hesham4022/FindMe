// import 'package:flutter/material.dart';
// import 'package:find_me_app/core/helpers/extensions/context.dart';
// import 'package:find_me_app/core/resources/routes.dart';
// import 'package:find_me_app/core/shared/widgets/alerts.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';
// import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';

// void signInListener(BuildContext context, SignInState state) {
//   if (state.isSuccess) {
//     //! If Account is activated
//     if (state.isActivated) {
//       context.offAllNamed(AppRoutes.hostRoute);
//     }
//     //! If Account is not activated
//     else {
//       context.toNamed(
//         AppRoutes.verifyOTPRoute,
//         arguments: VerifyOTPArgs(
//           username: state.username!,
//         ),
//       );

//       showAlertSnackBar(
//         context,
//         state.error?.msg ?? "",
//         AlertType.error,
//       );
//     }
//   } else if (state.isError) {
//     showAlertSnackBar(
//       context,
//       state.error?.msg ?? "",
//       AlertType.error,
//     );
//   }
// }

// void tokenIdListener(BuildContext context, SignInState state) {
//   if (state.isTokenIsInvalid) {
//     showAlertSnackBar(
//       context,
//       state.error?.msg ?? "",
//       AlertType.error,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';

void signInListener(BuildContext context, SignInState state) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // ⚠️ حالة الخطأ
    if (state.isError) {
      showAlertSnackBar(
        context,
        state.error?.msg ?? "حدث خطأ غير متوقع. حاول مرة أخرى.",
        AlertType.error,
      );
    }
  });
}
