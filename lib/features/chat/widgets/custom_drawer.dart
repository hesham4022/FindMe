// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/helpers/extensions/context.dart';
// import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
// import 'package:find_me_app/core/resources/colors.dart';
// import 'package:find_me_app/core/resources/images.dart';
// import 'package:find_me_app/core/resources/languages.dart';
// import 'package:find_me_app/core/resources/routes.dart';
// import 'package:find_me_app/core/resources/strings.dart';
// import 'package:find_me_app/core/resources/themes.dart';
// import 'package:find_me_app/core/shared/widgets/alerts.dart';
// import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
// import 'package:find_me_app/core/shared/widgets/custom_network_img.dart';
// import 'package:find_me_app/core/shared/widgets/rdivider.dart';
// import 'package:find_me_app/core/shared/widgets/sizes.dart';
// import 'package:find_me_app/features/app/data/source/app_local.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
// import 'package:find_me_app/features/auth/presentation/pages/signin.dart';
// import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
// import 'package:find_me_app/features/profile/presentation/widgets/change_language_widget.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.baseWhite,
//       shape: const RoundedRectangleBorder(),
//       child: BlocProvider(
//         create: (_) => HostCubit(0, sl())..getUserData(),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 48).r,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 //! Back Button
//                 InkWell(
//                   onTap: () => unawaited(context.back()),
//                   child: Icon(
//                     Icons.arrow_back_rounded,
//                     color: Colors.black,
//                     size: 24.sp,
//                   ),
//                 ),
//                 VSpace(15),
//                 //! Header
//                 BlocBuilder<HostCubit, HostState>(
//                   buildWhen: (p, c) => p.userData != c.userData,
//                   builder: (context, state) {
//                     final userData = state.userData;
//                     return ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       horizontalTitleGap: 12.w,
//                       leading: CustomNetworkImage(
//                         isCircle: true,
//                         width: 48,
//                         height: 48,
//                         image: userData.image,
//                         placeholder: Icons.account_circle_rounded,
//                       ),
//                       title: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             context.isArabic
//                                 ? userData.fullNameAr ?? userData.fullName ?? ""
//                                 : userData.fullNameEn ?? "",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .kParagraph01SemiBold,
//                           ),
//                           // const VSpace(4),
//                           // if (userData.email != null)
//                           //   Text(
//                           //     userData.email!,
//                           //     style: Theme.of(context)
//                           //         .textTheme
//                           //         .kCaptionRegular
//                           //         .copyWith(color: AppColors.saltBox700),
//                           //   ),
//                           const VSpace(4),
//                           if (userData.usrId != null)
//                             Text(
//                               "ID: ${userData.usrId}",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .kFooterBold
//                                   .copyWith(color: AppColors.saltBox500),
//                             ),
//                         ],
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         color: AppColors.saltBox300,
//                         size: 14.sp,
//                       ),
//                       onTap: () => context.toNamed(AppRoutes.profileRoute,
//                           arguments: {'isPersonal': true}),
//                     );
//                   },
//                 ),
//                 RDivider(
//                   padding: EdgeInsets.only(top: 12, bottom: 12).h,
//                 ),

