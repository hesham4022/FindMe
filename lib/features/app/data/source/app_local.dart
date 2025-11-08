import 'package:find_me_app/core/resources/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:find_me_app/core/networking/api_constants.dart';

class AppLocal {
  final SharedPreferences sharedPrefs;

  AppLocal(
    this.sharedPrefs,
  );

// LANGUAGE
  Future<void> cacheLanguage(AppLanguage language) =>
      sharedPrefs.setString(ApiConstants.cachedLanguageKey, language.code);

  /// en, ar
  String getCachedLanguage() =>
      sharedPrefs.getString(ApiConstants.cachedLanguageKey) ??
      AppLanguage.english.code;
}
