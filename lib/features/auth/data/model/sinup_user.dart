import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';

/// =============
/// طلب التسجيل
/// =============
class SignUpUserRequest extends Equatable {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String nationalId;
  final String password;
  final String passwordConfirmation;
  final String nationalPhotoPath; // مسار الصورة في الجهاز

  const SignUpUserRequest({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.nationalId,
    required this.password,
    required this.passwordConfirmation,
    required this.nationalPhotoPath,
  });

  /// لتحويل البيانات العادية
  Map<String, String> toMap() {
    return {
      'full_name': fullName,
      'email': email,
      'mobile_number': mobileNumber,
      'national_id': nationalId,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  /// في حالة استخدام Multipart (عشان الصورة)
  Map<String, dynamic> toMultipartMap() {
    final map = Map<String, dynamic>.from(toMap());
    if (nationalPhotoPath != null) {
      map['national_photo'] = nationalPhotoPath;
    }
    return map;
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [
        fullName,
        email,
        mobileNumber,
        nationalId,
        password,
        passwordConfirmation,
        nationalPhotoPath,
      ];
}

/// =============
/// رد التسجيل
/// =============
class SignUpUserResponse extends Equatable {
  final String message;
  final AuthedUser user;
  final String? emailVerification; // ← أضفنا الحقل الجديد

  const SignUpUserResponse({
    required this.message,
    required this.user,
    this.emailVerification,
  });

  factory SignUpUserResponse.fromMap(Map<String, dynamic> map) {
    return SignUpUserResponse(
      message: map['message'] ?? '',
      user: AuthedUser.fromMap(map['user'] ?? {}),
      emailVerification: map['email_verification'], // ← اسم الحقل من JSON
    );
  }

  factory SignUpUserResponse.fromJson(String source) =>
      SignUpUserResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [message, user, emailVerification];
}
