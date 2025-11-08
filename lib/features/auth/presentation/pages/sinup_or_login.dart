import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';
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
                  placeholderBuilder: (context) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
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
                  style: Theme.of(context).textTheme.kHeadingH4SmallBold,
                ),
                // state:
                // state.isButtonEnabled ? CustomState.active : CustomState.disabled,
                // loading: state.isLoading || state.isTokenIsLoading,
                //"context.read<SignInCubit>().submitSignIn"
                onPressed: () {
                  context.toNamed(
                    AppRoutes.signinRoute,
                  );
                },
                width: 207,
                height: 45,
                radius: 30,
                color: AppColors.mainColor,
              ),
              const VSpace(20),
              CustomFilledButton(
                title: Text(
                  AppStrings.sinup,
                  style: Theme.of(context).textTheme.kHeadingH4SmallSemiBold,
                ),
                // state:
                // state.isButtonEnabled ? CustomState.active : CustomState.disabled,
                // loading: state.isLoading || state.isTokenIsLoading,
                //"context.read<SignInCubit>().submitSignIn"
                onPressed: () {
                  context.toNamed(
                    AppRoutes.signupRoute,
                  );
                },
                width: 207,
                height: 45,
                radius: 30,
                color: const Color(0xffCAD6FF),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
