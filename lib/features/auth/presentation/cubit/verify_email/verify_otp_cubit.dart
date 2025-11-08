import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/auth/data/model/resend_otp.dart';
import 'package:find_me_app/features/auth/data/model/sinup_user.dart';
import 'package:find_me_app/features/auth/data/model/verify_otp.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';

import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_state.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';

class VerifyOTPCubit extends Cubit<VerifyOTPState> {
  final AuthRepo _authRepo;
  final AuthLocal _localSource;
  final VerifyOTPArgs args;

  VerifyOTPCubit(
    this._authRepo,
    this._localSource,
    this.args,
  ) : super(VerifyOTPState.initial());

  void onOTPChanged(String value) {
    emit(state.copyWith(
      otp: value,
      status: VerifyStatus.initial,
    ));
  }

  Future<void> verifyOTP() async {
    print("✅ verifyOTP() called");

    if (!state.isOTPValid) {
      print("⚠️ OTP is invalid: ${state.otp}");
      return;
    }

    // مسح أي خطأ قديم قبل التحميل
    emit(state.copyWith(status: VerifyStatus.verifyOTPLoading, error: null));
    print("🚀 Status changed to loading");

    final request = VerifyOtpRequest(
      username: args.username,
      otp: state.otp!,
    );

    print(
        "📦 Sending request: username=${request.username}, otp=${request.otp}");

    final result = await _authRepo.activateEmail(request);

    result.fold(
      (error) {
        print("❌ Error: ${error.msg}");
        emit(state.copyWith(status: VerifyStatus.verifyOTPError, error: error));
      },
      (data) async {
        print("✅ Success! Access token: ${data.accessToken}");
        await _localSource.saveAccessToken(data.accessToken);

        emit(state.copyWith(
          status: VerifyStatus.verifyOTPSuccess,
          success: null,
          token: data.accessToken,
          error: null, // التأكد من مسح أي خطأ
        ));
      },
    );
  }

  Future<void> resendOTP() async {
    emit(state.copyWith(status: VerifyStatus.resendOTPLoading));

    // 📨 تجهيز الريكويست بالموديل الجديد
    final request = ResendOtpRequest(email: args.username);

    // 🚀 استدعاء الريبو
    final result = await _authRepo.resendOTP(request);

    // 📦 التعامل مع النتيجة
    result.fold(
      (error) {
        print("❌ resendOTP error: ${error.msg}");
        emit(state.copyWith(
          status: VerifyStatus.resendOTPError,
          error: error,
        ));
      },
      (response) {
        print("✅ resendOTP success: ${response.message}");
        emit(state.copyWith(
          status: VerifyStatus.resendOTPSuccess,
          success: SuccessResponse(msg: response.message),
          error: null,
        ));
      },
    );
  }
}
