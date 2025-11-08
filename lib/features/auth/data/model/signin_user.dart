import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';

/// ---------------------------------------------------------------------------
/// AuthedUser
/// ---------------------------------------------------------------------------

/// ---------------------------------------------------------------------------
/// SignInUserRequest
/// ---------------------------------------------------------------------------
///
///
class SignInUserRequest extends Equatable {
  final String email; // سيتم إرسالها كـ "email"
  final String password;
  // final String deviceToken;
  // final bool rememberMe;
  // final String channel;
  // final String lat;
  // final String lng;
  // final String buildNumber;

  const SignInUserRequest({
    required this.email,
    required this.password,
    // required this.deviceToken,
    // this.rememberMe = true,
    // this.channel = 'MOBILE',
    // required this.lat,
    // required this.lng,
    // required this.buildNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email, // مهم جدًا: السيرفر مستني email
      'password': password,
      // 'deviceToken': deviceToken,
      // 'remember': rememberMe,
      // 'channel': channel,
      // 'lat': lat,
      // 'lng': lng,
      // 'buildNumber': buildNumber,
    };
  }

  String toJson() => jsonEncode(toMap());

  SignInUserRequest copyWith({
    String? email,
    String? password,
    String? deviceToken,
    bool? rememberMe,
    String? channel,
    String? lat,
    String? lng,
    String? buildNumber,
  }) {
    return SignInUserRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      // deviceToken: deviceToken ?? this.deviceToken,
      // rememberMe: rememberMe ?? this.rememberMe,
      // channel: channel ?? this.channel,
      // lat: lat ?? this.lat,
      // lng: lng ?? this.lng,
      // buildNumber: buildNumber ?? this.buildNumber,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        // deviceToken,
        // rememberMe,
        // channel,
        // lat,
        // lng,
        // buildNumber,
      ];
}

/// ---------------------------------------------------------------------------
/// SignInUserResponse
/// ---------------------------------------------------------------------------
class SignInUserResponse extends Equatable {
  final String message;
  final AuthedUser user;
  final String accessToken;
  final String refreshToken;
  final String tokenType; // غالبًا "bearer"
  final int expiresIn;

  const SignInUserResponse({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  Map<String, String> get authHeader => {
        'Authorization': '$tokenType $accessToken',
      };

  factory SignInUserResponse.fromMap(Map<String, dynamic> map) {
    return SignInUserResponse(
      message: (map['message'] as String?) ?? '',
      user: AuthedUser.fromMap(map['user'] as Map<String, dynamic>),
      accessToken: (map['access_token'] as String?) ?? '',
      refreshToken: (map['refresh_token'] as String?) ?? '',
      tokenType: (map['token_type'] as String?) ?? 'bearer',
      expiresIn: (map['expires_in'] as num?)?.toInt() ?? 0,
    );
  }

  factory SignInUserResponse.fromJson(String source) =>
      SignInUserResponse.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [message, user, accessToken, refreshToken, tokenType, expiresIn];
}
