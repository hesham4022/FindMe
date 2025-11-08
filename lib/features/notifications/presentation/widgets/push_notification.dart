import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showPushNotification(
  BuildContext context,
  String title,
  String message,
  Function onTap,
) {
  showTopSnackBar(
    Overlay.of(context),
    padding: const EdgeInsets.all(10).r,
    animationDuration: const Duration(seconds: 1),
    displayDuration: const Duration(seconds: 2),
    reverseAnimationDuration: const Duration(seconds: 1),
    curve: Curves.easeOutCirc,
    reverseCurve: Curves.easeOutCirc,
    onTap: () {
      onTap();
    },
    Material(
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(10).r,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.daisyBush100,
          ),
          borderRadius: BorderRadius.circular(10).r,
          color: Colors.white,
        ),
        child: Row(
          children: [
            // logo
            // SvgPicture.asset(
            //   AppImages.appIcon,
            //   width: 28.w,
            //   height: 28.w,
            // ),
            const HSpace(8),
            // title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.kParagraph01SemiBold,
                  ),
                  const VSpace(5),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.kParagraph01Regular,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
