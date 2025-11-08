import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';

/// =============
/// طلب إعادة تعيين كلمة المرور
/// =============
class ResetPasswordRequest extends Equatable {
  final String email;
  final String otp;
  final String password;
  final String passwordConfirmation;

  const ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [email, otp, password, passwordConfirmation];
}

/// =============
/// رد إعادة تعيين كلمة المرور (Reset Password Response)
/// =============
class ResetPasswordResponse extends Equatable {
  final String message;
  final AuthedUser user;
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  const ResetPasswordResponse({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory ResetPasswordResponse.fromMap(Map<String, dynamic> map) {
    return ResetPasswordResponse(
      message: map['message'] ?? '',
      user: AuthedUser.fromMap(map['user'] ?? {}),
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      expiresIn: map['expires_in'] ?? 0,
    );
  }

  factory ResetPasswordResponse.fromJson(String source) =>
      ResetPasswordResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [message, user, accessToken, refreshToken, tokenType, expiresIn];
}
