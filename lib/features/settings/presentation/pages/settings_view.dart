import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/delete_account/delete_account_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/delete_account/delete_account_listener.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/menu_Item_widget.dart';
import 'package:find_me_app/features/settings/presentation/pages/widgets/delete_account_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        hideBackButton: true,
        height: 46,
        background: Colors.white,
        titleText: AppStrings.settings,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => DeleteAccountCubit(sl()),
        child: const _PersonalInfoBody(),
      ),
    );
  }
}

class _PersonalInfoBody extends StatelessWidget {
  const _PersonalInfoBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: deleteAccountListener,
      child: ListView(
        // padding: const EdgeInsets.only(top: 8, bottom: 20).h,
        children: [
          VSpace(30),
          MenuItemWidget(
            isContainer: false,
            icon: Icons.lightbulb_outlined,
            title: "Notification Setting",
            onTap: () {
              context.toNamed(AppRoutes.notificationSettingRoute);
            },
          ),
          VSpace(10),
          MenuItemWidget(
            isContainer: false,
            icon: Icons.key,
            title: "Password Manager",
            onTap: () {
              context.toNamed(AppRoutes.changePasswordRoute);
            },
          ),
          VSpace(10),
          MenuItemWidget(
            isContainer: false,
            icon: Icons.person_outlined,
            title: "Delete Account",
            onTap: () {
              DeleteAcountDialog.show(
                context,
                onConfirm: () {
                  context.read<DeleteAccountCubit>().deleteAccount();
                },
              );
            },
          ),
          VSpace(10),
          MenuItemWidget(
            isContainer: false,
            icon: Icons.public_rounded,
            title: "Change Language",
            onTap: () {
              context.locale.languageCode == 'en'
                  ? context.setLocale(Locale('ar'))
                  : context.setLocale(Locale('en'));
            },
          ),

          // _General(),
          // const _Supportive(),
        ],
      ),
    );
  }
}

// class _General extends StatelessWidget {
//   const _General();

//   @override
//   Widget build(BuildContext context) {
//     return InfoList(
//       title: AppStrings.general,
//       tileHeight: 63,
//       padding: EdgeInsets.zero,
//       separator: Container(
//         color: AppColors.saltBox50,
//         height: 2.h,
//       ),
//       children: [
//         InfoTileModel(
//           leading: Icon(
//             MdiIcons.keyOutline,
//             color: AppColors.saltBox800,
//             size: 24.sp,
//           ),
//           title: Text(
//             AppStrings.permissions.ts,
//             strutStyle: const StrutStyle(forceStrutHeight: true),
//             style: Theme.of(context)
//                 .textTheme
//                 .kParagraph02SemiBold
//                 .copyWith(color: AppColors.saltBox950),
//           ),
//           trailing: CupertinoSwitch(
//             activeTrackColor: AppColors.mainColor,
//             value: true,
//             onChanged: (value) {
//               //TODO: implement
//             },
//           ),
//         ),
//         InfoTileModel(
//           leading: Icon(
//             Icons.notifications_active_outlined,
//             color: AppColors.saltBox800,
//             size: 24.sp,
//           ),
//           title: Text(
//             AppStrings.pushNotifications.ts,
//             strutStyle: const StrutStyle(forceStrutHeight: true),
//             style: Theme.of(context)
//                 .textTheme
//                 .kParagraph02SemiBold
//                 .copyWith(color: AppColors.saltBox950),
//           ),
//           trailing: CupertinoSwitch(
//             value: false,
//             onChanged: (value) {
//               //TODO: implement
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _Supportive extends StatelessWidget {
//   const _Supportive();

//   @override
//   Widget build(BuildContext context) {
//     return InfoList(
//       title: AppStrings.supportive,
//       tileHeight: 63,
//       padding: EdgeInsets.zero,
//       separator: Container(
//         color: AppColors.saltBox50,
//         height: 2.h,
//       ),
//       children: [
//         InfoTileModel(
//           leading: Icon(
//             Icons.info_outlined,
//             color: AppColors.saltBox800,
//             size: 24.sp,
//           ),
//           title: Text(
//             AppStrings.aboutApp.ts,
//             strutStyle: const StrutStyle(forceStrutHeight: true),
//             style: Theme.of(context)
//                 .textTheme
//                 .kParagraph02SemiBold
//                 .copyWith(color: AppColors.saltBox950),
//           ),
//         ),
//         InfoTileModel(
//           leading: Icon(
//             Icons.comment_outlined,
//             color: AppColors.saltBox800,
//             size: 24.sp,
//           ),
//           title: Text(
//             AppStrings.sendFeedback.ts,
//             strutStyle: const StrutStyle(forceStrutHeight: true),
//             style: Theme.of(context)
//                 .textTheme
//                 .kParagraph02SemiBold
//                 .copyWith(color: AppColors.saltBox950),
//           ),
//         ),
//       ],
//     );
//   }
// }
