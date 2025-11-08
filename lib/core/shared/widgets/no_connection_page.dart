import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.baseWhite,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24).r,
            ),
            padding: const EdgeInsets.all(24).r,
            margin: const EdgeInsets.all(20).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22).r,
                  decoration: BoxDecoration(
                    color: AppColors.saltBox50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    color: AppColors.saltBox400,
                    size: 44.sp,
                  ),
                ),
                const VSpace(20),
                Text(
                  AppStrings.noInternetTitle.ts,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.kSubheadingSemiBold,
                ),
                const VSpace(8),
                Text(
                  AppStrings.noInternetConnectionMessage.ts,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.kCaptionRegular,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
