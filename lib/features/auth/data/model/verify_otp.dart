import 'dart:convert';

import 'package:find_me_app/features/auth/data/model/authed_user.dart';

class VerifyOtpResponse {
  final String message;
  final AuthedUser user;
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  VerifyOtpResponse({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory VerifyOtpResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponse(
      message: map['message'] ?? '',
      user: AuthedUser.fromMap(map['user'] ?? {}),
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      expiresIn: map['expires_in'] ?? 0,
    );
  }

  factory VerifyOtpResponse.fromJson(String source) =>
      VerifyOtpResponse.fromMap(jsonDecode(source));
}

class VerifyOtpRequest {
  final String username;
  final String otp;

  VerifyOtpRequest({
    required this.username,
    required this.otp,
  });

  Map<String, dynamic> toMap() => {
        "username": username,
        "otp": otp,
      };

  String toJson() => jsonEncode(toMap());
}
