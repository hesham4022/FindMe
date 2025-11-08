// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SuccessResponse extends Equatable {
  final int? code;
  final String? msg;

  const SuccessResponse({
    this.code,
    this.msg,
  });

  @override
  List<Object?> get props => [msg];

  factory SuccessResponse.fromMap(Map<String, dynamic> map) {
    return SuccessResponse(
      code: map["status"]['code'],
      msg: map["status"]['message'],
    );
  }

  factory SuccessResponse.fromJson(String source) =>
      SuccessResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
