import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/animate_widgets_visibilty.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';

enum CustomState { active, inActive, disabled, error }

class CustomFilledButton extends StatelessWidget {
  final String? titleText;
  final Widget? title;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? disabledColor;
  final CustomState state;
  final double radius;
  // final bool enabled;
  final bool loading;
  final bool useArabicFont;
  final String? loadingAnimation;
  final Color? animationColor;
  final Color? textColor;

  const CustomFilledButton({
    super.key,
    this.titleText,
    this.title,
    required this.onPressed,
    this.width,
    this.height,
    // this.enabled = true,
    this.radius = 10,
    this.loading = false,
    this.color,
    this.disabledColor,
    this.state = CustomState.active,
    this.useArabicFont = false,
    this.loadingAnimation,
    this.animationColor = AppColors.baseWhite,
    this.textColor,
  }) : assert(titleText != null || title != null);

  Color get bgColor {
    switch (state) {
      case CustomState.active:
      case CustomState.inActive:
        return color ?? AppColors.mainColor;

      case CustomState.disabled:
        return disabledColor ?? AppColors.saltBox200;

      case CustomState.error:
        return AppColors.error50;
    }
  }

  Color get titleColor {
    switch (state) {
      case CustomState.active:
      case CustomState.inActive:
        return textColor ?? Colors.white;

      case CustomState.disabled:
        return disabledColor != null ? Colors.white : AppColors.saltBox500;

      case CustomState.error:
        return AppColors.error500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        key: Key(titleText ?? "Submit"),
        style: ButtonStyle(
          // elevation: state == CustomState.disabled
          //     ? null
          //     : WidgetStateProperty.all(0.75),
          fixedSize: WidgetStateProperty.all(
              Size(width?.w ?? double.infinity, height?.h ?? 45.h)),
          overlayColor: state == CustomState.disabled
              ? WidgetStateProperty.all(Colors.transparent)
              : null,
          backgroundColor: WidgetStateProperty.all(bgColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius).r,
            ),
          ),
        ),
        onPressed: () {
          if (state != CustomState.disabled) {
            // dismissFocusedWidget(context);
            onPressed?.call();
          }
          // return;
        },
        //! Title
        child: AnimateWidgetsVisiblity(
          firstWidget: CustomButtonLoader(
            lottieAnimation: loadingAnimation,
            color: color,
          ),
          secondWidget: titleText != null
              ? Text(
                  titleText!.ts,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      Theme.of(context).textTheme.kParagraph01SemiBold.copyWith(
                            color: titleColor,
                          ),
                )
              : title!,
          showFirst: loading,
        ),
      ),
    );
  }
}
