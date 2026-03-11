// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/core/networking/success_response.dart';

// import 'package:find_me_app/core/error_management/failure.dart';
// import 'package:find_me_app/features/auth/data/model/base_url_response.dart';

// enum SignInStatus {
//   initial,
//   loading,
//   success,
//   error,
//   tokenIsLoading,
//   tokenIsValid,
//   tokenIsInvalidError
// }

// class SignInState extends Equatable {
//   final int? tokenID;
//   final String? username;
//   final String? password;
//   final String? tokenIDErrorText;
//   final String? usernameErrorText;
//   final String? passwordErrorText;
//   final SignInStatus status;
//   final SuccessResponse? success;
//   final Failure? error;
//   final bool isActivated;
//   final BaseUrlResponse? baseUrlResponse;
//   final double? lat;
//   final double? lng;

//   const SignInState({
//     this.tokenID,
//     this.username,
//     this.password,
//     this.tokenIDErrorText,
//     this.usernameErrorText,
//     this.passwordErrorText,
//     required this.status,
//     this.success,
//     this.error,
//     this.isActivated = false,
//     this.baseUrlResponse,
//     this.lng,
//     this.lat,
//   });

// //------------------------- Validate Fields  -------------------------
//   bool get isTokenIDValid =>
//       tokenID != null &&
//       // tokenID!.trim().isNotEmpty &&
//       (tokenIDErrorText == null || tokenIDErrorText!.trim().isEmpty);
//   // && baseUrlResponse != null;

//   bool get isUsernameValid =>
//       username != null &&
//       username!.trim().isNotEmpty &&
//       (usernameErrorText == null || usernameErrorText!.trim().isEmpty);

//   bool get isPasswordValid =>
//       password != null &&
//       password!.trim().isNotEmpty &&
//       (passwordErrorText == null || passwordErrorText!.trim().isEmpty);

//   bool get isButtonEnabled =>
//       isTokenIDValid &&
//       isUsernameValid &&
//       isPasswordValid &&
//       baseUrlResponse != null;

//   bool get isInitial => status == SignInStatus.initial;
//   bool get isLoading => status == SignInStatus.loading;
//   bool get isSuccess => status == SignInStatus.success;
//   bool get isError => status == SignInStatus.error;
//   bool get isTokenIsLoading => status == SignInStatus.tokenIsLoading;
//   bool get isTokenIsValid => status == SignInStatus.tokenIsValid;
//   bool get isTokenIsInvalid => status == SignInStatus.tokenIsInvalidError;

//   factory SignInState.initial() {
//     return SignInState(
//       status: SignInStatus.initial,
//     );
//   }

//   SignInState copyWith({
//     int? tokenID,
//     String? username,
//     String? password,
//     String? tokenIDErrorText,
//     String? usernameErrorText,
//     String? passwordErrorText,
//     SignInStatus? status,
//     SuccessResponse? success,
//     Failure? error,
//     bool? isActivated,
//     BaseUrlResponse? baseUrlResponse,
//     double? lat,
//     double? lng,
//   }) {
//     return SignInState(
//       tokenID: tokenID ?? this.tokenID,
//       username: username ?? this.username,
//       password: password ?? this.password,
//       tokenIDErrorText: tokenIDErrorText ?? this.tokenIDErrorText,
//       usernameErrorText: usernameErrorText ?? this.usernameErrorText,
//       passwordErrorText: passwordErrorText ?? this.passwordErrorText,
//       status: status ?? this.status,
//       success: success ?? this.success,
//       error: error ?? this.error,
//       isActivated: isActivated ?? this.isActivated,
//       baseUrlResponse: baseUrlResponse ?? this.baseUrlResponse,
//       lat: lat ?? this.lat,
//       lng: lng ?? this.lng,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         tokenID,
//         username,
//         password,
//         tokenIDErrorText,
//         usernameErrorText,
//         passwordErrorText,
//         status,
//         success,
//         error,
//         isActivated,
//         lat,
//         lng,
//       ];
// }

import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';

enum SignInStatus {
  initial,
  loading,
  success,
  error,
}

class SignInState extends Equatable {
  final String? username;
  final String? password;
  final String? usernameErrorText;
  final String? passwordErrorText;
  final SignInStatus status;
  final SuccessResponse? success;
  final Failure? error;
  final bool isActivated;
  final BaseUrlResponse? baseUrlResponse; // لو لسه عايزه داخليًا
  final double? lat;
  final double? lng;

  const SignInState({
    this.username,
    this.password,
    this.usernameErrorText,
    this.passwordErrorText,
    required this.status,
    this.success,
    this.error,
    this.isActivated = false,
    this.baseUrlResponse,
    this.lat,
    this.lng,
  });

  // ------------------------- Validate Fields -------------------------
  // bool get isUsernameValid =>
  //     (username?.trim().isNotEmpty ?? false) &&
  //     (usernameErrorText == null || usernameErrorText!.trim().isEmpty);

  // bool get isPasswordValid =>
  //     (password?.trim().isNotEmpty ?? false) &&
  //     (passwordErrorText == null || passwordErrorText!.trim().isEmpty);

  // bool get isButtonEnabled => isUsernameValid && isPasswordValid;

  bool get isUsernameValid =>
      (username?.trim().isNotEmpty ?? false) &&
      (usernameErrorText?.trim().isEmpty ?? true);

  bool get isPasswordValid =>
      (password?.trim().isNotEmpty ?? false) &&
      (passwordErrorText?.trim().isEmpty ?? true);

// لو عايز تمنع الضغط أثناء اللودينج:
  bool get isButtonEnabled =>
      isUsernameValid && isPasswordValid /* && !isLoading */;

  // لو لازم وجود baseUrlResponse علشان الـ sign-in يشتغل فعلاً، فعّل السطر الجاي:
  // && baseUrlResponse != null;

  bool get isInitial => status == SignInStatus.initial;
  bool get isLoading => status == SignInStatus.loading;
  bool get isSuccess => status == SignInStatus.success;
  bool get isError => status == SignInStatus.error;

  factory SignInState.initial() {
    return const SignInState(
      status: SignInStatus.initial,
      username: '',
      password: '',
    );
  }

  SignInState copyWith({
    String? username,
    String? password,
    String? usernameErrorText,
    String? passwordErrorText,
    SignInStatus? status,
    SuccessResponse? success,
    Failure? error,
    bool? isActivated,
    BaseUrlResponse? baseUrlResponse,
    double? lat,
    double? lng,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameErrorText: usernameErrorText ?? this.usernameErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
      isActivated: isActivated ?? this.isActivated,
      baseUrlResponse: baseUrlResponse ?? this.baseUrlResponse,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        usernameErrorText,
        passwordErrorText,
        status,
        success,
        error,
        isActivated,
        baseUrlResponse, // مهم يتضاف علشان أي تغيير فيه يعمل rebuild لو بتعتمد عليه
        lat,
        lng,
      ];
}
