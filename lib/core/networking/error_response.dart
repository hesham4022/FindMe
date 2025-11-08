// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorResponse {
  final int? code;
  final Map<String, dynamic>? errors;
  final String? msg;

  ErrorResponse({
    this.errors,
    this.msg,
    this.code,
  });

  static String? _getMultiErrorsMessage(Map<String, dynamic>? errors) {
    String message = "";
    if (errors != null) {
      for (var key in errors.keys) {
        message += errors[key].first + ((key != errors.keys.last) ? ", " : "");
      }
      return message;
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msg': msg,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      errors: map['errors'],
      msg: map['message'] ?? _getMultiErrorsMessage(map['errors']),
      code: map['statusCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(jsonDecode(source));

  @override
  String toString() => 'ErrorResponse(msg: $msg\n code: $code)';
}

//! General Response
class ParseGeneralResponse {
  final int? code;
  final String? msg;

  ParseGeneralResponse({
    required this.code,
    required this.msg,
  });

  factory ParseGeneralResponse.fromMap(Map<String, dynamic> map) {
    return ParseGeneralResponse(
      code: map['status'] is Map?
          ? (map['status']?['code'] ?? map['code'])
          : null,
      msg: map['status'] is Map?
          ? (map['status']?['message'] ?? map['message'])
          : null,
    );
  }

  factory ParseGeneralResponse.fromJson(String source) =>
      ParseGeneralResponse.fromMap(jsonDecode(source));
}
