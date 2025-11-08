// ignore_for_file: always_put_control_body_on_new_line

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/pages/signin.dart';

class ExceptionHandler {
  ExceptionHandler();
  // Future<void> _handleTokenFailure(
  //   BuildContext context,
  //   AuthLocal localSource,
  // ) async {
  //   await localSource.clearAllCache();

  //   // Check if context is still valid
  //   if (!context.mounted) return;

  //   // // Optional: avoid showing if already on signin screen
  //   // final isOnSignInScreen = ModalRoute.of(context)?.settings.name == SigninView.routeName;
  //   //
  //   // if (isOnSignInScreen) {
  //   //   return; // Already on signin, skip dialog
  //   // }

  //   // Show the dialog immediately (no post frame), using valid context
  //   kShowAlertCard(
  //     context: context,
  //     title: AppStrings.tokenInValid.ts,
  //     icon: Container(
  //       padding: EdgeInsets.all(22).r,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: AppColors.error50,
  //       ),
  //       child: Icon(
  //         Icons.warning_amber_rounded,
  //         size: 44.sp,
  //         color: AppColors.error500,
  //       ),
  //     ),
  //     buttons: CustomFilledButton(
  //       titleText: AppStrings.continuee,
  //       onPressed: () async {
  //         try {
  //           await sl<AuthLocal>().deleteAuthedUser();

  //           if (!context.mounted) return;

  //           context.read<SignInCubit>().loadCachedBaseUrlResponse();

  //           if (!context.mounted) return;

  //           // Navigate to Signin and remove all previous routes
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SigninView(),
  //             ),
  //             (route) => false,
  //           );
  //         } catch (e) {
  //           log(e.toString());
  //           // Navigate to Signin and remove all previous routes
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SigninView(),
  //             ),
  //             (route) => false,
  //           );
  //         }
  //       },
  //       width: 200,
  //       height: 40,
  //     ),
  //   );
  // }

  //
  // Future<void> _handleTokenFailure(
  //     BuildContext context,
  //     AuthLocal localSource,
  //     ) async {
  //   await localSource.clearAllCache();
  //
  //   // Check if the current route is already SigninView
  //   // final isOnSignInScreen = ModalRoute.of(context)?.settings.name == AppRoutes.signinRoute;
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     kShowAlertCard(
  //       context: context,
  //       title: AppStrings.tokenInValid.ts,
  //       icon: Container(
  //         padding: EdgeInsets.all(22).r,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: AppColors.error50,
  //         ),
  //         child: Icon(
  //           Icons.warning_amber_rounded,
  //           size: 44.sp,
  //           color: AppColors.error500,
  //         ),
  //       ),
  //       buttons: CustomFilledButton(
  //         titleText: AppStrings.continuee,
  //         onPressed: () async {
  //
  //
  //         await sl<AuthLocal>().deleteAuthedUser();
  //
  //           if (context.mounted) {
  //             context.read<SignInCubit>().loadCachedBaseUrlResponse();
  //           }
  //
  //           if (context.mounted) {
  //             Navigator.pop(context);
  //             Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SigninView(
  //                   companyName: context.isArabic
  //                       ? context.watch<SignInCubit>().getBaseUrlInstance()?.nameA
  //                       : context.watch<SignInCubit>().getBaseUrlInstance()?.nameL,
  //                 ),
  //               ),
  //                   (route) => false,
  //             );
  //           }
  //         },
  //         width: 200,
  //         height: 40,
  //       ),
  //     );
  //   });
  //   // if (isOnSignInScreen) {
  //   //   Navigator.pop(context);
  //   //   return;
  //   // }else {
  //   //
  //   // }
  // }

  // Future<Widget?> handleErrors(BuildContext context, Failure failure,
  //     {Widget? specificWidget}) async {
  //   //! Token Failure
  //   // if (failure is UserTokenFailure) {
  //   //   _handleTokenFailure(context, sl());
  //   //   return const SizedBox.shrink();
  //   // }

  //   return specificWidget;
  // }
}
