import 'dart:developer';

import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/pages/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:find_me_app/core/services/location/location_service.dart';
import 'package:find_me_app/features/auth/data/model/base_url_response.dart';
import 'package:find_me_app/features/auth/data/model/signin_user.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._authRepo,
    this._authLocal,
    this._locationService,
  ) : super(SignInState.initial());

  final AuthRepo _authRepo;
  final AuthLocal _authLocal;
  final LocationService _locationService;

  BaseUrlResponse? baseUrlInstance;

  /// وضع التطوير فقط: دخول بدون API
  static const bool allowAnonymousLogin = false;

  // -------------------- Inputs --------------------
  void usernameChanged(String value) {
    emit(state.copyWith(
      username: value,
      status: SignInStatus.initial,
      usernameErrorText: null,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      status: SignInStatus.initial,
      passwordErrorText: null,
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

  // -------------------- Validation --------------------
  void validateFieldsBeforeSubmit(BuildContext context) {
    bool hasError = false;

    if (state.username == null || state.username!.trim().isEmpty) {
      emit(state.copyWith(usernameErrorText: "Field is required"));
      hasError = true;
    }

    if (state.password == null || state.password!.trim().isEmpty) {
      emit(state.copyWith(passwordErrorText: "Field is required"));
      hasError = true;
    }

    if (!hasError) submitSignIn(context);
  }

  // -------------------- Location --------------------
  Future<Position?> _getCurrentLocation() async {
    final result = await _locationService.getUserLocationCoordinates();
    return result.fold(
      (error) {
        // ما نوقفش عملية الدخول بسبب فشل اللوكيشن
        return null;
      },
      (position) => position,
    );
  }

  // -------------------- Base URL (اختياري) --------------------
  Future<void> ensureBaseUrl() async {
    if (state.baseUrlResponse != null) return;

    baseUrlInstance = await _authLocal.getBaseUrlResponse();
    if (baseUrlInstance != null) {
      emit(state.copyWith(baseUrlResponse: baseUrlInstance));
      return;
    }

    // مثال لاستخدام default Base URL من .env/Flavors
    // final fallback = BaseUrlResponse(mobileUrl: kDefaultBaseUrl);
    // await SharedPrefHelper.cacheBaseUrlResponse(fallback);
    // baseUrlInstance = fallback;
    // emit(state.copyWith(baseUrlResponse: fallback));
  }

  Future<void> loadCachedBaseUrlResponse() async {
    baseUrlInstance = await _authLocal.getBaseUrlResponse();
    if (baseUrlInstance != null) {
      emit(state.copyWith(baseUrlResponse: baseUrlInstance));
    }
  }

  void resetState() {
    emit(SignInState.initial());
  }

  // -------------------- Submit --------------------
  Future<void> submitSignIn(BuildContext context) async {
    if (state.isLoading) return;

    // 🧩 وضع التطوير: دخول بدون API
    if (allowAnonymousLogin) {
      emit(state.copyWith(status: SignInStatus.loading));
      emit(state.copyWith(
        status: SignInStatus.success,
        isActivated: true,
      ));
      return;
    }

    emit(state.copyWith(status: SignInStatus.loading));

    try {
      final request = SignInUserRequest(
        email: state.username!,
        password: state.password!,
      );

      print('📤 Request Body: ${request.toJson()}'); // للتأكد من البيانات

      final result = await _authRepo.signin(request);

      result.fold(
        (error) {
          emit(state.copyWith(status: SignInStatus.error, error: error));

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertSnackBar(
              context,
              error.msg,
              AlertType.error,
            );
          });
        },
        (data) async {
          await _authLocal.saveAccessToken(data.accessToken);
          await _authLocal.saveRefreshToken(data.refreshToken);
          context.read<HostCubit>().setAuthenticatedUser(data.user);
          emit(state.copyWith(
            status: SignInStatus.success,
            isActivated: true,
          ));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const HostView(currentIndex: 0),
              ),
              (route) => false,
            );
          });
        },
      );
    } on NavigateToVerifyEmailException catch (e) {
      // ⚠️ السيرفر رجّع 409 → محتاج تفعيل إيميل
      emit(state.copyWith(status: SignInStatus.success));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.toNamed(
          AppRoutes.verifyOTPRoute,
          arguments: VerifyOTPArgs(username: state.username ?? ''),
        );

        showAlertSnackBar(
          context,
          e.message ?? "Please verify your email before logging in.",
          AlertType.normal,
        );
      });
    } catch (e, s) {
      log("❌ submitSignIn error: $e");
      log("Stack: $s");

      emit(state.copyWith(status: SignInStatus.error));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAlertSnackBar(
          context,
          "Something went wrong. Please try again later.",
          AlertType.error,
        );
      });
    }
  }

  // -------------------- Guest Login --------------------
  Future<void> loginAsGuest() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: SignInStatus.loading));
    emit(state.copyWith(status: SignInStatus.success, isActivated: true));
  }
}
