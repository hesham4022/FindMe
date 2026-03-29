// import 'dart:convert';
// import 'dart:developer';

// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/error_management/exception.dart';
// import 'package:find_me_app/core/networking/api_constants.dart';

// import 'package:find_me_app/core/services/location/location_service.dart';
// import 'package:find_me_app/features/app/data/source/app_local.dart';
// import 'package:find_me_app/features/auth/data/source/auth_local.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_interceptor/http_interceptor.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class AppHttpClient {
//   final http.Client _client = InterceptedClient.build(
//     interceptors: [AppInterceptor()],
//     retryPolicy: ExpiredTokenRetryPolicy(),
//     client: http.Client(),
//   );

//   http.Client get client => _client;
// }

// // 1) Interceptor
// class AppInterceptor implements InterceptorContract {
//   @override
//   Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
//     // 1. اقرأ التوكنات من التخزين الآمن
//     final authLocal = sl<AuthLocal>();
//     String? accessToken = await authLocal.getAccessToken();
//     final String? refreshToken = await authLocal.getRefreshToken();

//     // 2. تأكد إن عندك refresh_token على الأقل
//     if (refreshToken == null || refreshToken.isEmpty) {
//       // throw UserTokenException();
//     }

//     // 3. لو الـ access_token فاضي أو منتهي، اعمل refresh
//     if (_isTokenExpired(accessToken)) {
//       // accessToken = await _refreshToken(refreshToken);
//     }

//     // 4. ضيف الهيدرز القياسية
//     // request.headers['lang'] = sl<AppLocal>().getCachedLanguage().toUpperCase();
//     // request.headers['Authorization'] = 'Bearer $accessToken';
//     // request.headers['lat'] = sl<LocationService>().lat?.toString() ?? '';
//     // request.headers['lng'] = sl<LocationService>().lng?.toString() ?? '';

//     log('request headers: ${request.headers}');
//     return request;
//   }

//   @override
//   Future<BaseResponse> interceptResponse(
//       {required BaseResponse response}) async {
//     // ممكن تحط لوجيك للـ responses لو أردت
//     return response;
//   }

//   @override
//   Future<bool> shouldInterceptRequest() async => true;

//   @override
//   Future<bool> shouldInterceptResponse() async => true;

//   bool _isTokenExpired(String? token) {
//     return token == null || token.isEmpty || JwtDecoder.isExpired(token);
//   }

//   /// يحاول يعمل refresh باستخدام refresh_token
//   /// ويرجع access_token الجديد ويخزّنه
//   // Future<String> _refreshToken(String refreshToken) async {
//   //   final authLocal = sl<AuthLocal>();

//   //   final uri = Uri.parse(ApiConstants.refreshTokenUrl);

//   //   // NOTE: خليك متأكد من الـ contract بتاع الـ API:
//   //   // - لو بيستقبل JSON استخدم application/json
//   //   // - لو بيستقبل x-www-form-urlencoded استخدم body: map بدون jsonEncode
//   //   final headers = <String, String>{
//   //     'Content-Type': 'application/json', // غيّرها لو الـ API عايز form
//   //   };

//   //   final body = jsonEncode({
//   //     // غيّر اسم المفتاح لو الـ API عايز "refreshToken" بدلاً من "refresh_token"
//   //     'refresh_token': refreshToken,
//   //   });

//   //   final response = await http.post(uri, headers: headers, body: body);

//   //   // اتأكد من حالة الرد
//   //   if (response.statusCode != 200 && response.statusCode != 201) {
//   //     // فشل التحديث → اعتبر السيشن منتهية
//   //     // throw UserTokenException();
//   //   }

//   //   // Parse JSON
//   //   final Map<String, dynamic> data =
//   //       jsonDecode(response.body) as Map<String, dynamic>;

