import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/notifications/presentation/widgets/notification_btn.dart';

class HostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HostAppBar({
    super.key,
    this.showLogo = true,
  });

  final bool showLogo;

  double get height => 46.h;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      height: 46,
      overlayColor: AppColors.baseWhite,
      background: AppColors.baseWhite,
      elevation: 0,

      //TODO: Change to be company logo
      // title: SvgPicture.asset(
      //   // AppImages.appLogo,
      //   // height: 23.h,
      // ),
      actions: [
        //TODO: Implement notification
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: NotificationBtn(),
        )
      ],

      title: Row(
        children: [
          HSpace(10),
          Column(
            children: [
              Image.asset(
                "assets/images/Mask group.png",
                width: 52,
                height: 52,
              ),
            ],
          ),
          HSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi welcome",
                  style:
                      Theme.of(context).textTheme.kHeadingH5SemiBold.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff4B5563),
                          )),
              Text("Hesham",
                  style:
                      Theme.of(context).textTheme.kHeadingH5SemiBold.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4B5563),
                          )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
