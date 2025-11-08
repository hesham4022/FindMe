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
      //    AppImages.appLogo,
      //   height: 23.h,
      // ),
      actions: [
        GestureDetector(
          onTap: () async {
            // kAttendanceManagementBottomSheet(context);
          },
          child: Icon(
            Icons.fingerprint,
            color: AppColors.saltBox950,
            size: 24.sp,
          ),
        ),

        //TODO: Implement notification
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: NotificationBtn(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
