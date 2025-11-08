import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';

import 'package:find_me_app/core/error_management/failure.dart';

enum ChangePasswordStatus { initial, loading, success, error }

class ChangePasswordState extends Equatable {
  final String? oldPassword;
  final String? newPassword;
  final String? confirmNewPassword;
  final String? oldPasswordErrorText;
  final String? newPasswordErrorText;
  final String? confirmPasswordErrorText;

  final ChangePasswordStatus status;
  final SuccessResponse? success;
  final Failure? error;

  const ChangePasswordState({
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
    this.oldPasswordErrorText,
    this.newPasswordErrorText,
    this.confirmPasswordErrorText,
    required this.status,
    this.success,
    this.error,
  });

//------------------------- Validate Fields  -------------------------
  bool get isOldPasswordValid =>
      oldPassword != null &&
      oldPassword!.trim().isNotEmpty &&
      (oldPasswordErrorText == null || oldPasswordErrorText!.trim().isEmpty);

  bool get isNewPasswordValid =>
      newPassword != null &&
      newPassword!.trim().isNotEmpty &&
      (newPasswordErrorText == null || newPasswordErrorText!.trim().isEmpty);

  bool get isConfirmNewPasswordValid =>
      confirmNewPassword != null &&
      confirmNewPassword!.trim().isNotEmpty &&
      (confirmPasswordErrorText == null ||
          confirmPasswordErrorText!.trim().isEmpty);

  bool get isButtonEnabled =>
      isOldPasswordValid && isNewPasswordValid && isConfirmNewPasswordValid;

  bool get isInitial => status == ChangePasswordStatus.initial;
  bool get isLoading => status == ChangePasswordStatus.loading;
  bool get isSuccess => status == ChangePasswordStatus.success;
  bool get isError => status == ChangePasswordStatus.error;

  factory ChangePasswordState.initial() {
    return ChangePasswordState(
      status: ChangePasswordStatus.initial,
    );
  }

  ChangePasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
    String? oldPasswordErrorText,
    String? newPasswordErrorText,
    String? confirmPasswordErrorText,
    ChangePasswordStatus? status,
    SuccessResponse? success,
    Failure? error,
  }) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      oldPasswordErrorText: oldPasswordErrorText ?? this.oldPasswordErrorText,
      newPasswordErrorText: newPasswordErrorText ?? this.newPasswordErrorText,
      confirmPasswordErrorText:
          confirmPasswordErrorText ?? this.confirmPasswordErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmNewPassword,
        oldPasswordErrorText,
        newPasswordErrorText,
        confirmPasswordErrorText,
        status,
        success,
        error,
      ];
}
