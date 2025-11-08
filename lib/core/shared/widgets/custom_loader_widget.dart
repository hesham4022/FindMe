import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/animations.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.height = 115,
    this.width = 115,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AppAnimations.pageLoader,
      width: width.sp,
      height: height.sp,
    );
  }
}

class CustomButtonLoader extends StatelessWidget {
  const CustomButtonLoader({
    super.key,
    this.lottieAnimation,
    this.height = 20,
    this.color,
  });

  final String? lottieAnimation;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      lottieAnimation ?? AppAnimations.whiteLoader,
      repeat: true,
      fit: BoxFit.contain,
      height: height.h,
      // delegates: LottieDelegates(
      //   values: [
      //     // Replace with the color key in your JSON file
      //     ValueDelegate.color(
      //       const ['**'], // Apply to all color layers in the animation
      //       value: color, // Replace with your desired color
      //     ),
      //   ],
      // ),
    );
  }
}
