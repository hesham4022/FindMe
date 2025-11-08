import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';

extension TranslationExtension on String {
  /// returns translation of
  String get ts => ez.tr(this);
}

extension TranslationListExtension on BuildContext {
  bool get isArabic =>
      ez.EasyLocalization.of(this)?.locale.languageCode == 'ar';

  bool get isEnglish => !isArabic;
}
