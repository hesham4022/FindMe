// import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// sealed class FCMState extends Equatable {
//   // const factory FCMState.initial() = FCMInitial;
//   // const factory FCMState.foregroundReceived(RemoteMessage message) =
//   //     FCMForegroundReceived;
//   // const factory FCMState.backgroundReceived(RemoteMessage message) =
//   //     FCMBackgroundReceived;
//   // const factory FCMState.error(String msg) = FCMError;
//   @override
//   List<Object?> get props => [];
// }
//
// class FCMStateInitial extends FCMState {}
//
// class FCMStateForegroundReceived extends FCMState {
//   final RemoteMessage message;
//   FCMStateForegroundReceived({required this.message});
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class FCMStateBackgroundReceived extends FCMState {
//   final RemoteMessage message;
//   FCMStateBackgroundReceived({required this.message});
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class FCMStateError extends FCMState {
//   final String msg;
//   FCMStateError({required this.msg});
//
//   @override
//   List<Object?> get props => [msg];
// }
