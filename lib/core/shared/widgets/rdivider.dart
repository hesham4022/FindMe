import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:find_me_app/core/resources/colors.dart';

class RDivider extends StatelessWidget {
  const RDivider({
    super.key,
    this.padding,
    this.thickness = 1.0,
    this.color = AppColors.saltBox100,
  });

  final EdgeInsetsGeometry? padding;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10).h,
      child: Divider(
        color: color,
        thickness: thickness.h,
        height: thickness.h,
      ),
    );
  }
}
