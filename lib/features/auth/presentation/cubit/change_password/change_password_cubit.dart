// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:find_me_app/features/auth/data/model/change_password.dart';
// import 'package:find_me_app/features/auth/data/model/reset_password.dart';
// import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
// import 'package:find_me_app/features/auth/presentation/cubit/change_password/change_password_state.dart';

// class ChangePasswordCubit extends Cubit<ChangePasswordState> {
//   ChangePasswordCubit(
//     this._authRepo,
//   ) : super(ChangePasswordState.initial());

//   final AuthRepo _authRepo;

//   void oldPasswordChanged(String value) {
//     emit(state.copyWith(
//       oldPassword: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   void newPasswordChanged(String value) {
//     emit(state.copyWith(
//       newPassword: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   void confirmPasswordChanged(String value) {
//     emit(state.copyWith(
//       confirmNewPassword: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   void oldPasswordErrorTextChanged(String value) {
//     emit(state.copyWith(
//       oldPasswordErrorText: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   void newPasswordErrorTextChanged(String value) {
//     emit(state.copyWith(
//       newPasswordErrorText: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   void confirmPasswordErrorTextChanged(String value) {
//     emit(state.copyWith(
//       confirmPasswordErrorText: value,
//       status: ChangePasswordStatus.initial,
//     ));
//   }

//   Future<void> resetPassword() async {
//     if (state.isLoading) {
//       return;
//     }

//     emit(state.copyWith(status: ChangePasswordStatus.loading));

//     final ResetPasswordRequest user = ResetPasswordRequest(
//       password: state.oldPassword!,
//       confirmPassword: "",
//       token: "",
//     );

//     // 2. Call Api
//     final result = await _authRepo.resetPassword(user);

//     result.fold(
//       // 3. In case of error state
//       (error) => emit(
//         state.copyWith(
//           status: ChangePasswordStatus.error,
//           error: error,
//         ),
//       ),
//       // 4. In case of success state
//       (success) {
//         emit(state.copyWith(
//           status: ChangePasswordStatus.success,
//           success: success,
//           error: null,
//         ));
//       },
//     );
//   }

//   Future<void> changePassword() async {
//     if (state.isLoading) {
//       return;
//     }

//     emit(state.copyWith(status: ChangePasswordStatus.loading));

//     final user = ChangePasswordRequest(
//       oldPassword: state.oldPassword!,
//       newPassword: state.newPassword!,
//       newPasswordConfirm: state.confirmNewPassword!,
//     );

//     // 2. Call Api
//     final result = await _authRepo.changePassword(user);

//     result.fold(
//       // 3. In case of error state
//       (error) => emit(
//         state.copyWith(
//           status: ChangePasswordStatus.error,
//           error: error,
//         ),
//       ),
//       // 4. In case of success state
//       (success) {
//         emit(state.copyWith(
//           status: ChangePasswordStatus.success,
//           success: success,
//           error: null,
//         ));
//       },
//     );
//   }
// }
