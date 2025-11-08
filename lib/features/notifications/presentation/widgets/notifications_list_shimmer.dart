import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/shared/widgets/shimmer_skeleton.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

import 'package:find_me_app/core/resources/colors.dart';

class NotificationsListShimmerEffect extends StatelessWidget {
  const NotificationsListShimmerEffect({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30).r,
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (context, _) => const VSpace(25),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.saltBox100,
                  width: 1.w,
                ),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                ShimmerSkeleton(width: 20, height: 20),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerSkeleton(width: 50, height: 20),
                          ShimmerSkeleton(width: 30, height: 20),
                        ],
                      ),
                      SizedBox(height: 5),
                      ShimmerSkeleton(width: 200, height: 20),
                      SizedBox(height: 5),
                      ShimmerSkeleton(width: 270, height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
