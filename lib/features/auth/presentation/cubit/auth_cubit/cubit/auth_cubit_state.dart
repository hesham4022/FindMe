// part of 'auth_cubit_cubit.dart';

// enum AuthStatus {
//   initial,
//   authenticated,
//   unauthenticated,
// }

// class AuthState extends Equatable {
//   final AuthStatus status;
//   final AuthedUser? user;

//   const AuthState({
//     required this.status,
//     this.user,
//   });

//   AuthState copyWith({
//     AuthStatus? status,
//     AuthedUser? user,
//   }) {
//     return AuthState(
//       status: status ?? this.status,
//       user: user ?? this.user,
//     );
//   }

//   factory AuthState.initial() {
//     return const AuthState(
//       status: AuthStatus.initial,
//       user: null,
//     );
//   }

//   @override
//   List<Object?> get props => [status, user];
// }
