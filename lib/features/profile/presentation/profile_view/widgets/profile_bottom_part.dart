import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/profile/data/model/user_profile_model.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({
    super.key,
    required this.profileData,
  });

  final UserProfileModel profileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Personal Info
        ListTile(
          tileColor: AppColors.baseWhite,
          contentPadding: EdgeInsets.symmetric(horizontal: 20).w,
          horizontalTitleGap: 8.w,
          // leading: SvgPicture.asset(
          //   AppImages.personalInfo,
          //   width: 24.sp,
          //   height: 24.sp,
          //   colorFilter: const ColorFilter.mode(
          //     AppColors.saltBox600,
          //     BlendMode.srcIn,
          //   ),
          // ),
          title: Text(
            AppStrings.personalInfo.tr(),
            style: Theme.of(context).textTheme.kParagraph01SemiBold,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.saltBox300,
            size: 14.sp,
          ),
          onTap: () => context.toNamed(
            AppRoutes.personalInfoRoute,
            arguments: profileData,
          ),
        ),
        //! Financial Info
        ListTile(
          tileColor: AppColors.baseWhite,
          contentPadding: EdgeInsets.symmetric(horizontal: 20).w,
          horizontalTitleGap: 8.w,
          // leading: SvgPicture.asset(
          //   AppImages.financialInfo,
          //   width: 24.sp,
          //   height: 24.sp,
          //   colorFilter: const ColorFilter.mode(
          //     AppColors.saltBox600,
          //     BlendMode.srcIn,
          //   ),
          // ),
          title: Text(
            AppStrings.financialInfo.tr(),
            style: Theme.of(context).textTheme.kParagraph01SemiBold,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.saltBox300,
            size: 14.sp,
          ),
          onTap: () => context.toNamed(
            AppRoutes.financialInfoRoute,
            arguments: profileData,
          ),
        ),
        //! Employment Info
        ListTile(
          tileColor: AppColors.baseWhite,
          contentPadding: EdgeInsets.symmetric(horizontal: 20).w,
          horizontalTitleGap: 8.w,
          // leading: SvgPicture.asset(
          //   AppImages.employmentInfo,
          //   width: 24.sp,
          //   height: 24.sp,
          //   colorFilter: const ColorFilter.mode(
          //     AppColors.saltBox600,
          //     BlendMode.srcIn,
          //   ),
          // ),
          title: Text(
            AppStrings.employmentInfo.tr(),
            style: Theme.of(context).textTheme.kParagraph01SemiBold,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.saltBox300,
            size: 14.sp,
          ),
          onTap: () => context.toNamed(
            AppRoutes.employmentInfoRoute,
            arguments: profileData,
          ),
        ),
      ],
    );
  }
}
