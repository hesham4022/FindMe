import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_network_img.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class TopPart extends StatelessWidget {
  const TopPart({
    super.key,
    required this.imgURL,
    required this.name,
    required this.profession,
    required this.id,
    required this.directManager,
  });

  final String? imgURL;
  final String? name;
  final String? profession;
  final int? id;
  final String? directManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.baseWhite,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24).h,
      child: Column(
        children: [
          CustomNetworkImage(
            image: imgURL,
            isCircle: true,
            width: 120,
            height: 120,
            placeholder: Icons.account_circle_rounded,
          ),
          const VSpace(10),
          if (name != null)
            Text(
              name!,
              style: Theme.of(context).textTheme.kSubheadingSemiBold,
            ),
          if (profession != null)
            Text(
              profession!,
              style: Theme.of(context)
                  .textTheme
                  .kCaptionRegular
                  .copyWith(color: AppColors.saltBox700),
            ),
          const VSpace(20),
          Container(
            padding: const EdgeInsets.all(16).r,
            decoration: BoxDecoration(
              color: AppColors.saltBox50,
              borderRadius: BorderRadius.circular(16).r,
              border: Border.all(color: AppColors.saltBox100, width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! id
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SvgPicture.asset(
                      //   AppImages.id,
                      //   // width: 24.sp,
                      //   height: 20.sp,
                      //   colorFilter: const ColorFilter.mode(
                      //     AppColors.saltBox600,
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                      const VSpace(8),
                      Text(
                        AppStrings.id.tr().toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .kFooterBold
                            .copyWith(color: AppColors.saltBox500),
                      ),
                      const VSpace(4),
                      Text(
                        id?.toString() ?? "",
                        style: Theme.of(context).textTheme.kParagraph01SemiBold,
                      ),
                    ],
                  ),
                ),
                //! Divider
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16).w,
                  height: 16.h,
                  width: 1.w,
                  color: AppColors.saltBox200,
                ),
                //! Direct Manager
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SvgPicture.asset(
                      //   AppImages.directManager,
                      //   // width: 24.sp,
                      //   height: 17.sp,
                      //   colorFilter: const ColorFilter.mode(
                      //     AppColors.saltBox600,
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                      const VSpace(8),
                      Text(
                        AppStrings.directManager.tr().toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .kFooterBold
                            .copyWith(color: AppColors.saltBox500),
                      ),
                      const VSpace(4),
                      Text(
                        directManager ?? "",
                        style: Theme.of(context).textTheme.kParagraph01SemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
