import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/networking/network_info.dart';
import 'package:find_me_app/core/networking/token_utils.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/error_response.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

http.Client client = http.Client();

/// Used In Remote Impl for Checking status code if not equal code throws error
/// passed error msg to handle error Method
throwExceptionIfFails(http.Response response, int code) {
  if (response.statusCode != 200 && response.statusCode != 201) {
    final error = ErrorResponse.fromJson(response.body);
    debugPrint(error.toString());
    // var handledError = handleErrorMessage(error);
    throw ServerException(error.msg ?? "Something went wrong");
  }
}

//-------------------------------------------------------------------------------
//! Reusable Function
/// user will be null in auth methods
typedef CustomFunctionality<T> = Future<T> Function();

/// Used in Repo Implementations.
/// Takes the logic to implement and returns failure if throwed error or [T] if success
// Future<Either<Failure, T>> executeFunctionality<T>({
//   required CustomFunctionality<T> function,
// }) async {
//   // check internet connection
//   try {
//     // final bool isConnected = await networkInfo.isConnected;
//     return Right(await function());
//   }
//   // User Token Exception
//   // on UserTokenException catch (error) {
//   //   return Left(UserTokenFailure(error.msg));
//   // }
//   // Cache Exception
//   on CacheException catch (error) {
//     return Left(CacheFailure(error.msg));

//     ///NavigateToVerifyEmail
//   } on NavigateToVerifyEmailException {
//     rethrow; // خليه يطلع للـ Cubit زي ما هو
//   }
//   // Server Exception
//   on ServerException catch (error) {
//     return Left(ServerFailure(error.msg));
//   }
//   // User Cancellation Exception
//   on UserCancellationException catch (error) {
//     return Left(UserCancellationFailure(error.msg));
//   }
//   // Format Exception
//   on FormatException catch (_) {
//     return const Left(FormatFailure());
//   } on InternetException catch (_) {
//     return const Left(InternetFailure());
//   }
//   // Unknown exception
//   catch (_) {
//     return const Left(UnknownFailure());
//   }
// }

Future<Either<Failure, T>> executeFunctionality<T>({
  required CustomFunctionality<T> function,
}) async {
  try {
    // final networkInfo = sl<NetworkInfo>();
    // final isConnected = await networkInfo.isConnected;
    // if (!isConnected) {
    //   return const Left(InternetFailure());
    // }

    return Right(await function());
  } on CacheException catch (error) {
    return Left(CacheFailure(error.msg));
  } on NavigateToVerifyEmailException {
    rethrow;
  } on ServerException catch (error) {
    return Left(ServerFailure(error.msg));
  } on UserCancellationException catch (error) {
    return Left(UserCancellationFailure(error.msg));
  } on FormatException catch (_) {
    return const Left(FormatFailure());
  } on InternetException catch (_) {
    return const Left(InternetFailure());
  } on SocketException catch (_) {
    return const Left(InternetFailure());
  } catch (e) {
    print('❌ Unknown exception: $e');
    return const Left(UnknownFailure());
  }
}

/// [code] is the expected response code default is 200
/// [requestBody] is the body to be sent with the request
/// [requestType] is the type of request to be made
/// [client] is the http client to be used
/// [url] is the url to be used
///

/// Returns a valid access token (possibly refreshed), or null if refresh failed.
Future<String?> ensureValidAccessToken() async {
  final authLocal = sl<AuthLocal>();
  String? accessToken = await authLocal.getAccessToken();

  if (accessToken == null || accessToken.isEmpty) {
    log("ensureValidAccessToken: no access token found");
    return null;
  }

  // التحقق من صلاحية التوكن
  final expiry = await authLocal.getAccessTokenExpiry();
  bool isExpired;
  if (expiry != null) {
    isExpired = DateTime.now().isAfter(expiry);
  } else {
    try {
      isExpired = JwtDecoder.isExpired(accessToken);
    } catch (_) {
      isExpired = true;
    }
  }

  if (!isExpired) {
    return accessToken;
  }

  log("ensureValidAccessToken: Access token expired, trying to refresh...");
  return await refreshAccessToken();
}

