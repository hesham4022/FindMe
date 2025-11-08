import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';

import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/forget_password.dart';

enum Status { initial, loading, success, error }

class ForgotPasswordState extends Equatable {
  final String? email;
  final String? emailErrorText;
  final Status status;
  final ForgetPasswordResponse? success;
  final Failure? error;

  const ForgotPasswordState({
    this.email,
    this.emailErrorText,
    required this.status,
    this.success,
    this.error,
  });

//------------------------- Validate Fields  -------------------------

  bool get isEmailValid =>
      email != null &&
      email!.trim().isNotEmpty &&
      (emailErrorText == null || emailErrorText!.trim().isEmpty);

  // bool get isButtonEnabled => isEmailValid && isTokenIDValid;

  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      status: Status.initial,
    );
  }

  ForgotPasswordState copyWith({
    int? tokenID,
    String? tokenIDErrorText,
    String? email,
    String? emailErrorText,
    Status? status,
    ForgetPasswordResponse? success,
    Failure? error,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailErrorText,
        status,
        success,
        error,
      ];
}
