import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/animations.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:lottie/lottie.dart';

import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/fonts.dart';
import 'package:find_me_app/core/shared/widgets/animate_widgets_visibilty.dart';
import 'package:find_me_app/core/shared/widgets/dismiss_keyboard.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? titleText;
  final Widget? title;
  final Function() onPressed;
  final double width;
  final double height;
  final Color? color;
  final CustomState state;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double radius;
  final double? fontSize;
  final double borderWidth;
  final bool useArabicFont;
  final bool enabled;
  final bool loading;

  const CustomOutlinedButton({
    super.key,
    this.titleText,
    this.title,
    required this.onPressed,
    required this.width,
    this.color = AppColors.daisyBush800,
    required this.height,
    required this.state,
    this.trailingIcon,
    this.leadingIcon,
    this.radius = 10,
    this.fontSize,
    this.borderWidth = 1,
    this.useArabicFont = false,
    this.enabled = true,
    this.loading = false,
  }) : assert(titleText != null || title != null);

  Color get borderColor {
    switch (state) {
      case CustomState.active:
      case CustomState.inActive:
        return AppColors.daisyBush800;

      case CustomState.disabled:
        return AppColors.saltBox200;

      case CustomState.error:
        return AppColors.error500;
    }
  }

  Color get titleColor {
    switch (state) {
      case CustomState.active:
      case CustomState.inActive:
        return Colors.white;

      case CustomState.disabled:
        return AppColors.saltBox200;

      case CustomState.error:
        return AppColors.error500;
    }
  }

  Color get indicatorColor {
    switch (state) {
      case CustomState.active:
      case CustomState.inActive:
        return Colors.white;

      case CustomState.disabled:
        return AppColors.saltBox200;

      case CustomState.error:
        return AppColors.error500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(width.w, height.h)),
        side: WidgetStateProperty.all(BorderSide(
          color: borderColor,
          width: borderWidth,
        )),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius).r,
          ),
        ),
      ),
      onPressed: () {
        if (state != CustomState.disabled) {
          dismissFocusedWidget(context);
          onPressed.call();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 2.5).w,
              child: Icon(
                leadingIcon,
                color: borderColor,
                size: 20.w,
              ),
            )
          else
            const SizedBox.shrink(),
          Center(
            child: AnimateWidgetsVisiblity(
              firstWidget: LottieBuilder.asset(
                AppAnimations.whiteLoader,
                repeat: true,
                fit: BoxFit.contain,
                height: 20.h,
              ),
              secondWidget: title ??
                  Text(
                    titleText!,
                    maxLines: 1,
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .kParagraph01SemiBold
                        .copyWith(
                          fontSize: fontSize?.sp,
                          color: color ?? titleColor,
                          fontFamily:
                              useArabicFont ? AppFonts.arabicFontFamily : null,
                        ),
                  ),
              showFirst: loading,
            ),
          ),
          //
          if (trailingIcon != null)
            Padding(
              padding: const EdgeInsets.only(left: 2.5).w,
              child: Icon(
                trailingIcon,
                color: borderColor,
                size: 20.w,
              ),
            ),
        ],
      ),
    );
  }
}
