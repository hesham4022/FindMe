import 'package:flutter/material.dart';

enum AppLanguage { arabic, english }

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.arabic:
        return 'ar';
    }
  }

  String get name {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.arabic:
        return 'العربية';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.arabic:
        return const Locale('ar');
    }
  }

  static AppLanguage fromCode(String code) {
    switch (code) {
      case 'en':
        return AppLanguage.english;
      case 'ar':
        return AppLanguage.arabic;
      default:
        return AppLanguage.english;
    }
  }
}
