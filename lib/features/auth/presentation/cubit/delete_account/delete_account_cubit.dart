import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/delete_account.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final AuthRepo _authRepo;
  DeleteAccountCubit(this._authRepo) : super(const DeleteAccountState());

  Future<void> deleteAccount() async {
    if (state.isLoading) return;

    emit(state.copyWith(status: DeleteAccountStatus.loading));

    try {
      final result = await _authRepo.deleteAccount();

      result.fold(
        (error) {
          emit(state.copyWith(
            status: DeleteAccountStatus.error,
            error: error,
          ));
        },
        (message) {
          emit(state.copyWith(
            status: DeleteAccountStatus.success,
            success: DeleteAccountResponse(message: message),
          ));
        },
      );
    } catch (e, s) {
      log('❌ deleteAccount error: $e');
      log(s.toString());
      emit(state.copyWith(status: DeleteAccountStatus.error));
    }
  }
}