Future<http.Response> makeHttpRequest({
  String? requestBody,
  required String url,
  required HttpRequestType requestType,
  int code = 200,
  Map<String, dynamic>? queryParams,
  bool needParsedResponse = true,
  bool requiresAuth = true,
}) async {
  late http.Response response;
  late Uri uri;

  uri = queryParams != null
      ? Uri.parse("$url?${Uri(queryParameters: queryParams).query}")
      : Uri.parse(url);

  Map<String, String> headers = {'Content-Type': 'application/json'};

  // ✅ لو الطلب محتاج توكن
  if (requiresAuth) {
    final token = await ensureValidAccessToken();
    if (token == null) {
      throw ServerException("Unauthorized - please login again");
    }
    headers['Authorization'] = 'Bearer $token';
  }

  log("🌐 API Request: $uri");

  // ✅ تنفيذ الطلب
  switch (requestType) {
    case HttpRequestType.get:
      response = await http.get(uri, headers: headers);
      break;
    case HttpRequestType.post:
      response = await http.post(uri, headers: headers, body: requestBody);
      break;
    case HttpRequestType.put:
      response = await http.put(uri, headers: headers, body: requestBody);
      break;
    case HttpRequestType.delete:
      response = await http.delete(uri, headers: headers, body: requestBody);
      break;
  }

  log("[📩 RESPONSE CODE]: ${response.statusCode}");
  log("[📩 RESPONSE BODY]: ${response.body}");

  // ✅ لو التوكن انتهى أثناء الطلب
  if (requiresAuth && response.statusCode == 401) {
    log("⚠️ 401 Unauthorized — trying to refresh token...");
    final newToken = await refreshAccessToken();

    if (newToken != null) {
      headers['Authorization'] = 'Bearer $newToken';
      // 🔁 أعد المحاولة
      switch (requestType) {
        case HttpRequestType.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpRequestType.post:
          response = await http.post(uri, headers: headers, body: requestBody);
          break;
        case HttpRequestType.put:
          response = await http.put(uri, headers: headers, body: requestBody);
          break;
        case HttpRequestType.delete:
          response =
              await http.delete(uri, headers: headers, body: requestBody);
          break;
      }
    } else {
      throw ServerException("Unauthorized - please login again");
    }
  }

  // ✅ التعامل مع أكواد الخطأ (422, 409, 400, 500 ...)
  // ✅ التعامل مع أكواد الخطأ (422, 409, 400, 500 ...)
  if (response.statusCode >= 400) {
    String serverMsg = "An unexpected server error occurred";

    try {
      final decodedBody = utf8.decode(response.bodyBytes);

      if (decodedBody.isNotEmpty) {
        final decoded = jsonDecode(decodedBody);

        if (decoded is Map<String, dynamic>) {
          // نحاول نجيب الرسالة من message أو error
          serverMsg = decoded['message'] ??
              decoded['error'] ??
              decoded['errors']?.values?.first?.toString() ??
              serverMsg;
        } else if (decoded is String) {
          // في حالة السيرفر بيرجع نص فقط
          serverMsg = decoded;
        }
      }
    } catch (e) {
      log("⚠️ Failed to decode error body: $e");
      // نحتفظ بالـ default message
    }

    log("❌ SERVER ERROR [$url]: $serverMsg");

    if (response.statusCode == 409) {
      throw NavigateToVerifyEmailException(serverMsg);
    }

    throw ServerException(serverMsg);
  }

  // ✅ في حالة النجاح العادي
  if (needParsedResponse) {
    try {
      final parsed =
          ParseGeneralResponse.fromJson(utf8.decode(response.bodyBytes));
      kThrowAuthExceptionIfFails(parsed.code, parsed.msg);
    } catch (e) {
      log("⚠️ ParseGeneralResponse skipped: $e");
    }
  }

  return response;
}

Future<http.Response> makeHttpRequest2({
  String? requestBody,
  required String url,
  required HttpRequestType requestType,
  required http.Client client,
  int code = 200,
  Map<String, dynamic>? queryParams,
  bool needParsedResponse = true,
  // required Function(ParseGeneralResponse parsedResponse) throwExceptionIfFails,
}) async {
  //1. Parse the url
  late final http.Response response;
  late final Uri uri;

  if (queryParams != null) {
    final queryParameters = queryParams;
    String queryString = Uri(queryParameters: queryParameters).query;
    uri = Uri.parse(url + queryString);
  } else {
    uri = Uri.parse(url);
  }

  final headers = {
    'Content-Type': 'application/json',
    // 'os': Platform.isIOS ? "1" : "2",
  };

  log("API: $uri");
  // 2. Make the request
  switch (requestType) {
    case HttpRequestType.get:
      response = await client.get(
        uri,
        headers: headers,
      );

      break;

    case HttpRequestType.post:
      response = await client.post(
        uri,
        headers: headers,
        body: requestBody,
      );
      break;

    case HttpRequestType.put:
      response = await client.put(
        uri,
        headers: headers,
        body: requestBody,
      );

      break;

    case HttpRequestType.delete:
      response = await client.delete(
        uri,
        headers: headers,
        body: requestBody,
      );
      break;
  }

  log("Response ya pop : ${response.body}");

  late int? code;
  late String? msg;

  if (needParsedResponse == false) {
    return response;
  } else {
    final parsedResponse =
        ParseGeneralResponse.fromJson(utf8.decode(response.bodyBytes));
    code = parsedResponse.code;
    msg = parsedResponse.msg;
  }

  kThrowAuthExceptionIfFails(code, msg);
  return response;
}

