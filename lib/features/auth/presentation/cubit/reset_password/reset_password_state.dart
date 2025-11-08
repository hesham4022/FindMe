import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/reset_password.dart';

enum ResetPasswordStatus { initial, loading, success, error }

class ResetPasswordState extends Equatable {
  final String? email;
  final String? otp;
  final String? password;
  final String? confirmPassword;

  final String? otpErrorText;
  final String? passwordErrorText;
  final String? confirmPasswordErrorText;

  final ResetPasswordStatus status;
  final ResetPasswordResponse? success;
  final Failure? error;

  const ResetPasswordState({
    this.email,
    this.otp,
    this.password,
    this.confirmPassword,
    this.otpErrorText,
    this.passwordErrorText,
    this.confirmPasswordErrorText,
    required this.status,
    this.success,
    this.error,
  });

  //------------------------- Validate Fields  -------------------------
  bool get isOtpValid =>
      otp != null &&
      otp!.trim().isNotEmpty &&
      (otpErrorText == null || otpErrorText!.trim().isEmpty);

  bool get isPasswordValid =>
      password != null &&
      password!.trim().isNotEmpty &&
      (passwordErrorText == null || passwordErrorText!.trim().isEmpty);

  bool get isConfirmPasswordValid =>
      confirmPassword != null &&
      confirmPassword!.trim().isNotEmpty &&
      (confirmPasswordErrorText == null ||
          confirmPasswordErrorText!.trim().isEmpty);

  bool get isButtonEnabled =>
      isOtpValid && isPasswordValid && isConfirmPasswordValid;

  bool get isInitial => status == ResetPasswordStatus.initial;
  bool get isLoading => status == ResetPasswordStatus.loading;
  bool get isSuccess => status == ResetPasswordStatus.success;
  bool get isError => status == ResetPasswordStatus.error;

  factory ResetPasswordState.initial({
    String? email,
    String? otp,
  }) {
    return ResetPasswordState(
      email: email,
      otp: otp,
      status: ResetPasswordStatus.initial,
    );
  }

  ResetPasswordState copyWith({
    String? email,
    String? otp,
    String? password,
    String? confirmPassword,
    String? otpErrorText,
    String? passwordErrorText,
    String? confirmPasswordErrorText,
    ResetPasswordStatus? status,
    ResetPasswordResponse? success,
    Failure? error,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      otpErrorText: otpErrorText ?? this.otpErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      confirmPasswordErrorText:
          confirmPasswordErrorText ?? this.confirmPasswordErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        email,
        otp,
        password,
        confirmPassword,
        otpErrorText,
        passwordErrorText,
        confirmPasswordErrorText,
        status,
        success,
        error,
      ];
}