//                 //! Change Password
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   minLeadingWidth: 0,
//                   horizontalTitleGap: 12.w,
//                   dense: true,
//                   // leading: SvgPicture.asset(
//                   //   AppImages.changePassword,
//                   //   width: 24.sp,
//                   //   height: 24.sp,
//                   //   colorFilter: const ColorFilter.mode(
//                   //     AppColors.saltBox600,
//                   //     BlendMode.srcIn,
//                   //   ),
//                   // ),
//                   title: Text(
//                     AppStrings.changePassword.ts,
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.saltBox900),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: AppColors.saltBox300,
//                     size: 14.sp,
//                   ),
//                   onTap: () => context.toNamed(AppRoutes.changePasswordRoute,
//                       arguments: true),
//                 ),
//                 //! Change Language
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   minLeadingWidth: 0,
//                   horizontalTitleGap: 12.w,
//                   dense: true,
//                   // leading: SvgPicture.asset(
//                   //   AppImages.translate,
//                   //   width: 24.sp,
//                   //   height: 24.sp,
//                   //   colorFilter: const ColorFilter.mode(
//                   //     AppColors.saltBox600,
//                   //     BlendMode.srcIn,
//                   //   ),
//                   // ),
//                   title: Text(
//                     AppStrings.changeLanguage.ts,
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.saltBox900),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: AppColors.saltBox300,
//                     size: 14.sp,
//                   ),
//                   onTap: () => kShowChangeLanguageBottomSheet(
//                     context,
//                     initialValue: context.locale.languageCode == "en"
//                         ? AppLanguage.english
//                         : AppLanguage.arabic,
//                     onChanged: (value) async =>
//                         sl<AppLocal>().cacheLanguage(value),
//                   ),
//                 ),
//                 //TODO: Not Implemented
//                 //! What's New
//                 // ListTile(
//                 //   contentPadding: EdgeInsets.zero,
//                 //   minLeadingWidth: 0,
//                 //   horizontalTitleGap: 12.w,
//                 //   dense: true,
//                 //   leading: SvgPicture.asset(
//                 //     AppImages.whatsNew,
//                 //     width: 24.sp,
//                 //     height: 24.sp,
//                 //     colorFilter: const ColorFilter.mode(
//                 //       AppColors.saltBox600,
//                 //       BlendMode.srcIn,
//                 //     ),
//                 //   ),
//                 //   title: Text(
//                 //     AppStrings.whatsNew.ts,
//                 //     style: Theme.of(context)
//                 //         .textTheme
//                 //         .kParagraph01SemiBold
//                 //         .copyWith(color: AppColors.saltBox900),
//                 //   ),
//                 //   trailing: Icon(
//                 //     Icons.arrow_forward_ios_rounded,
//                 //     color: AppColors.saltBox300,
//                 //     size: 14.sp,
//                 //   ),
//                 //   onTap: () {
//                 //     //TODO:
//                 //   },
//                 // ),
//                 //! History
//                 // ListTile(
//                 //   contentPadding: EdgeInsets.zero,
//                 //   minLeadingWidth: 0,
//                 //   horizontalTitleGap: 12.w,
//                 //   dense: true,
//                 //   leading: SvgPicture.asset(
//                 //     AppImages.history,
//                 //     width: 24.sp,
//                 //     height: 24.sp,
//                 //     colorFilter: const ColorFilter.mode(
//                 //       AppColors.saltBox600,
//                 //       BlendMode.srcIn,
//                 //     ),
//                 //   ),
//                 //   title: Text(
//                 //     AppStrings.acknowledgeHistory.ts,
//                 //     style: Theme.of(context)
//                 //         .textTheme
//                 //         .kParagraph01SemiBold
//                 //         .copyWith(color: AppColors.saltBox900),
//                 //   ),
//                 //   trailing: Icon(
//                 //     Icons.arrow_forward_ios_rounded,
//                 //     color: AppColors.saltBox300,
//                 //     size: 14.sp,
//                 //   ),
//                 //   onTap: () =>
//                 //       context.toNamed(AppRoutes.acknowledgementHistoryRoute),
//                 // ),
//                 // //! Settings
//                 // ListTile(
//                 //   contentPadding: EdgeInsets.zero,
//                 //   minLeadingWidth: 0,
//                 //   horizontalTitleGap: 12.w,
//                 //   dense: true,
//                 //   leading: SvgPicture.asset(
//                 //     AppImages.settings,
//                 //     width: 24.sp,
//                 //     height: 24.sp,
//                 //     colorFilter: const ColorFilter.mode(
//                 //       AppColors.saltBox600,
//                 //       BlendMode.srcIn,
//                 //     ),
//                 //   ),
//                 //   title: Text(
//                 //     AppStrings.settings.ts,
//                 //     style: Theme.of(context)
//                 //         .textTheme
//                 //         .kParagraph01SemiBold
//                 //         .copyWith(color: AppColors.saltBox900),
//                 //   ),
//                 //   trailing: Icon(
//                 //     Icons.arrow_forward_ios_rounded,
//                 //     color: AppColors.saltBox300,
//                 //     size: 14.sp,
//                 //   ),
//                 //   onTap: () => context.toNamed(AppRoutes.settingsRoute),
//                 // ),

//                 // Expanded(child: SizedBox()),
//                 Spacer(),

//                 //! Log out
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   minLeadingWidth: 0,
//                   horizontalTitleGap: 12.w,
//                   dense: true,
//                   // leading: SvgPicture.asset(
//                   //   AppImages.logout,
//                   //   width: 24.sp,
//                   //   height: 24.sp,
//                   //   colorFilter: const ColorFilter.mode(
//                   //     AppColors.error500,
//                   //     BlendMode.srcIn,
//                   //   ),
//                   // ),
//                   title: Text(
//                     AppStrings.logout.ts,
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.error500),
//                   ),
//                   onTap: () async {
//                     kShowAlertCard(
//                       context: context,
//                       title: AppStrings.logoutTitle.ts,
//                       subtitle: AppStrings.logoutTMessage.ts,
//                       icon: Container(
//                         padding: const EdgeInsets.all(22).r,
//                         decoration: BoxDecoration(
//                           color: AppColors.error50,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.logout_rounded,
//                           color: AppColors.error500,
//                           size: 44.sp,
//                         ),
//                       ),
//                       buttons: Row(
//                         children: [
//                           //! Cancel Button
//                           CustomFilledButton(
//                             color: AppColors.saltBox100,
//                             title: Text(
//                               AppStrings.noCancel.ts,
//                               strutStyle: StrutStyle(forceStrutHeight: true),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .kParagraph01Regular
//                                   .copyWith(color: AppColors.saltBox600),
//                             ),
//                             onPressed: () => context.back(),
//                             width: 146.5,
//                             height: 42,
//                           ),
//                           HSpace(12),
//                           //! Signout Button
//                           CustomFilledButton(
//                             color: AppColors.error500,
//                             title: Text(
//                               AppStrings.yesSignOut.ts,
//                               strutStyle: StrutStyle(forceStrutHeight: true),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .kParagraph01Regular
//                                   .copyWith(color: AppColors.baseWhite),
//                             ),
//                             onPressed: () async {
//                               context.back();
//                               context.read<HostCubit>().logout();
//                               await context
//                                   .read<SignInCubit>()
//                                   .loadCachedBaseUrlResponse();
//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SigninView(),
//                                 ),
//                                 (route) =>
//                                     false, // This removes all previous routes
//                               );

//                               // context.offAllNamed(AppRoutes.signinRoute, arguments: context.read<SignInCubit>().baseUrlInstance?.nameA);
//                             },
//                             width: 146.5,
//                             height: 42,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
