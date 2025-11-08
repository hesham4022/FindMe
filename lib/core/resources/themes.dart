import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/fonts.dart';
import 'package:find_me_app/core/resources/languages.dart';

class AppThemes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.baseWhite,
        ),
        fontFamily: context.locale == AppLanguage.arabic.locale
            ? AppFonts.arabicFontFamily
            : AppFonts.englishFontFamily,
        cardColor: Colors.white,
      );
}

extension AppTheme on TextTheme {
  /// 72
  TextStyle get kDisplay01SemiBold => TextStyle(
        fontSize: 72.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 72
  TextStyle get kDisplay01Bold => TextStyle(
        fontSize: 72.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 72
  TextStyle get kDisplay01ExtraBold => TextStyle(
        fontSize: 72.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 60
  TextStyle get kDisplay02SemiBold => TextStyle(
        fontSize: 60.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 60
  TextStyle get kDisplay02Bold => TextStyle(
        fontSize: 60.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 60
  TextStyle get kDisplay02ExtraBold => TextStyle(
        fontSize: 60.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 48
  TextStyle get kHeadingH1SemiBold => TextStyle(
        fontSize: 48.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 48
  TextStyle get kHeadingH1Bold => TextStyle(
        fontSize: 48.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 48
  TextStyle get kHeadingH1ExtraBold => TextStyle(
        fontSize: 48.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 34
  TextStyle get kHeadingH1SmallSemiBold => TextStyle(
        fontSize: 34.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 34
  TextStyle get kHeadingH1SmallBold => TextStyle(
        fontSize: 34.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 48
  TextStyle get kHeadingH1SmallExtraBold => TextStyle(
        fontSize: 48.sp,
        fontWeight: FontWeight.w100,
        color: AppColors.baseBlack,
      );

  /// 39
  TextStyle get kHeadingH2SemiBold => TextStyle(
        fontSize: 39.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 39
  TextStyle get kHeadingH2Bold => TextStyle(
        fontSize: 39.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 39
  TextStyle get kHeadingH2ExtraBold => TextStyle(
        fontSize: 39.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH2SmallSemiBold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH2SmallBold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH2SmallExtraBold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH3SemiBold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH3Bold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 33
  TextStyle get kHeadingH3ExtraBold => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH3SmallSemiBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH3SmallBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH3SmallExtraBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH4SemiBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH4Bold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 28
  TextStyle get kHeadingH4ExtraBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 24
  TextStyle get kHeadingH4SmallSemiBold => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xff1D4ED8),
      );

  /// 24
  TextStyle get kHeadingH4SmallBold => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseWhite,
      );
  TextStyle get kHeadingH4SmallBoldBlack => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.baseBlack,
      );

  /// 23
  TextStyle get kHeadingH4SmallExtraBold => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

//! H5
  /// 23
  TextStyle get kHeadingH5SemiBold => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 23
  TextStyle get kHeadingH5Bold => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 23
  TextStyle get kHeadingH5ExtraBold => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  /// 19
  TextStyle get kHeadingH5SmallSemiBold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 19
  TextStyle get kHeadingH5SmallBold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 19
  TextStyle get kHeadingH5SmallExtraBold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

  //! H6
  /// 19
  TextStyle get kHeadingH6SemiBold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 19
  TextStyle get kHeadingH6Bold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 19
  TextStyle get kHeadingH6ExtraBold => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

//! H6 Small
  /// 16
  TextStyle get kHeadingH6SmallSemiBold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 16
  TextStyle get kHeadingH6SmallBold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

  /// 16
  TextStyle get kHeadingH6SmallExtraBold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.baseBlack,
      );

// -----------------------------------------------------------------------------
  //! Subheading
  /// 20
  TextStyle get kSubheadingRegular => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 20
  TextStyle get kSubheadingSemiBold => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 20
  TextStyle get kSubheadingUnderline => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.baseBlack,
        decoration: TextDecoration.underline,
      );
//------------------------------------------------------------------------------
//! Paragraph 01
  /// 14
  TextStyle get kParagraph01Regular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.baseBlack,
      );

  /// 14
  TextStyle get kParagraph01SemiBold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 14
  TextStyle get kParagraph01Bold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
        decoration: TextDecoration.underline,
      );

//------------------------------------------------------------------------------
//! Paragraph 02
  /// 16
  TextStyle get kParagraph02Regular => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.baseBlack,
      );

  /// 16
  TextStyle get kParagraph02SemiBold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 16
  TextStyle get kParagraph02Bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
        decoration: TextDecoration.underline,
      );

//------------------------------------------------------------------------------
//! Paragraph 03
  /// 18
  TextStyle get kParagraph03Regular => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.baseBlack,
      );

  /// 18
  TextStyle get kParagraph03SemiBold => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 18
  TextStyle get kParagraph03Bold => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
        decoration: TextDecoration.underline,
      );

//----------------------------------------------------------------------------
//! Caption
  /// 12
  TextStyle get kCaptionRegular => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 12
  TextStyle get kCaptionSemiBold => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 12
  TextStyle get kCaptionBold => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );

//----------------------------------------------------------------------------
//! Footer
  /// 10
  TextStyle get kFooterRegular => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.baseBlack,
      );

  /// 10
  TextStyle get kFooterSemiBold => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.baseBlack,
      );

  /// 10
  TextStyle get kFooterBold => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.baseBlack,
      );
}
