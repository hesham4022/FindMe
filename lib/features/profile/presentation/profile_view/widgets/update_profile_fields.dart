import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_cubit.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/show_calendar_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "fullNameLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: "hintname".ts,
                errorText: state.fullNameErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<UpdateProfileCubit>().fullNameChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateUsername(value);
                  context
                      .read<UpdateProfileCubit>()
                      .fullNameErrorTextChanged(err ?? "");
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "phoneNumberLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: "hintPhone".ts,
                errorText: state.mobileNumberErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.number,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<UpdateProfileCubit>().mobileNumberChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validatePhoneNumber(value);
                  context
                      .read<UpdateProfileCubit>()
                      .mobileNumberErrorTextChanged(err ?? "");

                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "emailLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
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
                  context.read<UpdateProfileCubit>().emailChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateEmail(value);
                  context
                      .read<UpdateProfileCubit>()
                      .emailErrorTextChanged(err ?? "");

                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class DateField extends StatelessWidget {
  const DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date Of Birth",
          style: Theme.of(context).textTheme.kSubheadingRegular,
        ),
        VSpace(10),
        CustomTextField(
          readOnly: true,
          // controller: context.read<BusinessTripsCubit>().fromDateCtrl,
          hint: "DD / MM / YY",
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.saltBox900,
          ),
          onTap: () => kShowCalendarBottomSheet(
            context,
            onSelected: (value) {},
          ),
        ),
      ],
    );
  }
}

class UpdateProfileButton extends StatelessWidget {
  const UpdateProfileButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          (previous.isButtonEnabled != current.isButtonEnabled ||
              previous.isLoading != current.isLoading),
      builder: (context, state) {
        return Align(
          alignment: Alignment.center, // اختياري
          child: CustomFilledButton(
            width: 207,
            height: 45,
            radius: 30,
            title: Text("update profile".ts,
                style: Theme.of(context).textTheme.kHeadingH4SmallBold),
            state: CustomState.active,
            loading: state.isLoading,
            onPressed: () {
              context.read<SignInCubit>().submitSignIn(context);
            },
            // سيب width/height جوّا البتن فاضيين
          ),
        );
      },
    );
  }
}
