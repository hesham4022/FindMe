import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({
    super.key,
    this.showLogo = true,
    required this.title,
  });

  final String title;
  final bool showLogo;
  double get height => 46;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      height: height,
      background: AppColors.baseWhite,
      overlayColor: AppColors.baseWhite,
      elevation: 0.3,
      titleText: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

//--------------------------- Auth Header---------------------------------------
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 78.68).h,
      child: Column(
        children: [
          // SvgPicture.asset(
          //   AppImages.appLogo,
          //   width: 169.w,
          //   height: 41.65.h,
          // ),
        ],
      ),
    );
  }
}
