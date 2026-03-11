import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/error_response.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/auth/data/model/activate_account.dart';
import 'package:find_me_app/features/auth/data/model/change_password.dart';
import 'package:find_me_app/features/auth/data/model/forget_password.dart';
import 'package:find_me_app/features/auth/data/model/resend_otp.dart';
import 'package:find_me_app/features/auth/data/model/reset_password.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/model/sinup_user.dart';
import 'package:find_me_app/features/auth/data/model/verify_otp.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AuthRemote {
  AuthRemote(
    this._client,
  );
  final http.Client _client;

  Future<String> getBaseUrl(int token) async {
    final uri = Uri.parse(ApiConstants.getBaseUrlForCompany(token));

    log("GetBaseUrl API: ${uri.toString()}");
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 10),
        );

    // final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    // kThrowAuthExceptionIfFails(parsedResponse);
    log("GetBaseUrl: ${response.body}");
    return utf8.decode(response.bodyBytes);
  }

  // Future<String> signin(SignInUserRequest data) async {
  //   final requestBody = data.toJson();
  //   final response = await makeHttpRequest(
  //     url: ApiConstants.signinUrl,
  //     requestType: HttpRequestType.post,
  //     requestBody: requestBody,
  //     // client: _client,
  //     requiresAuth: false,
  //     needParsedResponse: false,
  //   );
  //   // final parsedResponse = ParseGeneralResponse.fromJson(response.body);
  //   // kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
  //   return utf8.decode(response.bodyBytes);
  // }

  Future<String> signin(SignInUserRequest data) async {
    final requestBody = data.toJson();

    final response = await makeHttpRequest(
      url: ApiConstants.signinUrl,
      requestType: HttpRequestType.post,
      requestBody: requestBody,
      requiresAuth: false,
      needParsedResponse: false,
    );

    log('[📩 SIGNIN RESPONSE CODE]: ${response.statusCode}');
    log('[📩 SIGNIN RESPONSE BODY]: ${response.body}');

    if (response.statusCode == 409) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final message =
          decoded["message"] ?? "Please verify your email before logging in.";

      throw NavigateToVerifyEmailException(message);
    }

    return utf8.decode(response.bodyBytes);
  }

  Future<Map<String, dynamic>> signup(SignUpUserRequest data) async {
    final client = http.Client();

    try {
      final fields = {
        'full_name': data.fullName,
        'email': data.email,
        'mobile_number': data.mobileNumber,
        'national_id': data.nationalId,
        'password': data.password,
        'password_confirmation': data.passwordConfirmation,
      };

      final files = <UploadFile>[];
      if (data.nationalPhotoPath?.isNotEmpty ?? false) {
        files.add(UploadFile(
          file: File(data.nationalPhotoPath!),
          fieldName: 'national_photo',
          name: basename(data.nationalPhotoPath!),
        ));
      }

      final headers = {'Accept': 'application/json', 'lang': 'EN'};

      final response = await makeMultipartRequest(
        url: ApiConstants.sinUpUrl,
        requestType: HttpRequestType.post,
        // client: client,
        fields: fields,
        files: files,
        headers: headers,
        requiresAuth: false,
      );

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print('[log] [📩 RESPONSE CODE]: ${response.statusCode}');
      print('[log] [📩 RESPONSE BODY]: $json');

      // ✅ تحقق من كود الحالة
      if (response.statusCode >= 400) {
        final message = json['message'] ?? 'Server error';
        throw ServerException(message);
      }

      return json;
    } finally {
      client.close();
    }
  }

  Future<String> activateEmail(VerifyOtpRequest data) async {
    final client = http.Client();
    try {
      final uri = Uri.parse(ApiConstants.activateAccountUrl);

      final fields = {
        'email': data.username,
        'otp': data.otp,
      };

      // headers
      final headers = {
        'Accept': 'application/json',
      };

      // إرسال request multipart
      final response = await makeMultipartRequest(
        url: uri.toString(),
        requestType: HttpRequestType.post,
        // client: client,
        fields: fields,
        headers: headers,
        requiresAuth: false,
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonMap = {};
      try {
        jsonMap = jsonDecode(decodedBody);
      } catch (_) {}

      print('[HTTP] ${response.statusCode}, ${decodedBody}');

      // تحقق من النجاح
      if (response.statusCode != 200) {
        throw ServerException(
          jsonMap['message'] ?? "كود التفعيل غير صحيح",
        );
      }

      return decodedBody;
    } finally {
      client.close();
    }
  }

  Future<String> forgetPassword(ForgetPasswordRequest data) async {
    final client = http.Client();
    try {
      final uri = Uri.parse(ApiConstants.forgetPasswordUrl);

      // تحضير الحقول
      final fields = {
        'email': data.email,
      };

      // headers
      final headers = {
        'Accept': 'application/json',
      };

      // إرسال request multipart
      final response = await makeMultipartRequest(
        url: uri.toString(),
        requestType: HttpRequestType.post,
        // client: client,
        fields: fields,
        headers: headers,
        requiresAuth: false,
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonMap = {};
      try {
        jsonMap = jsonDecode(decodedBody);
      } catch (_) {}

      print('[HTTP] ${response.statusCode}, ${decodedBody}');

      // تحقق من النجاح
      if (response.statusCode != 200) {
        throw ServerException(
          jsonMap['message'] ?? "email invalid",
        );
      }

      return decodedBody;
    } finally {
      client.close();
    }
  }

  Future<String> resetPassword(ResetPasswordRequest data) async {
    final requestBody = data.toJson();
    final response = await makeHttpRequest(
      url: ApiConstants.resetPasswordUrl,
      requestType: HttpRequestType.post,
      requestBody: requestBody,
      requiresAuth: false,
      // client: _client,
      needParsedResponse: false,
    );
    // final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    // kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
    return utf8.decode(response.bodyBytes);
  }

  Future<String> resendOTP(ResendOtpRequest data) async {
    final client = http.Client();
    try {
      final uri = Uri.parse(ApiConstants.resendOTP);

      // تحضير الحقول
      final fields = {
        'email': data.email,
      };

      // headers
      final headers = {
        'Accept': 'application/json',
      };

      // إرسال request multipart
      final response = await makeMultipartRequest(
        url: uri.toString(),
        requestType: HttpRequestType.post,
        // client: client,
        fields: fields,
        headers: headers,
        requiresAuth: false,
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonMap = {};
      try {
        jsonMap = jsonDecode(decodedBody);
      } catch (_) {}

      print('[HTTP] ${response.statusCode}, ${decodedBody}');

      // تحقق من النجاح
      if (response.statusCode != 200) {
        throw ServerException(
          jsonMap['message'] ?? "email invalid",
        );
      }

      return decodedBody;
    } finally {
      client.close();
    }
  }

  Future<String> activateAccount(ActivateAccountRequest data) async {
    final uri = Uri.parse(ApiConstants.activateAccountUrl);
    final requestBody = data.toJson();

    final headers = {
      'Content-Type': 'application/json',
      // 'os': (Platform.isIOS ? 1 : 2).toString(),
      // 'lang': sl<AppLocal>().getCachedLanguage().toUpperCase(),
      // "lat": sl<LocationService>().lat?.toString() ?? "",
      // "lng": sl<LocationService>().lng?.toString() ?? "",
    };
    final response = await http.put(
      uri,
      headers: headers,
      body: requestBody,
    );

    final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
    return utf8.decode(response.bodyBytes);
  }

  // Future<Map<String, dynamic>> verifyOTP(String email) async {
  //   final uri = Uri.parse(ApiConstants.sendOtp(email));
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'os': (Platform.isIOS ? 1 : 2).toString(),
  //     'lang': sl<AppLocal>().getCachedLanguage().toUpperCase(),
  //     "lat": sl<LocationService>().lat?.toString() ?? "",
  //     "lng": sl<LocationService>().lng?.toString() ?? "",
  //   };

  //   final response = await http.post(uri, headers: headers);

  //   final body = utf8.decode(response.bodyBytes);
  //   final json = jsonDecode(body);

  //   print('[log] [📩 RESPONSE CODE]: ${response.statusCode}');
  //   print('[log] [📩 RESPONSE BODY]: $json');

  //   if (response.statusCode >= 400) {
  //     throw ServerException(json['message'] ?? 'Server error');
  //   }

  //   // ✅ نعيد الشكل المتوقع من SuccessResponse
  //   return {
  //     "status": {
  //       "code": response.statusCode,
  //       "message": json['message'] ?? 'Success',
  //     }
  //   };
  // }

  Future<String> deleteAccount() async {
    final response = await makeHttpRequest(
      url: ApiConstants.deleteAccountUrl,
      requestType: HttpRequestType.post,
      requiresAuth: true,
      needParsedResponse: false,
    );
    final responseString = utf8.decode(response.bodyBytes);
    final jsonData = jsonDecode(responseString);

    return jsonData['message'] ?? "error try again";
  }

  Future<String> sendOTP(String email) async {
    final uri = Uri.parse(ApiConstants.sendOtp(email));
    final headers = {
      'Content-Type': 'application/json',
      // 'os': (Platform.isIOS ? 1 : 2).toString(),
      // 'lang': sl<AppLocal>().getCachedLanguage().toUpperCase(),
      // "lat": sl<LocationService>().lat?.toString() ?? "",
      // "lng": sl<LocationService>().lng?.toString() ?? "",
    };
    final response = await http.post(
      uri,
      headers: headers,
    );

    // final response = await makeHttpRequest(
    //   url: ApiConstants.sendOtp(email),
    //   requestType: HttpRequestType.post,
    //   client: _client,
    //   throwExceptionIfFails: kThrowAuthExceptionIfFails,
    // );

    final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
    return utf8.decode(response.bodyBytes);
  }

  // Future<String> resetPassword(ResetPasswordRequest data) async {
  //   final uri = Uri.parse(ApiConstants.resetPasswordUrl);
  //   final requestBody = data.toJson();
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'lang': sl<AppLocal>().getCachedLanguage().toUpperCase(),
  //   };
  //   final response = await http.put(
  //     uri,
  //     headers: headers,
  //     body: requestBody,
  //   );

  //   // final response = await makeHttpRequest(
  //   //   url: ApiConstants.resetPasswordUrl,
  //   //   requestType: HttpRequestType.put,
  //   //   client: _client,
  //   //   requestBody: data.toJson(),
  //   //   throwExceptionIfFails: kThrowAuthExceptionIfFails,
  //   // );

  //   final parsedResponse = ParseGeneralResponse.fromJson(response.body);
  //   kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
  //   return utf8.decode(response.bodyBytes);
  // }

  Future<String> changePassword(ChangePasswordRequest data) async {
    final requestBody = data.toJson();
    final response = await makeHttpRequest(
      url: ApiConstants.changePasswordUrl,
      requestType: HttpRequestType.put,
      requestBody: requestBody,
      // client: _client,
      needParsedResponse: false,
    );
    final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
    return utf8.decode(response.bodyBytes);
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final url = "${ApiConstants.refreshTokenUrl}/refresh";
    final response = await http.post(
      Uri.parse(url),
      headers: ApiConstants.headers(),
      body: jsonEncode({"refresh_token": refreshToken}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to refresh token: ${response.body}");
    }
  }
}
