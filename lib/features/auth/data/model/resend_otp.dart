import 'dart:convert';
import 'package:equatable/equatable.dart';

/// =============
/// طلب إعادة إرسال كود التحقق
/// =============
class ResendOtpRequest extends Equatable {
  final String email;

  const ResendOtpRequest({
    required this.email,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [email];
}

/// =============
/// رد إعادة إرسال كود التحقق
/// =============
class ResendOtpResponse extends Equatable {
  final String message;

  const ResendOtpResponse({
    required this.message,
  });

  factory ResendOtpResponse.fromMap(Map<String, dynamic> map) {
    return ResendOtpResponse(
      message: map['message'] ?? '',
    );
  }

  factory ResendOtpResponse.fromJson(String source) =>
      ResendOtpResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [message];
}
