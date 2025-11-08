import 'package:equatable/equatable.dart';

class AuthedUser extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String nationalId;
  final String? nationalPhoto;

  const AuthedUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.nationalId,
    this.nationalPhoto,
  });

  factory AuthedUser.fromMap(Map<String, dynamic> map) {
    return AuthedUser(
      id: (map['id'] as num?)?.toInt() ?? 0,
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobile_number'] ?? '',
      nationalId: map['national_id'] ?? '',
      nationalPhoto: map['national_photo'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mobile_number': mobileNumber,
        'national_id': nationalId,
        'national_photo': nationalPhoto,
      };

  @override
  List<Object?> get props =>
      [id, fullName, email, mobileNumber, nationalId, nationalPhoto];
}
