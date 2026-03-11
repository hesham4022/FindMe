import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/auth/data/model/verify_otp.dart';

enum VerifyStatus {
  initial,
  verifyOTPLoading,
  verifyOTPSuccess,
  verifyOTPError,
  resendOTPLoading,
  resendOTPSuccess,
  resendOTPError,
}

class VerifyOTPState extends Equatable {
  final String? otp;
  final VerifyStatus status;
  final SuccessResponse? success;
  final Failure? error;
  final String? token;

  const VerifyOTPState({
    this.otp,
    required this.status,
    this.success,
    this.error,
    this.token,
  });

//------------------------- Validate Fields  -------------------------
  bool get isOTPValid =>
      otp != null && otp!.trim().isNotEmpty && otp!.length == 5;

  bool get isButtonEnabled => isOTPValid;

  bool get isInitial => status == VerifyStatus.initial;
  bool get isVerifyOTPLoading => status == VerifyStatus.verifyOTPLoading;
  bool get isVerifyOTPSuccess => status == VerifyStatus.verifyOTPSuccess;
  bool get isVerifyOTPError => status == VerifyStatus.verifyOTPError;

  bool get isResendOTPLoading => status == VerifyStatus.resendOTPLoading;
  bool get isResendOTPSuccess => status == VerifyStatus.resendOTPSuccess;
  bool get isResendOTPError => status == VerifyStatus.resendOTPError;

  factory VerifyOTPState.initial() {
    return VerifyOTPState(
      status: VerifyStatus.initial,
    );
  }

  VerifyOTPState copyWith({
    String? otp,
    VerifyStatus? status,
    SuccessResponse? success,
    Failure? error,
    String? token,
  }) {
    return VerifyOTPState(
      otp: otp ?? this.otp,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        otp,
        status,
        success,
        error,
        token,
      ];
}
