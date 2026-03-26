import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SinupOrLogin extends StatelessWidget {
  const SinupOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const VSpace(20),
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/FindMe logo new.svg',
                  width: 139,
                  height: 139,
                ),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.kHeadingH1SmallExtraBold,
                ),
                Text(
                  AppStrings.descriptionApp,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.kCaptionRegular,
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomFilledButton(
                title: Text(
                  AppStrings.login,
                  style: Theme.of(context)
                      .textTheme
                      .kHeadingH4SmallBold
                      .copyWith(fontSize: 22.sp),
                ),
                onPressed: () {
                  context.toNamed(
                    AppRoutes.signinRoute,
                  );
                },
                width: 0.55.sw,
                height: 45.h,
                radius: 30.r,
                color: AppColors.mainColor,
              ),
              const VSpace(20),
              CustomFilledButton(
                title: Text(
                  AppStrings.sinup,
                  style: Theme.of(context)
                      .textTheme
                      .kHeadingH4SmallBold
                      .copyWith(fontSize: 22.sp, color: AppColors.mainColor),
                ),
                onPressed: () {
                  context.toNamed(
                    AppRoutes.signupRoute,
                  );
                },
                width: 0.55.sw,
                height: 45.h,
                radius: 30.r,
                color: AppColors.secondColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
