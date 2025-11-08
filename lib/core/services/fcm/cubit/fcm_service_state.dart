// import 'package:firebase_messaging/firebase_messaging.dart';
//
// abstract class FCMState {
//   const FCMState();
// }
//
// class FCMInitial extends FCMState {}
//
// class FCMForegroundReceived extends FCMState {
//   final RemoteMessage message;
//
//   const FCMForegroundReceived(this.message);
// }
//
// class FCMBackgroundReceived extends FCMState {
//   final RemoteMessage message;
//
//   const FCMBackgroundReceived(this.message);
// }
//
// class FCMError extends FCMState {
//   final String msg;
//   const FCMError(this.msg);
// }
//
// // @freezed
// // sealed class FCMState with _$FCMState {
// //   const factory FCMState.initial() = FCMInitial;
//
// //   const factory FCMState.foregroundReceived(RemoteMessage message) =
// //       FCMForegroundReceived;
//
// //   const factory FCMState.backgroundReceived(RemoteMessage message) =
// //       FCMBackgroundReceived;
//
// //   const factory FCMState.error(String msg) = FCMError;
// // }
