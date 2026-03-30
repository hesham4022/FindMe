import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/data/model/sinup_user.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'sinup_state.dart';

class SinupCubit extends Cubit<SinupState> {
  SinupCubit(
    this._authRepo,
    this._authLocal,
    // this._locationService,
  ) : super(SinupState.initial());
  final AuthRepo _authRepo;
  final AuthLocal _authLocal;
  // final LocationService _locationService;

  bool get isFormValid {
    return AppValidators.validateUsername(state.fullName) == null &&
        AppValidators.validateEmail(state.email) == null &&
        AppValidators.validateEmail(state.password) == null &&
        AppValidators.validateEmail(state.passwordConfirmation) == null &&
        AppValidators.validateEmail(state.nationalId) == null &&
        AppValidators.validatePhoneNumber(state.nationalPhotoPath) == null;
  }

  void nameChanged(String value) {
    emit(state.copyWith(fullName: value, nameErrorText: null));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
        password: value, status: SinUpStatus.initial, passwordErrorText: null));
  }

  void passwordConfirmChanged(String value) {
    emit(state.copyWith(
        passwordConfirmation: value,
        status: SinUpStatus.initial,
        passwordConfirmationErrorText: null));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
        email: value, status: SinUpStatus.initial, emailErrorText: null));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(
        phone: value, status: SinUpStatus.initial, phoneErrorText: null));
  }

  void nationalIdChanged(String value) {
    emit(state.copyWith(
        nationalId: value,
        status: SinUpStatus.initial,
        nationalIdErrorText: null));
  }

  void nationalPhotoPathChanged(String value) {
    log("📦 nationalPhotoPathChanged called with: $value");
    emit(state.copyWith(
      nationalPhotoPath: value,
      status: SinUpStatus.initial,
      nationalPhotoPathErrorText: null,
    ));
  }

  void nameErrorTextChanged(String value) {
    emit(state.copyWith(
      nameErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void passwordErrorTextChanged(String value) {
    emit(state.copyWith(
      passwordErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void passwordConfirmErrorTextChanged(String value) {
    emit(state.copyWith(
      passwordConfirmationErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void emailErrorTextChanged(String value) {
    emit(state.copyWith(
      emailErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void phoneErrorTextChanged(String value) {
    emit(state.copyWith(
      phoneErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void nationalIdErrorTextChanged(String value) {
    emit(state.copyWith(
      nationalIdErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

  void nationalPhotoPathErrorTextChanged(String value) {
    emit(state.copyWith(
      nationalPhotoPathErrorText: value.isEmpty ? null : value,
      status: SinUpStatus.initial,
    ));
  }

// داخل SinupCubit
  List<XFile> nationalIdImages = [];

  Future<void> pickNationalIdImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> picked = await picker.pickMultiImage(imageQuality: 85);
      if (picked.isEmpty) return;

      nationalIdImages = [...picked];

      emit(state.copyWith(
        nationalPhotoPath: picked.first.path,
        nationalPhotoPathErrorText: null,
      ));
    } catch (e) {
      log('⚠️ pickNationalIdImages error: $e');
    }
  }

  void removeNationalIdImageAt(int index) {
    if (index < 0 || index >= nationalIdImages.length) {
      log("⚠️ Tried to remove invalid index: $index");
      return;
    }

    nationalIdImages.removeAt(index);

    if (nationalIdImages.isEmpty) {
      emit(state.copyWith(
          nationalPhotoPath: '',
          nationalPhotoPathErrorText: "Field is required"));
    } else {
      emit(state.copyWith(
        nationalPhotoPath: nationalIdImages.first.path,
        nationalPhotoPathErrorText: null, // اختفى الخطأ
      ));
    }

    log("🗑️ Image removed. Remaining: ${nationalIdImages.length}");
  }

  void reset() {
    emit(SinupState.initial());
  }

  void validateFieldsBeforeSinup(BuildContext context) {
    bool hasError = false;
    log("✅ validateFieldsBeforeSinup called");

    // full name
    if (state.fullName == null || state.fullName!.trim().isEmpty) {
      emit(state.copyWith(nameErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(nameErrorText: null));
    }

    // password
    if (state.password == null || state.password!.trim().isEmpty) {
      emit(state.copyWith(passwordErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(passwordErrorText: null));
    }

    // email
    if (state.email == null || state.email!.trim().isEmpty) {
      emit(state.copyWith(emailErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(emailErrorText: null));
    }

    // phone
    if (state.phone == null || state.phone!.trim().isEmpty) {
      emit(state.copyWith(phoneErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(phoneErrorText: null));
    }

    // national ID
    if (state.nationalId == null || state.nationalId!.trim().isEmpty) {
      emit(state.copyWith(nationalIdErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(nationalIdErrorText: null));
    }

    // national photo path
    if (state.nationalPhotoPath == null ||
        state.nationalPhotoPath!.trim().isEmpty) {
      emit(state.copyWith(nationalPhotoPathErrorText: "Field is required"));
      hasError = true;
    } else {
      emit(state.copyWith(nationalPhotoPathErrorText: null));
    }

    if (!hasError) {
      submitSinUp(context);
    } else {
      log("⛔ Some fields have error, signup stopped");
    }
  }

  // Future<void> submitSinUp(BuildContext context) async {
  //   if (state.isLoading) return;

  //   emit(state.copyWith(status: SinUpStatus.loading));

  //   final request = SignUpUserRequest(
  //     fullName: state.fullName!,
  //     email: state.email!,
  //     password: state.password!,
  //     mobileNumber: state.phone!,
  //     nationalId: state.nationalId!,
  //     nationalPhotoPath: state.nationalPhotoPath!,
  //     passwordConfirmation: state.passwordConfirmation!,
  //   );

  //   print('📤 Request Body: ${request.toJson()}');

  //   final result = await _authRepo.signup(request);

  //   result.fold(
  //     (failure) {
  //       // حالة الخطأ من السيرفر
  //       emit(state.copyWith(
  //         status: SinUpStatus.error,
  //         error: failure,
  //       ));

  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         showAlertSnackBar(
  //           context,
  //           failure.msg, // رسالة الخطأ من السيرفر
  //           AlertType.error,
  //         );
  //       });
  //     },
  //     (data) {
  //       // حفظ حالة emailVerification في الـ state لو تحب تستخدمها في Listener
  //       emit(state.copyWith(
  //         status: SinUpStatus.success,
  //         emailVerification: data.emailVerification,
  //       ));

  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         if (state.emailVerification != null &&
  //             state.emailVerification!
  //                 .toLowerCase()
  //                 .contains('check your email')) {
  //           // المستخدم غير مفعل → صفحة OTP
  //           context.toNamed(
  //             AppRoutes.verifyOTPRoute,
  //             arguments: VerifyOTPArgs(username: state.email ?? ''),
  //           );
  //         } else {
  //           // المستخدم مفعل → صفحة Host
  //           context.toNamed(AppRoutes.hostRoute);
  //         }
  //       });
  //     },
  //   );
  // }

  Future<void> submitSinUp(BuildContext context) async {
    if (state.isLoading) return;

    emit(state.copyWith(status: SinUpStatus.loading));

    final request = SignUpUserRequest(
      fullName: state.fullName!,
      email: state.email!,
      password: state.password!,
      mobileNumber: state.phone!,
      nationalId: state.nationalId!,
      nationalPhotoPath: state.nationalPhotoPath!,
      passwordConfirmation: state.passwordConfirmation!,
    );

    print("-------------------------------");
    print('📤 Request Body: ${request.toJson()}');
    print("-------------------------------");
    try {
      // 🧩 استدعاء الريبو
      final result = await _authRepo.signup(request);

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: SinUpStatus.error,
            error: failure,
          ));

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertSnackBar(
              context,
              failure.msg,
              AlertType.error,
            );
          });
        },
        (data) {
          emit(state.copyWith(status: SinUpStatus.success));
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // ✅ حط اليوزر في HostCubit
            await context.read<HostCubit>().setAuthenticatedUser(data.user);
            context.toNamed(AppRoutes.hostRoute);
          });
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   context.toNamed(AppRoutes.hostRoute);
          // });
        },
      );
    } on NavigateToVerifyEmailException catch (e) {
      // ⚠️ حالة الكود 409 → الحساب محتاج تفعيل بالإيميل
      emit(state.copyWith(status: SinUpStatus.success));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.toNamed(
          AppRoutes.verifyOTPRoute,
          arguments: VerifyOTPArgs(username: state.email ?? ''),
        );

        showAlertSnackBar(
          context,
          e.message ?? "Please check your email to verify your account.",
          AlertType.normal,
        );
      });
    } catch (e, s) {
      // 🔥 أي خطأ غير متوقع
      log("❌ submitSinUp error: $e");
      log("Stack: $s");

      emit(state.copyWith(status: SinUpStatus.error));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAlertSnackBar(
          context,
          "Something went wrong. Please try again later.",
          AlertType.error,
        );
      });
    }
  }
}
