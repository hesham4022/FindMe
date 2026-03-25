import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';

part 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  HostCubit(
    int initialIndex,
    this._authLocal,
  ) : super(HostState.initial(initialIndex));

  final AuthLocal _authLocal;
  List<int> tabHistory = [0];

  Future<void> loadCachedUser() async {
    try {
      emit(state.copyWith(status: HostStatus.loading, clearFailure: true));

      final isLoggedIn = _authLocal.isUserLoggedIn();

      if (!isLoggedIn) {
        emit(
          state.copyWith(
            clearUser: true,
            status: HostStatus.unauthenticated,
            clearFailure: true,
          ),
        );
        return;
      }

      final user = await _authLocal.getCachedAuthedUser();

      emit(
        state.copyWith(
          user: user,
          status: HostStatus.authenticated,
          clearFailure: true,
        ),
      );
    } on UserTokenException catch (e) {
      emit(
        state.copyWith(
          clearUser: true,
          status: HostStatus.failure,
          failure: UserTokenFailure(e.msg),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          clearUser: true,
          status: HostStatus.unauthenticated,
          failure: Failure(e.toString()),
        ),
      );
    }
  }

  Future<void> setAuthenticatedUser(AuthedUser user) async {
    await _authLocal.saveUser(user);

    emit(
      state.copyWith(
        user: user,
        status: HostStatus.authenticated,
        clearFailure: true,
      ),
    );
  }

  Future<void> updateCurrentUser(AuthedUser user) async {
    await _authLocal.saveUser(user);

    emit(
      state.copyWith(
        user: user,
        status: HostStatus.authenticated,
        clearFailure: true,
      ),
    );
  }

  void changeIndex(int index) {
    if (index == state.selectedIndex) return;

    if (tabHistory.isEmpty || tabHistory.last != index) {
      tabHistory.add(index);
    }

    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> getUserData() async {
    try {
      emit(state.copyWith(status: HostStatus.loading, clearFailure: true));

      final authedUser = await _authLocal.getCachedAuthedUser();

      emit(
        state.copyWith(
          user: authedUser,
          status: HostStatus.authenticated,
          clearFailure: true,
        ),
      );
    } on UserTokenException catch (e) {
      emit(
        state.copyWith(
          clearUser: true,
          status: HostStatus.failure,
          failure: UserTokenFailure(e.msg),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          clearUser: true,
          status: HostStatus.failure,
          failure: Failure(e.toString()),
        ),
      );
    }
  }

  Future<void> logout() async {
    await _authLocal.deleteAuthedUser();

    emit(
      state.copyWith(
        clearUser: true,
        status: HostStatus.unauthenticated,
        clearFailure: true,
      ),
    );
  }
}
