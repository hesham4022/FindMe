import 'package:find_me_app/core/shared/widgets/password_field.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OTPField extends StatelessWidget {
  const OTPField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Code".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            VSpace(10),
            CustomTextField(
                hint: "code".ts,
                errorText: state.otpErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.number,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<ResetPasswordCubit>().otpChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateUsername(
                      value); // String? (null لو صحيح)
                  // خزّن الرسالة في الـ state عشان UI تقدر تعرضها
                  context
                      .read<ResetPasswordCubit>()
                      .otpErrorTextChanged(err ?? "");
                  // مهم: رجّع null لما الإدخال صحيح
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          previous.passwordErrorText != current.passwordErrorText,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "passordLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            VSpace(10),
            RPasswordField(
              errorText: state.passwordErrorText,
              hint: '******',
              prefixIcon: Icon(
                MdiIcons.lockOpenVariantOutline,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onChanged: (value) {
                context.read<ResetPasswordCubit>().passwordChanged(value);
              },
              validate: (value) {
                final errorText = AppValidators.validateSignInPassword(value);
                context
                    .read<ResetPasswordCubit>()
                    .passwordErrorTextChanged(errorText ?? "");
                return errorText;
              },
            ),
          ],
        );
      },
    );
  }
}

class ConfirmNewPasswordField extends StatelessWidget {
  const ConfirmNewPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPasswordErrorText != current.confirmPasswordErrorText,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "confirmpassordLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            VSpace(10),
            RPasswordField(
              errorText: state.confirmPasswordErrorText,
              hint: "******",
              prefixIcon: Icon(
                MdiIcons.lockOpenVariantOutline,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onChanged: (value) {
                context
                    .read<ResetPasswordCubit>()
                    .confirmPasswordChanged(value);
              },
              validate: (value) {
                final password =
                    context.read<ResetPasswordCubit>().state.password;
                String? errorText;

                if (value == null || value.isEmpty) {
                  errorText = "Field is required";
                } else if (value != password) {
                  errorText = "Passwords do not match";
                }

                context
                    .read<ResetPasswordCubit>()
                    .confirmPasswordErrorTextChanged(errorText ?? "");
                return errorText;
              },
            ),
          ],
        );
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      // buildWhen: (previous, current) =>
      //     (previous.isButtonEnabled != current.isButtonEnabled ||
      //         previous.status != current.status),
      builder: (context, state) {
        return CustomFilledButton(
          title: Text("createNewPassword".ts,
              style: Theme.of(context).textTheme.kHeadingH4SmallBold.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
          state: CustomState.active,
          loading: state.isLoading,
          onPressed: context.read<ResetPasswordCubit>().resetPassword,
          radius: 30,
          width: 273, // ← استخدم .w هنا لو حابب
          height: 45, // ← واستخدم .h هنا
        );
      },
    );
  }
}
