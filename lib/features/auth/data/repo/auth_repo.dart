import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/auth/data/model/activate_account.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:find_me_app/features/auth/data/model/change_password.dart';
import 'package:find_me_app/features/auth/data/model/forget_password.dart';
import 'package:find_me_app/features/auth/data/model/resend_otp.dart';
import 'package:find_me_app/features/auth/data/model/reset_password.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/model/sinup_user.dart';
import 'package:find_me_app/features/auth/data/model/verify_otp.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/data/source/auth_remote.dart';

class AuthRepo {
  final AuthRemote _authRemote;
  final AuthLocal _localSource;

  AuthRepo(
    this._authRemote,
    this._localSource,
  );

  // Future<Either<Failure, BaseUrlResponse>> getBaseUrl(int token) async {
  //   return executeFunctionality<BaseUrlResponse>(
  //     function: () async {
  //       final response = await _authRemote.getBaseUrl(token);

  //       if (response.trim() == "No data found") {
  //         throw Exception("No valid data found");
  //       }

  //       final decodedJson = jsonDecode(response);

  //       if (decodedJson is! Map<String, dynamic>) {
  //         throw Exception("Invalid response format");
  //       }

  //       final object = BaseUrlResponse.fromMap(decodedJson);
  //       final baseUrl = object.mobileUrl ?? "";

  //       final editedBaseUrl = baseUrl;

  //       // await _localSource.cacheBaseUrl(editedBaseUrl);
  //       sl<AppEnvironmentData>().setNewUrl(editedBaseUrl);

  //       return object.copyWith(mobileUrl: editedBaseUrl);
  //     },
  //   );
  // }

  Future<Either<Failure, SignInUserResponse>> signin(
    SignInUserRequest request,
  ) {
    return executeFunctionality<SignInUserResponse>(
      function: () async {
        final json = await _authRemote.signin(request);
        final response = SignInUserResponse.fromJson(json);

        // ✅ خزّن المستخدم والتوكنات وحالة الدخول
        await Future.wait([
          _localSource.saveUser(response.user),
          _localSource.saveAccessToken(response.accessToken),
          _localSource.saveRefreshToken(response.refreshToken),
          _localSource.cacheIsUserLoggedIn(true),
        ]);

        return response;
      },
    );
  }

  Future<Either<Failure, SignUpUserResponse>> signup(
    SignUpUserRequest request,
  ) {
    print('📡 [AuthRepo] Sending signup request: ${request.toJson()}');

    return executeFunctionality<SignUpUserResponse>(
      function: () async {
        // 🧩 استدعاء الـ Remote
        final json = await _authRemote.signup(request);

        // ✅ هنا بيكون حصل التحقق من الكود داخل interceptor أو makeMultipartRequest
        // ولو السيرفر رجّع 409 → هيتـرمى NavigateToVerifyEmailException ومش هنوصل هنا

        // 🧩 لو وصلنا هنا يبقى التسجيل تم بنجاح
        final response = SignUpUserResponse.fromMap(json);
        print('📩 [AuthRepo] Signup Response: $response');

        // 🧠 نحفظ المستخدم في الـ local storage
        await _localSource.saveUser(response.user);

        return response;
      },
    );
  }

  Future<Either<Failure, VerifyOtpResponse>> activateEmail(
    VerifyOtpRequest request,
  ) {
    return executeFunctionality<VerifyOtpResponse>(
      function: () async {
        final jsonString = await _authRemote.activateEmail(request);
        print("🔍 ActivateAccount JSON Response: $jsonString");
        final response = VerifyOtpResponse.fromJson(jsonString);

        await _localSource.saveAccessToken(response.accessToken);

        return response;
      },
    );
  }

  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  ) {
    return executeFunctionality<ForgetPasswordResponse>(
      function: () async {
        final jsonString = await _authRemote.forgetPassword(request);
        print("🔍 ActivateAccount JSON Response: $jsonString");
        final response = ForgetPasswordResponse.fromJson(jsonString);
        return response;
      },
    );
  }

  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) {
    return executeFunctionality<ResetPasswordResponse>(
      function: () async {
        final json = await _authRemote.resetPassword(request);
        final response = ResetPasswordResponse.fromJson(json);

        // ✅ خزّن المستخدم والتوكنات وحالة الدخول
        await Future.wait([
          _localSource.saveUser(response.user),
          _localSource.saveAccessToken(response.accessToken),
          _localSource.saveRefreshToken(response.refreshToken),
          _localSource.cacheIsUserLoggedIn(true),
        ]);

        return response;
      },
    );
  }

  Future<Either<Failure, ResendOtpResponse>> resendOTP(
    ResendOtpRequest request,
  ) {
    return executeFunctionality<ResendOtpResponse>(
      function: () async {
        final jsonString = await _authRemote.resendOTP(request);
        print("🔍 ActivateAccount JSON Response: $jsonString");
        final response = ResendOtpResponse.fromJson(jsonString);
        return response;
      },
    );
  }

  // Future<Either<Failure, SuccessResponse>> resetPassword(
  //   ResetPasswordRequest request,
  // ) {
  //   return executeFunctionality<SuccessResponse>(
  //     function: () async {
  //       final json = await _authRemote.resetPassword(request);
  //       return SuccessResponse.fromJson(json);
  //     },
  //   );
  // }

  Future<Either<Failure, SuccessResponse>> sendOTP(String email) {
    return executeFunctionality<SuccessResponse>(
      function: () async {
        final json = await _authRemote.sendOTP(email);
        return SuccessResponse.fromJson(json);
      },
    );
  }

  Future<Either<Failure, ActivateAccountResponse>> activateAccount(
    ActivateAccountRequest request,
  ) {
    return executeFunctionality<ActivateAccountResponse>(
      function: () async {
        final json = await _authRemote.activateAccount(request);
        final response = ActivateAccountResponse.fromJson(json);
        return response;
      },
    );
  }

  Future<Either<Failure, SuccessResponse>> changePassword(
    ChangePasswordRequest request,
  ) {
    return executeFunctionality<SuccessResponse>(
      function: () async {
        final json = await _authRemote.changePassword(request);
        return SuccessResponse.fromJson(json);
      },
    );
  }
}