Future<http.Response> makeMultipartRequest({
  required String url,
  required HttpRequestType requestType,
  Map<String, String>? fields,
  Map<String, String>? headers,
  List<UploadFile>? files,
  Map<String, String>? jsonField,
  bool requiresAuth = true, // ✅ مضافة هنا
}) async {
  final uri = Uri.parse(url);

  String? token;
  if (requiresAuth) {
    // ✅ لو الـ API محتاج توكن
    token = await ensureValidAccessToken();
    if (token == null) {
      log("❌ Token invalid or refresh failed, please re-login");
      throw Exception("Unauthorized - please login again");
    }
  }

  final request = http.MultipartRequest(requestType.value, uri);

  // ✅ الحقول
  if (fields != null) {
    request.fields.addAll(fields);
  }

  // ✅ JSON fields
  if (jsonField != null && jsonField.isNotEmpty) {
    request.files.add(http.MultipartFile.fromString(
      jsonField.keys.first,
      jsonField.values.first,
      contentType: MediaType.parse('application/json'),
    ));
  }

  // ✅ الملفات
  if (files != null && files.isNotEmpty) {
    for (final file in files) {
      final filePath = file.file?.path;
      if (filePath == null || filePath.isEmpty) continue;

      final mimeType = mime(basename(filePath));
      request.files.add(await http.MultipartFile.fromPath(
        file.fieldName ?? "file",
        filePath,
        filename: file.name ?? basename(filePath),
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      ));
    }
  }

  // ✅ تجهيز الـ headers
  request.headers.addAll({
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
    if (requiresAuth && token != null) 'Authorization': 'Bearer $token',
    ...?headers,
  });

  // ✅ إرسال الطلب
  var streamedResponse = await client.send(request);
  var response = await http.Response.fromStream(streamedResponse);

  // ✅ لو 401 و محتاج Auth → نجرب Refresh
  if (requiresAuth && response.statusCode == 451) {
    log("⚠️ Multipart token expired, trying to refresh...");
    // final newToken = await ensureValidAccessToken();
    final newToken = await refreshAccessToken();

    if (newToken != null) {
      log("✅ Multipart token refreshed, retrying upload...");
      request.headers['Authorization'] = 'Bearer $newToken';
      streamedResponse = await client.send(request);
      response = await http.Response.fromStream(streamedResponse);
    } else {
      log("❌ Failed to refresh multipart token, please re-login");
      throw Exception("Unauthorized - please login again");
    }
  } else if (response.statusCode == 401) {
    // call logout method
  }

  // ✅ Logging
  log('[📤 MULTIPART] URL: $url');
  log('[📦 FIELDS]: ${request.fields}');
  log('[🖼 FILES]: ${files?.map((e) => e.file?.path).join(", ")}');
  log('[📩 RESPONSE CODE]: ${response.statusCode}');
  log('[📩 RESPONSE BODY]: ${response.body}');

  // ✅ تحليل الاستجابة
  try {
    final parsedResp =
        ParseGeneralResponse.fromJson(utf8.decode(response.bodyBytes));

    // ✅ استخدم كود السيرفر الفعلي لو الـ JSON مش فيه code
    final actualCode = parsedResp.code ?? response.statusCode;

    kThrowAuthExceptionIfFails(actualCode, parsedResp.msg);
  } catch (e) {
    if (e is NavigateToVerifyEmailException || e is ServerException) {
      rethrow; // خليه يطلع للـ Cubit
    }
    log('⚠️ ParseGeneralResponse skipped: $e');
  }

  return response;
}

Future<String> get fcmToken async {
  // return await FirebaseMessaging.instance.getToken() ?? "";
  return "fcmToken";
}

/// agent
String get deviceOS {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  }
  return '';
}

/// ex: +20********89
String hideMobileNumber(String mobile) {
  if (mobile.isEmpty || mobile.length < 7) {
    return mobile;
  }

  final countOfStars = mobile.length - 5;
  return mobile.replaceRange(3, mobile.length - 2, ("*" * countOfStars));
}

void kThrowAuthExceptionIfFails(int? code, String? msg) {
  log("$code, $msg");

  switch (code) {
    case 258:
    case 200:
    case 201:
    case 1012:
      return;

    case 451:

    /// refresh token ya H
    case 401:
    // throw UserTokenException();

    case 253:
    case 259:
    case 400:
    case 422:

    ///navigate to login
    case 500:
    case 1004:
    case 1005:
    case 1011:
    case 1013:
    case 1019:
    case 1020:
    case 10020:
    case 10021: // User tries to login with invalid credentials three times.
    case 1021:
      throw ServerException(msg ?? "");
    case 409:
      {
        // navigate to verify
        throw NavigateToVerifyEmailException(
            msg ?? "Email verification required");
      }

    default:
      return;
  }
}
