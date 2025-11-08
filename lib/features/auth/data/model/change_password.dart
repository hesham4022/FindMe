import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChangePasswordRequest extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirm;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.newPasswordConfirm,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    data['newPasswordConfirmation'] = newPasswordConfirm;
    return data;
  }

  String toJson() => jsonEncode(toMap());

  ChangePasswordRequest copyWith({
    String? oldPassword,
    String? newPassword,
    String? newPasswordConfirm,
  }) {
    return ChangePasswordRequest(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirm: newPasswordConfirm ?? this.newPasswordConfirm,
    );
  }

  @override
  List<Object?> get props => [oldPassword, newPassword, newPasswordConfirm];
}
