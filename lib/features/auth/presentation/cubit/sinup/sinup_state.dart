part of 'sinup_cubit.dart';

enum SinUpStatus {
  initial,
  loading,
  success,
  error,
}

class SinupState extends Equatable {
  final String? fullName;
  final String? password;
  final String? passwordConfirmation;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? nationalPhotoPath;
  final String? nameErrorText;
  final String? passwordErrorText;
  final String? passwordConfirmationErrorText;
  final String? emailErrorText;
  final String? phoneErrorText;
  final String? nationalIdErrorText;
  final String? nationalPhotoPathErrorText;
  final SinUpStatus status;
  final SignUpUserResponse? success;
  final Failure? error;
  final String? emailVerification;
  final List<XFile> nationalIdImages;
  const SinupState({
    this.fullName,
    this.password,
    this.passwordConfirmation,
    this.email,
    this.phone,
    this.nationalId,
    this.nationalPhotoPath,
    this.nameErrorText,
    this.passwordErrorText,
    this.passwordConfirmationErrorText,
    required this.status,
    this.success,
    this.error,
    this.emailErrorText,
    this.nationalIdErrorText,
    this.phoneErrorText,
    this.nationalPhotoPathErrorText,
    required this.nationalIdImages,
    this.emailVerification,
  });

  SinupState copyWith({
    String? fullName,
    String? password,
    String? passwordConfirmation,
    String? email,
    String? phone,
    String? nationalId,
    String? nationalPhotoPath,
    String? nameErrorText,
    String? passwordErrorText,
    String? passwordConfirmationErrorText,
    String? emailErrorText,
    String? phoneErrorText,
    String? nationalIdErrorText,
    String? nationalPhotoPathErrorText,
    SinUpStatus? status,
    SignUpUserResponse? success,
    Failure? error,
    String? emailVerification,
    final List<XFile>? nationalIdImages,
  }) {
    return SinupState(
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      nationalPhotoPath: nationalPhotoPath ?? this.nationalPhotoPath,
      nameErrorText: nameErrorText ?? this.nameErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      passwordConfirmationErrorText:
          passwordConfirmationErrorText ?? this.passwordConfirmationErrorText,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      phoneErrorText: phoneErrorText ?? this.phoneErrorText,
      nationalIdErrorText: nationalIdErrorText ?? this.nationalIdErrorText,
      nationalPhotoPathErrorText:
          nationalPhotoPathErrorText ?? this.nationalPhotoPathErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
      emailVerification: emailVerification ?? this.emailVerification,
      nationalIdImages: nationalIdImages ?? this.nationalIdImages,
    );
  }

  bool get isInitial => status == SinUpStatus.initial;
  bool get isLoading => status == SinUpStatus.loading;
  bool get isSuccess => status == SinUpStatus.success;
  bool get isError => status == SinUpStatus.error;

  factory SinupState.initial() {
    return const SinupState(
      status: SinUpStatus.initial,
      fullName: '',
      password: '',
      email: '',
      phone: '',
      nationalId: '',
      nationalIdImages: [],
      nameErrorText: null,
      passwordErrorText: null,
      emailErrorText: null,
      phoneErrorText: null,
      nationalIdErrorText: null,
      nationalPhotoPathErrorText: null,
      success: null,
      error: null,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        password,
        passwordConfirmation,
        email,
        phone,
        nationalId,
        nationalPhotoPath, // ✅ أضف ده
        nameErrorText,
        passwordErrorText,
        passwordConfirmationErrorText,
        emailErrorText,
        phoneErrorText,
        nationalIdErrorText,
        nationalPhotoPathErrorText, // (اختياري)
        status,
        success,
        error,
        emailVerification,
        nationalIdImages,
      ];
}
