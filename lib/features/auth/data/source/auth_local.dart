import 'dart:convert';
import 'dart:developer';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';
import 'package:find_me_app/features/profile/data/model/update_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocal {
  final StoreRef<String, Map<String, dynamic>?> _localDB;
  final SharedPreferences sharedPrefs;
  final FlutterSecureStorage _secureStorage;

  AuthLocal(
    this._localDB,
    this.sharedPrefs,
    this._secureStorage,
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AuthedUser? _cachedUser;
  String? _baseUrl;

  static const String _kCachedUserRecord = 'cached_user';
  static const String _kCachedBaseUrlResponseKey = 'cached_base_url_response';

  // ✅ NEW: مفتاح لتاريخ انتهاء الـ access token
  static const String _kCachedAccessTokenExpiry = 'cached_access_token_expiry';

  // ---------------------------------------------------------------------------
  // USER
  // ---------------------------------------------------------------------------
  Future<void> cacheAuthedUser(AuthedUser authedUser) async {
    await Future.wait([
      _localDB
          .record(_kCachedUserRecord)
          .put(sl<Database>(), authedUser.toMap()),
      cacheUserId(authedUser.id.toString()),
    ]);
    _cachedUser = authedUser;
  }

  Future<AuthedUser> getCachedAuthedUser() async {
    if (_cachedUser != null) return _cachedUser!;

    final userMap =
        await _localDB.record(_kCachedUserRecord).get(sl<Database>());
    if (userMap == null) {
      final legacyMap = await _localDB
          .record(ApiConstants.cachedAuthedUser)
          .get(sl<Database>());

      if (legacyMap == null) return _cachedUser!;

      _cachedUser = AuthedUser.fromMap(legacyMap);
      return _cachedUser!;
    }
    _cachedUser = AuthedUser.fromMap(userMap);
    return _cachedUser!;
  }

  Future<void> deleteAuthedUser() async {
    await Future.wait([
      _localDB.record(_kCachedUserRecord).delete(sl<Database>()),
      _localDB.record(ApiConstants.cachedAuthedUser).delete(sl<Database>()),
      _deleteCachedAccessToken(),
      _deleteCachedRefreshToken(),
      cacheIsUserLoggedIn(false),
      _deleteCachedBaseUrl(),
    ]);
    _cachedUser = null;
  }

  // ---------------------------------------------------------------------------
  // SHARED PREFS
  // ---------------------------------------------------------------------------
  Future<bool> cacheIsUserLoggedIn(bool isLoggedIn) async {
    return sharedPrefs.setBool(ApiConstants.cachedIsUserLoggedIn, isLoggedIn);
  }

  bool isUserLoggedIn() =>
      sharedPrefs.getBool(ApiConstants.cachedIsUserLoggedIn) ?? false;

  Future<void> cacheUserId(String? userId) async {
    if (userId == null || userId.isEmpty) return;
    await sharedPrefs.setString(ApiConstants.cachedUserId, userId);
  }

  String getUserId() => sharedPrefs.getString(ApiConstants.cachedUserId) ?? "";

  // ---------------------------------------------------------------------------
  // BASE URL
  // ---------------------------------------------------------------------------
  Future<void> cacheBaseUrl(String baseUrl) async {
    await _secureStorage.write(
      key: ApiConstants.cachedBaseUrl,
      value: baseUrl,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
    _baseUrl = baseUrl;
    log("✅ Cached base URL: $baseUrl");
  }

  Future<void> _deleteCachedBaseUrl() async {
    await _secureStorage.delete(
      key: ApiConstants.cachedBaseUrl,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
    _baseUrl = null;
  }

  Future<String?> getBaseUrl() async {
    if (_baseUrl != null && _baseUrl!.isNotEmpty) return _baseUrl;
    final baseUrl = await _secureStorage.read(
      key: ApiConstants.cachedBaseUrl,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
    _baseUrl = baseUrl;
    return baseUrl;
  }

  // ---------------------------------------------------------------------------
  // TOKENS
  // ---------------------------------------------------------------------------

  // ✅ NEW: خزن access token + expiry (اختياري)
  Future<void> cacheAccessToken(String token, {int? expiresInSeconds}) async {
    await _secureStorage.write(
      key: ApiConstants.cachedAccessToken,
      value: token,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );

    if (expiresInSeconds != null) {
      final expiryDate =
          DateTime.now().add(Duration(seconds: expiresInSeconds));
      await cacheAccessTokenExpiry(expiryDate);
    }
  }

  Future<String?> getAccessToken() {
    return _secureStorage.read(
      key: ApiConstants.cachedAccessToken,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  // ✅ NEW: احفظ تاريخ انتهاء الـ access token
  Future<void> cacheAccessTokenExpiry(DateTime expiryDate) async {
    await _secureStorage.write(
      key: _kCachedAccessTokenExpiry,
      value: expiryDate.toIso8601String(),
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  // ✅ NEW: استرجع تاريخ الانتهاء
  Future<DateTime?> getAccessTokenExpiry() async {
    final expiryStr = await _secureStorage.read(
      key: _kCachedAccessTokenExpiry,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
    if (expiryStr == null || expiryStr.isEmpty) return null;
    try {
      return DateTime.parse(expiryStr);
    } catch (_) {
      return null;
    }
  }

  // ✅ NEW: حذف تاريخ الانتهاء
  Future<void> _deleteCachedAccessTokenExpiry() async {
    await _secureStorage.delete(
      key: _kCachedAccessTokenExpiry,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  Future<void> _deleteCachedAccessToken() async {
    await _secureStorage.delete(
      key: ApiConstants.cachedAccessToken,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
    await _deleteCachedAccessTokenExpiry(); // ✅ NEW: نحذف الـ expiry كمان
  }

  Future<void> cacheRefreshToken(String token) async {
    await _secureStorage.write(
      key: ApiConstants.cachedRefreshToken,
      value: token,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  Future<String?> getRefreshToken() {
    return _secureStorage.read(
      key: ApiConstants.cachedRefreshToken,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  Future<void> _deleteCachedRefreshToken() async {
    await _secureStorage.delete(
      key: ApiConstants.cachedRefreshToken,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  // ---------------------------------------------------------------------------
  // BaseUrlResponse
  // ---------------------------------------------------------------------------
  Future<void> cacheBaseUrlResponse(BaseUrlResponse baseUrlResponse) async {
    final jsonString = jsonEncode(baseUrlResponse.toMap());
    await sharedPrefs.setString(_kCachedBaseUrlResponseKey, jsonString);
  }

  Future<BaseUrlResponse?> getBaseUrlResponse() async {
    final jsonString = sharedPrefs.getString(_kCachedBaseUrlResponseKey);
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final decodedJson = jsonDecode(jsonString);
      if (decodedJson is Map<String, dynamic>) {
        return BaseUrlResponse.fromMap(decodedJson);
      }
      return null;
    } catch (e) {
      log("Error decoding BaseUrlResponse: $e");
      return null;
    }
  }

  Future<void> clearBaseUrlResponse() async {
    await sharedPrefs.remove(_kCachedBaseUrlResponseKey);
  }

  // ---------------------------------------------------------------------------
  // CLEAR / RESET
  // ---------------------------------------------------------------------------
  Future<void> clearAuthCache() async {
    await Future.wait([
      _localDB.record(_kCachedUserRecord).delete(sl<Database>()),
      _localDB.record(ApiConstants.cachedAuthedUser).delete(sl<Database>()),
      _deleteCachedAccessToken(),
      _deleteCachedRefreshToken(),
      sharedPrefs.remove(ApiConstants.cachedIsUserLoggedIn),
      sharedPrefs.remove(ApiConstants.cachedUserId),
    ]);
    _cachedUser = null;
  }

  Future<void> clearAppCache() async {
    await Future.wait([
      _localDB.delete(sl<Database>()),
      sharedPrefs.clear(),
      _deleteCachedAccessToken(),
      _deleteCachedRefreshToken(),
      _deleteCachedBaseUrl(),
    ]);
    _cachedUser = null;
    _baseUrl = null;
  }

  Future<void> clearAllCache() async {
    final baseUrlResponse = await getBaseUrlResponse();

    await Future.wait([
      _localDB.delete(sl<Database>()),
      sharedPrefs.clear(),
      _deleteCachedAccessToken(),
      _deleteCachedRefreshToken(),
      _deleteCachedBaseUrl(),
    ]);

    if (baseUrlResponse != null) {
      await cacheBaseUrlResponse(baseUrlResponse);
    }
    _cachedUser = null;
    _baseUrl = null;
  }

  Future<void> updateCachedUserFromProfile(ProfileData profile) async {
    final cachedUser = await getCachedAuthedUser();

    final updatedUser = cachedUser.copyWith(
      id: profile.id,
      email: profile.email,
      fullName: profile.fullName,
      mobileNumber: profile.mobileNumber,
      photo: profile.photo,
      dateOfBirth: profile.dateOfBirth,
      language: profile.language,
      soundEnable: profile.soundEnable,
      notificationEnable: profile.notificationEnable,
      role: profile.role,
      nationalId: profile.nationalId,
      nationalPhoto: profile.nationalPhoto,
      emailVerifiedAt: profile.emailVerifiedAt,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
      emailCode: profile.emailCode,
    );

    await saveUser(updatedUser);
  }
}

// ---------------------------------------------------------------------------
// Aliases for Cubit / Repo compatibility
// ---------------------------------------------------------------------------
extension AuthLocalAliases on AuthLocal {
  Future<void> saveAccessToken(String token, {int? expiresInSeconds}) =>
      cacheAccessToken(token, expiresInSeconds: expiresInSeconds);
  Future<void> saveRefreshToken(String token) => cacheRefreshToken(token);
  Future<void> saveUser(AuthedUser user) => cacheAuthedUser(user);
}
