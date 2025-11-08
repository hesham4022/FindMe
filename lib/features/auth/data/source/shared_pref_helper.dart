import 'dart:convert';

import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _sharedPrefs;

  static const String _cachedBaseUrlResponseKey = 'cached_base_url_response';

  /// Initialize SharedPreferences (Must be called before using any function)
  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  /// Save `BaseUrlResponse` to SharedPreferences
  static Future<void> cacheBaseUrlResponse(
      BaseUrlResponse baseUrlResponse) async {
    if (_sharedPrefs == null) {
      await init();
    }
    final jsonString = jsonEncode(baseUrlResponse.toMap());
    await _sharedPrefs!.setString(_cachedBaseUrlResponseKey, jsonString);
  }

  /// Retrieve `BaseUrlResponse` from SharedPreferences
  static Future<BaseUrlResponse?> getBaseUrlResponse() async {
    if (_sharedPrefs == null) {
      await init();
    }
    final jsonString = _sharedPrefs!.getString(_cachedBaseUrlResponseKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final decodedJson = jsonDecode(jsonString);
      return BaseUrlResponse.fromMap(decodedJson);
    } catch (e) {
      return null;
    }
  }

  /// Clear the cached `BaseUrlResponse`
  static Future<void> clearBaseUrlResponse() async {
    if (_sharedPrefs == null) {
      await init();
    }
    await _sharedPrefs!.remove(_cachedBaseUrlResponseKey);
  }
}
