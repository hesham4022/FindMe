import 'package:find_me_app/core/resources/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CircleIconAppbar extends StatelessWidget {
  CircleIconAppbar({super.key, required this.asset, this.onTap});
  final String asset;
  final double circle = 40.w;
  final double iconSize = 18.w;
  final double marginRight = 12.w;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: circle,
        height: circle,
        margin: EdgeInsets.only(right: marginRight),
        decoration: const BoxDecoration(
          color: AppColors.secondColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
