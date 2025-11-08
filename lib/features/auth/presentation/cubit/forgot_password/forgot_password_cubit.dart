import 'package:find_me_app/features/auth/data/model/forget_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepo) : super(ForgotPasswordState.initial());

  final AuthRepo _authRepo;

  // ===================
  // تحديث البريد الإلكتروني
  // ===================
  void emailChanged(String value) {
    emit(state.copyWith(
      email: value.trim(),
      emailErrorText: null, // ← نفضي رسالة الخطأ عند التغيير
      status: Status.initial,
    ));
  }

  void emailErrorTextChanged(String value) {
    emit(
      state.copyWith(
        emailErrorText: value,
        status: Status.initial,
      ),
    );
  }

  // ===================
  // إرسال الطلب
  // ===================
  Future<void> submit() async {
    if (state.isLoading) return;

    // تحقق بسيط قبل الإرسال
    if (state.email == null || state.email!.isEmpty) {
      emit(state.copyWith(emailErrorText: "البريد الإلكتروني مطلوب"));
      return;
    }

    emit(state.copyWith(status: Status.loading));

    final request = ForgetPasswordRequest(email: state.email!);

    final result = await _authRepo.forgetPassword(request);

    result.fold(
      // في حالة الخطأ
      (Failure error) => emit(
        state.copyWith(
          status: Status.error,
          error: error,
          emailErrorText: error.msg,
        ),
      ),
      // في حالة النجاح
      (success) {
        emit(state.copyWith(
          status: Status.success,
          success: success,
          error: null,
          emailErrorText: null,
        ));
      },
    );
  }
}
