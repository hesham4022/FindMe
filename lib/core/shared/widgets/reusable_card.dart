import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/colors.dart';

class MostUsedCard extends StatelessWidget {
  const MostUsedCard({
    super.key,
    required this.child,
    this.showShadow = false,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.color = AppColors.baseWhite,
    this.radius = 10,
    this.topRightRadius = 10,
    this.topLeftRadius = 10,
    this.bottomRightRadius = 10,
    this.bottomLeftRadius = 10,
    this.showBorder = false,
    this.bordercolor = const Color(0xffF0F0F0),
    this.borderThickness = 1,
  });

  final Widget child;
  final bool showShadow;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final bool showBorder;
  final Color bordercolor;
  final double borderThickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.antiAlias,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: showBorder
            ? Border.all(
                color: bordercolor,
                width: borderThickness.w,
              )
            : null,
        borderRadius: radius != null
            ? BorderRadius.circular(radius!).r
            : BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius),
              ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha((0.12 * 255).toInt()),
                  spreadRadius: 0,
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
