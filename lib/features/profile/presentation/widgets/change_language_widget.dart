import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/fonts.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/languages.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

kShowChangeLanguageBottomSheet(
  BuildContext context, {
  required AppLanguage initialValue,
  required void Function(AppLanguage) onChanged,
}) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: AppColors.baseWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (_) => _Options(
      initialValue: initialValue,
      onChanged: onChanged,
    ),
  );
}

class _Options extends StatefulWidget {
  const _Options({
    required this.initialValue,
    required this.onChanged,
  });

  final AppLanguage initialValue;
  final void Function(AppLanguage) onChanged;

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
  late AppLanguage _selected;

  @override
  void initState() {
    // Take the initial value or the first value of the list as default
    _selected = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //! title, Close Button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
          height: 56.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.saltBox100,
                width: 2.w,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 32.sp, height: 32.sp),
              Text(
                AppStrings.changeLanguage.ts,
                style: Theme.of(context).textTheme.kParagraph02SemiBold,
              ),
              GestureDetector(
                onTap: context.back,
                child: Container(
                  width: 32.sp,
                  height: 32.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.saltBox100,
                  ),
                  child: const Icon(
                    Icons.close_sharp,
                    size: 18,
                    color: AppColors.saltBox600,
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16).r,
          child: Row(
            children: [
              //! English Button
              GestureDetector(
                onTap: () async {
                  setState(() => _selected = AppLanguage.english);
                  context.setLocale(Locale('en'));
                  widget.onChanged(AppLanguage.english);
                  context.back();
                },
                child: Container(
                  height: 172.5.sp,
                  width: 172.5.sp,
                  decoration: BoxDecoration(
                    color: _selected == AppLanguage.english
                        ? AppColors.daisyBush50
                        : AppColors.baseWhite,
                    borderRadius: BorderRadius.circular(24).r,
                    border: Border.all(
                      color: _selected == AppLanguage.english
                          ? AppColors.daisyBush800
                          : AppColors.saltBox100,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   AppImages.english,
                      //   width: 32.sp,
                      // ),
                      VSpace(12),
                      Text(
                        AppStrings.english,
                        style: Theme.of(context)
                            .textTheme
                            .kParagraph01SemiBold
                            .copyWith(
                              color: _selected == AppLanguage.english
                                  ? AppColors.daisyBush800
                                  : AppColors.saltBox600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              HSpace(16),
              //! Arabic Button
              GestureDetector(
                onTap: () async {
                  setState(() => _selected = AppLanguage.arabic);
                  context.setLocale(Locale('ar'));
                  widget.onChanged(AppLanguage.arabic);
                  context.back();
                },
                child: Container(
                  height: 172.5.sp,
                  width: 172.5.sp,
                  decoration: BoxDecoration(
                    color: _selected == AppLanguage.arabic
                        ? AppColors.daisyBush50
                        : AppColors.baseWhite,
                    borderRadius: BorderRadius.circular(24).r,
                    border: Border.all(
                      color: _selected == AppLanguage.arabic
                          ? AppColors.daisyBush800
                          : AppColors.saltBox100,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   AppImages.arabic,
                      //   width: 32.sp,
                      // ),
                      VSpace(12),
                      Text(
                        "العربية",
                        style: Theme.of(context)
                            .textTheme
                            .kParagraph01Bold
                            .copyWith(
                              fontFamily: AppFonts.arabicFontFamily,
                              color: _selected == AppLanguage.arabic
                                  ? AppColors.daisyBush800
                                  : AppColors.saltBox600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
