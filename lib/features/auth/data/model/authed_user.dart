// import 'package:equatable/equatable.dart';

// class AuthedUser extends Equatable {
//   final int id;
//   final String fullName;
//   final String email;
//   final String mobileNumber;
//   final String nationalId;
//   final String? nationalPhoto;

//   const AuthedUser({
//     required this.id,
//     required this.fullName,
//     required this.email,
//     required this.mobileNumber,
//     required this.nationalId,
//     this.nationalPhoto,
//   });

//   factory AuthedUser.fromMap(Map<String, dynamic> map) {
//     return AuthedUser(
//       id: (map['id'] as num?)?.toInt() ?? 0,
//       fullName: map['full_name'] ?? '',
//       email: map['email'] ?? '',
//       mobileNumber: map['mobile_number'] ?? '',
//       nationalId: map['national_id'] ?? '',
//       nationalPhoto: map['national_photo'],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'full_name': fullName,
//         'email': email,
//         'mobile_number': mobileNumber,
//         'national_id': nationalId,
//         'national_photo': nationalPhoto,
//       };

//   @override
//   List<Object?> get props =>
//       [id, fullName, email, mobileNumber, nationalId, nationalPhoto];
// }

import 'package:equatable/equatable.dart';

class AuthedUser extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String nationalId;
  final String? nationalPhoto;

  final String? photo;
  final String? dateOfBirth;
  final String? language;
  final bool? soundEnable;
  final String? notificationEnable;
  final String? role;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? emailCode;

  const AuthedUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.nationalId,
    this.nationalPhoto,
    this.photo,
    this.dateOfBirth,
    this.language,
    this.soundEnable,
    this.notificationEnable,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.emailCode,
  });

  factory AuthedUser.fromMap(Map<String, dynamic> map) {
    return AuthedUser(
      id: (map['id'] as num?)?.toInt() ?? 0,
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobile_number'] ?? '',
      nationalId: map['national_id'] ?? '',
      nationalPhoto: map['national_photo'],
      photo: map['photo'],
      dateOfBirth: map['date_of_birth'],
      language: map['language'],
      soundEnable: map['sound_enable'],
      notificationEnable: map['notification_enable'],
      role: map['role'],
      emailVerifiedAt: map['email_verified_at'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      emailCode: map['email_code'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mobile_number': mobileNumber,
        'national_id': nationalId,
        'national_photo': nationalPhoto,
        'photo': photo,
        'date_of_birth': dateOfBirth,
        'language': language,
        'sound_enable': soundEnable,
        'notification_enable': notificationEnable,
        'role': role,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'email_code': emailCode,
      };

  AuthedUser copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? nationalId,
    String? nationalPhoto,
    String? photo,
    String? dateOfBirth,
    String? language,
    bool? soundEnable,
    String? notificationEnable,
    String? role,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? emailCode,
  }) {
    return AuthedUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      nationalId: nationalId ?? this.nationalId,
      nationalPhoto: nationalPhoto ?? this.nationalPhoto,
      photo: photo ?? this.photo,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      language: language ?? this.language,
      soundEnable: soundEnable ?? this.soundEnable,
      notificationEnable: notificationEnable ?? this.notificationEnable,
      role: role ?? this.role,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emailCode: emailCode ?? this.emailCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        mobileNumber,
        nationalId,
        nationalPhoto,
        photo,
        dateOfBirth,
        language,
        soundEnable,
        notificationEnable,
        role,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        emailCode,
      ];
}
