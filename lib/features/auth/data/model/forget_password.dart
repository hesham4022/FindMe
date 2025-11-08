import 'dart:convert';
import 'package:equatable/equatable.dart';

class ForgetPasswordRequest extends Equatable {
  final String email;

  const ForgetPasswordRequest({required this.email});

  Map<String, String> toMap() {
    return {'email': email};
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [email];
}

class ForgetPasswordResponse extends Equatable {
  final String status;
  final String message;

  const ForgetPasswordResponse({
    required this.status,
    required this.message,
  });

  factory ForgetPasswordResponse.fromMap(Map<String, dynamic> map) {
    return ForgetPasswordResponse(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory ForgetPasswordResponse.fromJson(String source) =>
      ForgetPasswordResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [status, message];
}
