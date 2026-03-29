part of 'update_profile_cubit.dart';

enum UpdateProfileStatus {
  initial,
  loading,
  success,
  error,
}

class UpdateProfileState extends Equatable {
  final String? fullName;
  final String? email;
  final String? mobileNumber;
  final String? photo;
  final DateTime? dateOfBirth;

  //
  final String? fullNameErrorText;
  final String? emailErrorText;
  final String? mobileNumberErrorText;
  final String? photoError;
  final String? dateOfBirthErrorText;

  final UpdateProfileRequest? updateProfileRequest;
  final UpdateProfileStatus status;
  final UpdateProfileResponse? success;
  final Failure? error;

  const UpdateProfileState({
    this.fullName,
    this.email,
    this.mobileNumber,
    this.photo,
    this.dateOfBirth,
    this.fullNameErrorText,
    this.emailErrorText,
    this.mobileNumberErrorText,
    this.dateOfBirthErrorText,
    this.photoError,
    this.updateProfileRequest,
    required this.status,
    this.success,
    this.error,
  });
  static const _sentinel = Object();
  UpdateProfileState copyWith({
    Object? photo = _sentinel,
    String? fullName,
    String? email,
    String? mobileNumber,
    // String? photo,
    DateTime? dateOfBirth,
    String? fullNameErrorText,
    String? emailErrorText,
    String? mobileNumberErrorText,
    String? photoError,
    String? dateOfBirthErrorText,
    UpdateProfileRequest? updateProfileRequest,
    UpdateProfileStatus? status,
    UpdateProfileResponse? success,
    Failure? error,
  }) {
    return UpdateProfileState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      // photo: photo ?? this.photo,
      photo: photo == _sentinel ? this.photo : photo as String?,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      fullNameErrorText: fullNameErrorText ?? this.fullNameErrorText,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      mobileNumberErrorText:
          mobileNumberErrorText ?? this.mobileNumberErrorText,
      photoError: photoError ?? this.photoError,
      dateOfBirthErrorText: dateOfBirthErrorText ?? this.dateOfBirthErrorText,
      updateProfileRequest: updateProfileRequest ?? this.updateProfileRequest,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  bool get isInitial => status == UpdateProfileStatus.initial;
  bool get isLoading => status == UpdateProfileStatus.loading;
  bool get isSuccess => status == UpdateProfileStatus.success;
  bool get isError => status == UpdateProfileStatus.error;

  factory UpdateProfileState.initial() {
    return const UpdateProfileState(
      status: UpdateProfileStatus.initial,
      fullName: '',
      email: '',
      mobileNumber: '',
      photo: null,
      dateOfBirth: null,
      updateProfileRequest: null,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        mobileNumber,
        photo,
        dateOfBirth,
        fullNameErrorText,
        emailErrorText,
        mobileNumberErrorText,
        photoError,
        dateOfBirthErrorText,
        updateProfileRequest,
        status,
        success,
        error,
      ];
}