//   //   // توقّع المفاتيح الشائعة: access_token / refresh_token / token_type
//   //   final String? newAccess = data['access_token'] as String?;
//   //   final String? newRefresh =
//   //       (data['refresh_token'] as String?) ?? refreshToken;

//   //   if (newAccess == null || newAccess.isEmpty) {
//   //     // الرد مش بالصيغة المتوقعة
//   //     // throw UserTokenException();
//   //   }

//   //   // خزن التوكنات الجديدة
//   //   await authLocal.cacheAccessToken(newAccess);
//   //   if (newRefresh != null && newRefresh.isNotEmpty) {
//   //     await authLocal.cacheRefreshToken(newRefresh);
//   //   }

//   //   return newAccess;
//   // }
// }

// // 2) Retry Policy
// class ExpiredTokenRetryPolicy extends RetryPolicy {
//   @override
//   int get maxRetryAttempts => 3;

//   @override
//   Future<bool> shouldAttemptRetryOnResponse(response) async {
//     // لو عايز تعيد المحاولة على 401/403… إلخ، عدّل هنا
//     return false;
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/services/location/location_service.dart';
import 'package:find_me_app/features/app/data/source/app_local.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppHttpClient {
  final http.Client _client = InterceptedClient.build(
    interceptors: [sl<AppInterceptor>()],
    retryPolicy: ExpiredTokenRetryPolicy(),
    client: http.Client(),
  );

  http.Client get client => _client;
}

class AppInterceptor implements InterceptorContract {
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final authLocal = sl<AuthLocal>();
    String? accessToken = await authLocal.getAccessToken();
    final String? refreshToken = await authLocal.getRefreshToken();

    // 🔹 لو التوكن منتهي → اعمل refresh
    if (_isTokenExpired(accessToken) && refreshToken != null) {
      log("🔁 Access token expired → refreshing...");
      await _refreshToken(refreshToken);
      accessToken = await authLocal.getAccessToken();
    }

    // 🔹 أضف الهيدرز القياسية
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'lang': sl<AppLocal>().getCachedLanguage().toUpperCase(),
      'lat': sl<LocationService>().lat?.toString() ?? '',
      'lng': sl<LocationService>().lng?.toString() ?? '',
    });

    log('📤 Request to ${request.url}');
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    // لو السيرفر رجع 401 → نحاول نعمل refresh مرة واحدة
    if (response.statusCode == 401) {
      final authLocal = sl<AuthLocal>();
      final refreshToken = await authLocal.getRefreshToken();
      if (refreshToken != null && !_isRefreshing) {
        log("⚠️ Got 401 → trying refresh token");
        await _refreshToken(refreshToken);
      }
    }
    return response;
  }

  bool _isTokenExpired(String? token) {
    return token == null || token.isEmpty || JwtDecoder.isExpired(token);
  }

  Future<void> _refreshToken(String refreshToken) async {
    // لو في عملية refresh شغالة، انتظرها
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      return;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    try {
      final uri = Uri.parse(ApiConstants.refreshTokenUrl);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'refresh_token': refreshToken});

      final response = await http.post(uri, headers: headers, body: body);
      log("🔁 Refresh token response: ${response.statusCode} | ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String? newAccess = data['access_token'];
        final String? newRefresh = data['refresh_token'] ?? refreshToken;

        if (newAccess != null) {
          final authLocal = sl<AuthLocal>();
          await authLocal.cacheAccessToken(newAccess);
          if (newRefresh != null && newRefresh.isNotEmpty) {
            await authLocal.cacheRefreshToken(newRefresh);
          }
          log("✅ Token refreshed successfully");
        } else {
          throw Exception("Invalid token response");
        }
      } else {
        log("❌ Refresh token failed: ${response.body}");
        throw Exception("Failed to refresh token");
      }
    } finally {
      _isRefreshing = false;
      _refreshCompleter?.complete();
    }
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 1;

  @override
  Future<bool> shouldAttemptRetryOnResponse(response) async => false;
}
