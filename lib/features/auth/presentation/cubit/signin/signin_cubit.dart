import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._authRepo,
    this._authLocal,
  ) : super(SignInState.initial());

  final AuthRepo _authRepo;
  final AuthLocal _authLocal;

  BaseUrlResponse? baseUrlInstance;

  /// وضع التطوير فقط: دخول بدون API
  static const bool allowAnonymousLogin = false;

  // -------------------- Inputs --------------------
  void usernameChanged(String value) {
    emit(state.copyWith(
      username: value,
      usernameErrorText: null,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      passwordErrorText: '',
    ));
  }

  void usernameErrorTextChanged(String value) {
    emit(state.copyWith(
      usernameErrorText: value.isEmpty ? null : value,
      status: SignInStatus.initial,
    ));
  }

  void passwordErrorTextChanged(String value) {
    emit(state.copyWith(
      passwordErrorText: value.isEmpty ? null : value,
      status: SignInStatus.initial,
    ));
  }

  void resetState() {
    emit(state.copyWith(
      status: SignInStatus.initial,
      error: null,
    ));
  }

  // -------------------- Submit --------------------
  Future<void> submitSignIn() async {
    if (state.isLoading) return;
    final passwordError = AppValidators.validateSignInPassword(state.password);
    final usernameError = AppValidators.validateEmail(state.username);

    if (passwordError != null || usernameError != null) {
      emit(state.copyWith(
        passwordErrorText: passwordError,
        usernameErrorText: usernameError,
        status: SignInStatus.initial,
      ));
      return;
    }

    emit(state.copyWith(status: SignInStatus.loading));

    final request = SignInUserRequest(
      email: state.username!,
      password: state.password!,
    );

    final result = await _authRepo.signin(request);

    result.fold(
      (error) {
        emit(state.copyWith(
          status: SignInStatus.error,
          error: error,
        ));
      },
      (data) async {
        await _authLocal.saveAccessToken(data.accessToken);
        await _authLocal.saveRefreshToken(data.refreshToken);

        emit(state.copyWith(
          status: SignInStatus.success,
          isActivated: true,
          user: data.user,
        ));
      },
    );
  }

  // -------------------- Guest Login --------------------
  Future<void> loginAsGuest() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: SignInStatus.loading));
    emit(state.copyWith(status: SignInStatus.success, isActivated: true));
  }
}
