// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/features/auth/data/source/auth_local.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:find_me_app/features/auth/data/model/authed_user.dart';

// part 'auth_cubit_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final AuthLocal _authLocal;

//   AuthCubit(this._authLocal) : super(AuthState.initial());

//   Future<void> loadCachedUser() async {
//     try {
//       final isLoggedIn = _authLocal.isUserLoggedIn();

//       if (!isLoggedIn) {
//         emit(const AuthState(status: AuthStatus.unauthenticated));
//         return;
//       }

//       final user = await _authLocal.getCachedAuthedUser();

//       emit(AuthState(
//         status: AuthStatus.authenticated,
//         user: user,
//       ));
//     } catch (_) {
//       emit(const AuthState(status: AuthStatus.unauthenticated));
//     }
//   }

//   Future<void> setAuthenticatedUser(AuthedUser user) async {
//     await _authLocal.saveUser(user);

//     emit(AuthState(
//       status: AuthStatus.authenticated,
//       user: user,
//     ));
//   }

//   Future<void> updateCurrentUser(AuthedUser user) async {
//     await _authLocal.saveUser(user);

//     emit(state.copyWith(user: user));
//   }

//   Future<void> logout() async {
//     await _authLocal.deleteAuthedUser();
//     emit(const AuthState(status: AuthStatus.unauthenticated));
//   }
// }
