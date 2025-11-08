import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "emailOrMobileNumber".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            VSpace(10),
            CustomTextField(
                hint: AppStrings.username.ts,
                errorText: state.emailErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.emailAddress,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<ForgotPasswordCubit>().emailChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateEmail(
                      value); // String? (null لو صحيح)
                  // خزّن الرسالة في الـ state عشان UI تقدر تعرضها
                  context
                      .read<ForgotPasswordCubit>()
                      .emailErrorTextChanged(err ?? "");
                  // مهم: رجّع null لما الإدخال صحيح
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      // buildWhen: (previous, current) =>
      //     (previous.isButtonEnabled != current.isButtonEnabled ||
      //         previous.status != current.status),
      builder: (context, state) {
        return CustomFilledButton(
          title: Text("Confirm".ts,
              style: Theme.of(context).textTheme.kHeadingH4SmallBold.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
          state: CustomState.active,
          loading: state.isLoading,
          onPressed: context.read<ForgotPasswordCubit>().submit,
          radius: 30,
          width: 273, // ← استخدم .w هنا لو حابب
          height: 45, // ← واستخدم .h هنا
        );
      },
    );
  }
}
