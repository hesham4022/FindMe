import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({
    super.key,
    this.height,
    this.width,
    this.radius = 5,
  });
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: width == height ? height?.w : height?.h,
          width: width == height ? width?.w : width?.w,
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(radius)).r,
          ),
        ),
      ),
    );
  }
}

class CircleShimmerSkeleton extends StatelessWidget {
  const CircleShimmerSkeleton({
    super.key,
    this.radius,
  });
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: radius?.sp,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
