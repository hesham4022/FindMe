import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileRequest extends Equatable {
  final String? fullName;
  final String? email;
  final String? mobileNumber;
  final String? photo;
  final DateTime? dateOfBirth;

  const UpdateProfileRequest({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dateOfBirth,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      if (fullName != null && fullName!.trim().isNotEmpty)
        'full_name': fullName!.trim(),
      if (email != null && email!.trim().isNotEmpty) 'email': email!.trim(),
      if (mobileNumber != null && mobileNumber!.trim().isNotEmpty)
        'mobile_number': mobileNumber!.trim(),
      if (dateOfBirth != null)
        'date_of_birth': DateFormat('yyyy-MM-dd').format(dateOfBirth!),
    };
  }

  Map<String, dynamic> toMultipartMap() {
    final map = Map<String, dynamic>.from(toMap());

    if (photo != null && photo!.isNotEmpty) {
      map['photo'] = photo;
    }

    return map;
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [
        fullName,
        email,
        photo,
        mobileNumber,
        dateOfBirth,
      ];
}

class UpdateProfileResponse extends Equatable {
  final String message;
  final ProfileData data;

  const UpdateProfileResponse({
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromMap(Map<String, dynamic> map) {
    return UpdateProfileResponse(
      message: map['message'] ?? '',
      data: ProfileData.fromMap(map['data'] ?? {}),
    );
  }

  factory UpdateProfileResponse.fromJson(String source) =>
      UpdateProfileResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [message, data];
}

/// ======================
/// 👤 Profile Data
/// ======================
class ProfileData extends Equatable {
  final int id;
  final String email;
  final String? emailVerifiedAt;
  final String fullName;
  final String mobileNumber;
  final String? dateOfBirth;
  final String? photo;
  final String? language;
  final bool soundEnable;
  final String notificationEnable;
  final String role;
  final String? nationalId;
  final String? nationalPhoto;
  final String createdAt;
  final String updatedAt;
  final String? emailCode;

  const ProfileData({
    required this.id,
    required this.email,
    this.emailVerifiedAt,
    required this.fullName,
    required this.mobileNumber,
    required this.dateOfBirth,
    this.photo,
    required this.language,
    required this.soundEnable,
    required this.notificationEnable,
    required this.role,
    this.nationalId,
    this.nationalPhoto,
    required this.createdAt,
    required this.updatedAt,
    required this.emailCode,
  });

  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      id: map['id'] ?? 0,
      email: map['email'] ?? '',
      emailVerifiedAt: map['email_verified_at'] ?? '',
      fullName: map['full_name'] ?? '',
      mobileNumber: map['mobile_number'] ?? '',
      dateOfBirth: map['date_of_birth'],
      photo: map['photo'] ?? '',
      language: map['language'],
      soundEnable: map['sound_enable'] ?? false,
      notificationEnable: map['notification_enable'] ?? '',
      role: map['role'] ?? '',
      nationalId: map['national_id'] ?? '',
      nationalPhoto: map['national_photo'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      emailCode: map['email_code'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        emailVerifiedAt,
        fullName,
        mobileNumber,
        dateOfBirth,
        photo,
        language,
        soundEnable,
        notificationEnable,
        role,
        nationalId,
        nationalPhoto,
        createdAt,
        updatedAt,
        emailCode,
      ];
}
