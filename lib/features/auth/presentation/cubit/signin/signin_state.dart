import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';
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
  final double? lat;
  final double? lng;
  final AuthedUser? user;
  const SignInState(
      {this.username,
      this.password,
      this.usernameErrorText,
      this.passwordErrorText,
      required this.status,
      this.success,
      this.error,
      this.isActivated = false,
      this.lat,
      this.lng,
      this.user});

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
  static const _noChange = Object();
  SignInState copyWith({
    String? username,
    String? password,
    Object? usernameErrorText = _noChange,
    Object? passwordErrorText = _noChange,
    SignInStatus? status,
    SuccessResponse? success,
    Failure? error,
    bool? isActivated,
    BaseUrlResponse? baseUrlResponse,
    double? lat,
    double? lng,
    AuthedUser? user,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameErrorText: usernameErrorText == _noChange
          ? this.usernameErrorText
          : usernameErrorText as String?,
      passwordErrorText: passwordErrorText == _noChange
          ? this.passwordErrorText
          : passwordErrorText as String?,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
      isActivated: isActivated ?? this.isActivated,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      user: user ?? this.user,
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
        lat,
        lng,
        user,
      ];
}
