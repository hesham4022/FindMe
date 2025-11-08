import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/features/auth/data/model/reset_password.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
import 'package:find_me_app/features/auth/presentation/pages/reset_password.dart';

class ResetPasswordArgs extends Equatable {
  final String email;

  const ResetPasswordArgs({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepo _authRepo;
  final ResetPasswordArgs args;

  ResetPasswordCubit(
    this._authRepo,
    this.args,
  ) : super(
          ResetPasswordState.initial(
            email: args.email,
          ),
        );

  //--------------- FIELD CHANGES ---------------
  void otpChanged(String value) {
    emit(state.copyWith(
      otp: value,
      otpErrorText: null,
      status: ResetPasswordStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      passwordErrorText: null,
      status: ResetPasswordStatus.initial,
    ));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(
      confirmPassword: value,
      confirmPasswordErrorText: null,
      status: ResetPasswordStatus.initial,
    ));
  }

  void passwordErrorTextChanged(String? value) {
    emit(state.copyWith(
      passwordErrorText: value,
      status: ResetPasswordStatus.initial,
    ));
  }

  void confirmPasswordErrorTextChanged(String? value) {
    emit(state.copyWith(
      confirmPasswordErrorText: value,
      status: ResetPasswordStatus.initial,
    ));
  }

  void otpErrorTextChanged(String? value) {
    emit(state.copyWith(
      otpErrorText: value,
      status: ResetPasswordStatus.initial,
    ));
  }

  //--------------- VALIDATION LOGIC ---------------
  bool validateFields() {
    bool hasError = false;

    if (state.otp == null || state.otp!.isEmpty) {
      emit(state.copyWith(otpErrorText: "رمز التحقق مطلوب"));
      hasError = true;
    }

    if (state.password == null || state.password!.isEmpty) {
      emit(state.copyWith(passwordErrorText: "كلمة المرور مطلوبة"));
      hasError = true;
    }

    if (state.confirmPassword == null || state.confirmPassword!.isEmpty) {
      emit(state.copyWith(confirmPasswordErrorText: "تأكيد كلمة المرور مطلوب"));
      hasError = true;
    }

    if (state.password != null &&
        state.confirmPassword != null &&
        state.password != state.confirmPassword) {
      emit(state.copyWith(
        confirmPasswordErrorText: "كلمتا المرور غير متطابقتين",
      ));
      hasError = true;
    }

    return !hasError;
  }

  //--------------- RESET PASSWORD FUNCTION ---------------
  Future<void> resetPassword() async {
    if (state.isLoading) return;
    if (!validateFields()) return;

    emit(state.copyWith(status: ResetPasswordStatus.loading));

    final request = ResetPasswordRequest(
      email: state.email!, // ✅ الإيميل جاي من args
      otp: state.otp!,
      password: state.password!,
      passwordConfirmation: state.confirmPassword!,
    );

    final result = await _authRepo.resetPassword(request);

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ResetPasswordStatus.error,
          error: error,
        ),
      ),
      (success) => emit(
        state.copyWith(
          status: ResetPasswordStatus.success,
          success: success,
          error: null,
        ),
      ),
    );
  }
}
