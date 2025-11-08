import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/custom_formatter.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_state.dart';
import 'package:find_me_app/features/auth/presentation/widgets/otp_resend_widget.dart';
import 'package:pinput/pinput.dart';

/// ------------------------------
/// ✅ العنوان والوصف
/// ------------------------------
class VerifyOTPTitleAndSubtitle extends StatelessWidget {
  const VerifyOTPTitleAndSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "verifyOTPTitle".ts,
          style: Theme.of(context).textTheme.kSubheadingSemiBold,
        ),
        VSpace(4),
        Text(
          "verifyOTPSubtitle".ts,
          style: Theme.of(context)
              .textTheme
              .kCaptionRegular
              .copyWith(color: AppColors.saltBox700),
        ),
      ],
    );
  }
}

/// ------------------------------
/// ✅ حقول إدخال الـ OTP
/// ------------------------------
class OTPWidget extends StatelessWidget {
  const OTPWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.r,
      height: 50.r,
      textStyle: Theme.of(context).textTheme.kParagraph02SemiBold.copyWith(
            color: AppColors.saltBox950,
          ),
      decoration: BoxDecoration(
        color: AppColors.saltBox50,
        borderRadius: BorderRadius.circular(12).r,
        border: Border.all(color: AppColors.saltBox200),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 5,
        defaultPinTheme: defaultPinTheme,
        keyboardType: TextInputType.number,
        inputFormatters: [ArabicToEnglishDigitsFormatter()],
        preFilledWidget: Text(
          "_",
          style: Theme.of(context).textTheme.kParagraph02Regular.copyWith(
                color: AppColors.saltBox300,
              ),
        ),
        onChanged: (value) =>
            context.read<VerifyOTPCubit>().onOTPChanged(value.trim()),
      ),
    );
  }
}

/// ------------------------------
/// ✅ زر تأكيد الكود
/// ------------------------------
class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOTPCubit, VerifyOTPState>(
      buildWhen: (previous, current) =>
          (previous.isButtonEnabled != current.isButtonEnabled ||
              previous.status != current.status),
      builder: (context, state) {
        return CustomFilledButton(
          titleText: AppStrings.confirm.ts,
          state:
              state.isButtonEnabled ? CustomState.active : CustomState.disabled,
          loading: state.isVerifyOTPLoading,
          onPressed: state.isButtonEnabled
              ? () {
                  print("🟢 Confirm button pressed");
                  context.read<VerifyOTPCubit>().verifyOTP();
                }
              : null,
          width: 353.w,
          height: 50.h,
        );
      },
    );
  }
}

/// ------------------------------
/// ✅ زر إعادة إرسال الكود
/// ------------------------------
///
class ResendOTPButton extends StatelessWidget {
  const ResendOTPButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOTPCubit, VerifyOTPState>(
      buildWhen: (previous, current) =>
          previous.isResendOTPLoading != current.isResendOTPLoading ||
          previous.isResendOTPSuccess != current.isResendOTPSuccess ||
          previous.isResendOTPError != current.isResendOTPError,
      builder: (context, state) {
        return ResendOTPWidget(
          onResend: () {
            context.read<VerifyOTPCubit>().resendOTP();
          },
          isLoading: state.isResendOTPLoading,
          isSuccess: state.isResendOTPSuccess,
        );
      },
    );
  }
}

// class ResendOTPButton extends StatelessWidget {
//   const ResendOTPButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VerifyOTPCubit, VerifyOTPState>(
//       buildWhen: (previous, current) =>
//           (previous.isResendOTPLoading != current.isResendOTPLoading) ||
//           (previous.isResendOTPSuccess != current.isResendOTPSuccess),
//       builder: (context, state) {
//         return ResendOTPWidget(
//           onResend: context.read<VerifyOTPCubit>().resendOTP,
//           isLoading: state.isResendOTPLoading,
//           isSuccess: state.isResendOTPSuccess,
//         );
//       },
//     );
//   }
// }
