import 'dart:convert';

class DeleteAccountResponse {
  final String message;

  DeleteAccountResponse({required this.message});

  factory DeleteAccountResponse.fromMap(Map<String, dynamic> map) {
    return DeleteAccountResponse(
      message: map['message'] ?? '',
    );
  }

  factory DeleteAccountResponse.fromJson(String source) =>
      DeleteAccountResponse.fromMap(jsonDecode(source));
}
