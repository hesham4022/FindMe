import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final TextStyle? style;
  final Color? overlayColor;
  final double? elevation;
  final LinearGradient? gradientBG;
  final double height;
  final double? leadingWidth;
  final Color background;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.actions,
    this.leading,
    this.title,
    this.style,
    this.leadingWidth,
    this.gradientBG,
    this.overlayColor = Colors.white,
    this.elevation = 0.75,
    this.bottom,
    this.flexibleSpace,
    this.height = 60,
    this.background = Colors.white,
    this.centerTitle = true,
    this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.kParagraph03SemiBold.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.black,
        );
    final effectiveStyle = baseStyle.merge(style);
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0, // 👈 في Material 3
      backgroundColor: background,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: overlayColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: effectiveStyle,
      toolbarTextStyle: effectiveStyle,
      foregroundColor: Colors.black,
      // elevation: elevation?.sp,
      centerTitle: centerTitle,
      toolbarHeight: height.h,
      titleSpacing: 0,
      leadingWidth: leadingWidth ?? 50.w,
      actions: actions,
      title: title ??
          Text(
            titleText?.ts ?? "",
            style: effectiveStyle, // نسيبها برضه جوّه الـ Text
          ),
      // bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(1),
      //     child: Container(
      //       height: 1.h,
      //       color: AppColors.saltBox100,
      //     )),
      flexibleSpace: flexibleSpace,
      leading: leading ??
          (Navigator.canPop(context)
              ? IconButton(
                  onPressed: () async => context.back(),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.mainColor,
                      size: 26.sp,
                    ),
                  ),
                )
              : null),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
