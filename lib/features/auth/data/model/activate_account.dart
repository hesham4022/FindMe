import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';

class ActivateAccountRequest extends Equatable {
  final String otp;
  final String username;

  const ActivateAccountRequest({
    required this.otp,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['username'] = username;
    return data;
  }

  String toJson() => jsonEncode(toMap());

  ActivateAccountRequest copyWith({
    String? username,
    String? otp,
  }) {
    return ActivateAccountRequest(
      username: username ?? this.username,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [otp, username];
}

//! ActivateAccountResponse ----------------------------------------------------
class ActivateAccountResponse extends Equatable {
  final String? token;
  final SuccessResponse? success;

  const ActivateAccountResponse({
    required this.token,
    this.success,
  });

  factory ActivateAccountResponse.fromMap(Map<String, dynamic> map) {
    return ActivateAccountResponse(
      token: map['token'],
      success: SuccessResponse.fromMap(map),
    );
  }

  factory ActivateAccountResponse.fromJson(String source) =>
      ActivateAccountResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [token, success];
}
