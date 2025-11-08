// ✅ فانكشن موحدة لتجديد التوكن
import 'dart:convert';
import 'dart:developer';

import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:http/http.dart' as http;

Future<String?> refreshAccessToken() async {
  final authLocal = sl<AuthLocal>();
  final refreshToken = await authLocal.getRefreshToken();

  if (refreshToken == null || refreshToken.isEmpty) {
    log("❌ No refresh token found, can't refresh token");
    return null;
  }

  log("🔁 Sending refresh token request...");

  try {
    final response = await http.post(
      Uri.parse(ApiConstants.refreshTokenUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    log("🔁 Refresh response: ${response.statusCode} → ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final newAccessToken = data['access_token'] as String?;
      final newRefreshToken = data['refresh_token'] as String? ?? refreshToken;
      final expiresIn = data['expires_in'] is int
          ? data['expires_in'] as int
          : int.tryParse(data['expires_in']?.toString() ?? '');

      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        await authLocal.cacheAccessToken(newAccessToken,
            expiresInSeconds: expiresIn);
        await authLocal.cacheRefreshToken(newRefreshToken);

        log("✅ Token refreshed successfully");
        return newAccessToken;
      } else {
        log("⚠️ Refresh API returned no access_token");
      }
    } else {
      log("❌ Refresh token request failed (${response.statusCode})");
    }
  } catch (e, st) {
    log("⚠️ Exception while refreshing token: $e");
    log("$st");
  }

  return null;
}
