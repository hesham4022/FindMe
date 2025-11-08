import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.image,
    this.icon,
    this.size = 88,
  });

  final String title;
  final String? subtitle;
  final String? image;
  final IconData? icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28).r,
            decoration: BoxDecoration(
              color: AppColors.saltBox100,
              shape: BoxShape.circle,
            ),
            child: image != null
                ? SvgPicture.asset(
                    image!,
                    width: size.sp,
                    height: size.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.saltBox400,
                      BlendMode.srcIn,
                    ),
                  )
                : icon != null
                    ? Icon(
                        icon!,
                        size: size.sp,
                        color: AppColors.saltBox400,
                      )
                    : const SizedBox.shrink(),
          ),
          VSpace(24),
          Text(
            title.ts,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .kParagraph02SemiBold
                .copyWith(color: AppColors.saltBox600),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 8).h,
              child: Text(
                subtitle!.ts,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .kCaptionRegular
                    .copyWith(color: AppColors.saltBox400),
              ),
            ),
        ],
      ),
    );
  }
}
