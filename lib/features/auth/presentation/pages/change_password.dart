// import 'package:find_me_app/core/resources/themes.dart';
// import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
// import 'package:find_me_app/core/helpers/formfield_validator.dart';
// import 'package:find_me_app/core/resources/colors.dart';
// import 'package:find_me_app/core/resources/strings.dart';
// import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
// import 'package:find_me_app/core/shared/widgets/password_field.dart';
// import 'package:find_me_app/core/shared/widgets/sizes.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/change_password/change_password_cubit.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/change_password/change_password_listener.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/change_password/change_password_state.dart';
// import 'package:find_me_app/features/auth/presentation/widgets/auth_appbar.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class ChangePasswordView extends StatelessWidget {
//   const ChangePasswordView({
//     super.key,
//     this.isChangePassword = true,
//   });
//   final bool isChangePassword;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ChangePasswordCubit(sl()),
//       child: Scaffold(
//         appBar: CustomAppBar(titleText: "Password Manager"),
//         resizeToAvoidBottomInset: false,
//         body: _ChangePasswordBody(),
//       ),
//     );
//   }
// }

// class _ChangePasswordBody extends StatelessWidget {
//   const _ChangePasswordBody();

//   @override
//   Widget build(BuildContext context) {
//     /// Used for scrolling fields disappeared when keyboard appearing
//     final bottom = MediaQuery.of(context).viewInsets.bottom;

//     return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
//       listener: changePasswordListener,
//       builder: (context, state) => ListView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 16, 20, bottom).r,
//             child: Column(
//               children: [
//                 _CurrentPasswordField(),
//                 VSpace(20),
//                 _NewPasswordField(),
//                 VSpace(20),
//                 _ConfirmNewPasswordField(),
//                 VSpace(280),
//                 _ChangePasswordButton(
//                     // isChangePassword: isChangePassword,
//                     ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //---------------------------- Fields ------------------------------------------
// class _CurrentPasswordField extends StatelessWidget {
//   const _CurrentPasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
//       buildWhen: (previous, current) =>
//           previous.oldPasswordErrorText != current.oldPasswordErrorText,
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Current Password".ts,
//                 style: Theme.of(context).textTheme.kSubheadingRegular),
//             VSpace(7),
//             RPasswordField(
//               errorText: state.oldPasswordErrorText,
//               hint: AppStrings.currentPassword.ts,
//               prefixIcon: Icon(
//                 MdiIcons.lockOpenVariantOutline,
//                 size: 20.sp,
//                 color: AppColors.saltBox600,
//               ),
//               onChanged: (value) {
//                 context.read<ChangePasswordCubit>().oldPasswordChanged(value);
//               },
//               validate: (value) {
//                 final errorText = AppValidators.validateSignInPassword(value);
//                 context
//                     .read<ChangePasswordCubit>()
//                     .oldPasswordErrorTextChanged(errorText ?? "");
//                 return errorText;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _NewPasswordField extends StatelessWidget {
//   const _NewPasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
//       buildWhen: (previous, current) =>
//           previous.newPasswordErrorText != current.newPasswordErrorText,
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("New Password".ts,
//                 style: Theme.of(context).textTheme.kSubheadingRegular),
//             VSpace(7),
//             RPasswordField(
//               errorText: state.newPasswordErrorText,
//               hint: AppStrings.newPassword.ts,
//               prefixIcon: Icon(
//                 MdiIcons.lockOpenVariantOutline,
//                 size: 20.sp,
//                 color: AppColors.saltBox600,
//               ),
//               onChanged: (value) {
//                 context.read<ChangePasswordCubit>().newPasswordChanged(value);
//               },
//               validate: (value) {
//                 final errorText = AppValidators.validateNewPassword(value);
//                 context
//                     .read<ChangePasswordCubit>()
//                     .newPasswordErrorTextChanged(errorText ?? "");
//                 return errorText;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _ConfirmNewPasswordField extends StatelessWidget {
//   const _ConfirmNewPasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
//       buildWhen: (previous, current) =>
//           (previous.confirmPasswordErrorText !=
//               current.confirmPasswordErrorText) ||
//           (previous.newPassword != current.newPassword),
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Confirm New Password".ts,
//                 style: Theme.of(context).textTheme.kSubheadingRegular),
//             VSpace(7),
//             RPasswordField(
//               hint: AppStrings.confirmNewPassword.ts,
//               errorText: state.confirmPasswordErrorText,
//               prefixIcon: Icon(
//                 MdiIcons.lockOpenVariantOutline,
//                 size: 20.sp,
//                 color: AppColors.saltBox600,
//               ),
//               onChanged: (value) {
//                 context
//                     .read<ChangePasswordCubit>()
//                     .confirmPasswordChanged(value);
//               },
//               validate: (value) {
//                 final errorText = AppValidators.validateTwoPasswords(
//                     value, state.newPassword);
//                 context
//                     .read<ChangePasswordCubit>()
//                     .confirmPasswordErrorTextChanged(errorText ?? "");
//                 return errorText;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _ChangePasswordButton extends StatelessWidget {
//   const _ChangePasswordButton({
//     this.isChangePassword = false,
//   });
//   final bool isChangePassword;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
//       buildWhen: (previous, current) =>
//           (previous.isButtonEnabled != current.isButtonEnabled ||
//               previous.isLoading != current.isLoading),
//       builder: (context, state) {
//         return Column(
//           children: [
//             Container(
//               color: AppColors.saltBox50,
//               height: 8.h,
//             ),
//             Container(
//               color: AppColors.baseWhite,
//               child: CustomFilledButton(
//                 titleText: AppStrings.changePassword,
//                 state: CustomState.active,
//                 // ? CustomState.active
//                 // : CustomState.disabled,
//                 loading: state.status == ChangePasswordStatus.loading,
//                 onPressed: isChangePassword == true
//                     ? context.read<ChangePasswordCubit>().changePassword
//                     : context.read<ChangePasswordCubit>().resetPassword,
//                 width: 20000,
//                 height: 50,
//                 radius: 24,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // class _ErrorLine extends StatelessWidget {
// //   const _ErrorLine();

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
// //       buildWhen: (previous, current) => previous.isError != current.isError,
// //       builder: (context, state) {
// //         return (state.isError)
// //             ? Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Icon(
// //                     Icons.error_outline_rounded,
// //                     color: AppColors.error500,
// //                     size: 16,
// //                   ),
// //                   HSpace(4),
// //                   Expanded(
// //                     child: Text(
// //                       state.error!.msg,
// //                       style: Theme.of(context)
// //                           .textTheme
// //                           .kParagraph01Regular
// //                           .copyWith(color: AppColors.error500),
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             : const SizedBox.shrink();
// //       },
// //     );
// //   }
// // }
