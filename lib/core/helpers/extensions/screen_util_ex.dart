import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveUtils on num {
  /// equivalent to ScreenUtil().scaleWidth
  double get scW => this * ScreenUtil().scaleWidth;

  /// equivalent to ScreenUtil().scaleHeight
  double get scH => this * ScreenUtil().scaleHeight;

  /// equivalent to ScreenUtil().pixelRatio
  double get pr => this * (ScreenUtil().pixelRatio ?? 1);
}

extension SizedBoxExtension on SizedBox {
  /// Get SizedBox with height and width in pixels
  SizedBox get px => copyWith(
        height: height?.h,
        width: width?.w,
        child: child,
      );

  copyWith({
    Key? key,
    Widget? child,
    double? width,
    double? height,
  }) =>
      SizedBox(
        key: key ?? this.key,
        width: width ?? this.width,
        height: height ?? this.height,
        child: child ?? this.child,
      );
}
