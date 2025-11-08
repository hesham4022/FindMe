// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
// import 'package:find_me_app/core/helpers/formfield_validator.dart';
// import 'package:find_me_app/core/resources/colors.dart';
// import 'package:find_me_app/core/resources/strings.dart';
// import 'package:find_me_app/core/resources/themes.dart';
// import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
// import 'package:find_me_app/core/shared/widgets/password_field.dart';
// import 'package:find_me_app/core/shared/widgets/sizes.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_listener.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import 'package:find_me_app/features/auth/presentation/widgets/auth_appbar.dart';

// class ResetPasswordArgs {
//   final String token;

//   ResetPasswordArgs({
//     required this.token,
//   });
// }

// class ResetPasswordView extends StatelessWidget {
//   const ResetPasswordView({
//     super.key,
//     required this.args,
//   });

//   final ResetPasswordArgs args;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ResetPasswordCubit(sl(), args),
//       child: const Scaffold(
//         appBar: AuthAppBar(title: AppStrings.resetPassword),
//         resizeToAvoidBottomInset: false,
//         body: _ResetPasswordBody(),
//       ),
//     );
//   }
// }

// class _ResetPasswordBody extends StatelessWidget {
//   const _ResetPasswordBody();

//   @override
//   Widget build(BuildContext context) {
//     /// Used for scrolling fields disappeared when keyboard appearing
//     final bottom = MediaQuery.of(context).viewInsets.bottom;

//     return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
//       listener: resetPasswordListener,
//       builder: (context, state) => ListView(
//         padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         children: [
//           AuthHeader(),
//           VSpace(16),
//           _PasswordField(),
//           VSpace(20),
//           _ConfirmPasswordField(),
//           VSpace(32),
//           _ResetPasswordButton(),
//           VSpace(16),
//           _ErrorLine(),
//         ],
//       ),
//     );
//   }
// }

// //---------------------------- Fields ------------------------------------------
// class _PasswordField extends StatelessWidget {
//   const _PasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
//       buildWhen: (previous, current) =>
//           previous.passwordErrorText != current.passwordErrorText,
//       builder: (context, state) {
//         return RPasswordField(
//           errorText: state.passwordErrorText,
//           hint: AppStrings.password.ts,
//           prefixIcon: Icon(
//             MdiIcons.lockOpenVariantOutline,
//             size: 20.sp,
//             color: AppColors.saltBox600,
//           ),
//           onChanged: (value) {
//             context.read<ResetPasswordCubit>().passwordChanged(value);
//           },
//           validate: (value) {
//             final errorText = AppValidators.validateNewPassword(value);
//             context
//                 .read<ResetPasswordCubit>()
//                 .passwordErrorTextChanged(errorText ?? "");
//             return errorText;
//           },
//         );
//       },
//     );
//   }
// }

// class _ConfirmPasswordField extends StatelessWidget {
//   const _ConfirmPasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
//       buildWhen: (previous, current) =>
//           (previous.confirmPasswordErrorText !=
//               current.confirmPasswordErrorText) ||
//           (previous.password != current.password),
//       builder: (context, state) {
//         return RPasswordField(
//           hint: AppStrings.confirmNewPassword.ts,
//           errorText: state.confirmPasswordErrorText,
//           prefixIcon: Icon(
//             MdiIcons.lockOpenVariantOutline,
//             size: 20.sp,
//             color: AppColors.saltBox600,
//           ),
//           onChanged: (value) {
//             context.read<ResetPasswordCubit>().confirmPasswordChanged(value);
//           },
//           validate: (value) {
//             final errorText =
//                 AppValidators.validateTwoPasswords(value, state.password);
//             context
//                 .read<ResetPasswordCubit>()
//                 .confirmPasswordErrorTextChanged(errorText ?? "");
//             return errorText;
//           },
//         );
//       },
//     );
//   }
// }

// class _ResetPasswordButton extends StatelessWidget {
//   const _ResetPasswordButton();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
//       buildWhen: (previous, current) =>
//           (previous.isButtonEnabled != current.isButtonEnabled ||
//               previous.status != current.status),
//       builder: (context, state) {
//         return CustomFilledButton(
//           titleText: AppStrings.resetPassword.ts,
//           state:
//               state.isButtonEnabled ? CustomState.active : CustomState.disabled,
//           loading: state.status == ResetPasswordStatus.loading,
//           onPressed: context.read<ResetPasswordCubit>().resetPassword,
//           width: 353,
//           height: 50,
//         );
//       },
//     );
//   }
// }

// class _ErrorLine extends StatelessWidget {
//   const _ErrorLine();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
//       buildWhen: (previous, current) => previous.isError != current.isError,
//       builder: (context, state) {
//         return (state.isError)
//             ? Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(
//                     Icons.error_outline_rounded,
//                     color: AppColors.error500,
//                     size: 16,
//                   ),
//                   HSpace(4),
//                   Expanded(
//                     child: Text(
//                       state.error!.msg,
//                       style: Theme.of(context)
//                           .textTheme
//                           .kParagraph01Regular
//                           .copyWith(color: AppColors.error500),
//                     ),
//                   ),
//                 ],
//               )
//             : const SizedBox.shrink();
//       },
//     );
//   }
// }
