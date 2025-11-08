// // ignore_for_file: always_put_control_body_on_new_line
//
// import 'dart:developer';
//
// import 'package:find_me_app/core/shared/models/get_actions_data.dart';
// import 'package:find_me_app/features/profile/presentation/profile_view/pages/profile_view.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:find_me_app/core/services/fcm/cubit/fcm_service_state.dart';
// import 'package:find_me_app/core/services/local_notifications/notifications_service_cubit.dart';
// import 'package:find_me_app/features/notifications/data/model/notification.dart';
// import 'package:find_me_app/features/notifications/presentation/widgets/push_notification.dart';
//
// /// Must be in the top level
// /// Handle Background Push Notifications with Firebase Messaging
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
//
// class FCMCubit extends Cubit<FCMState> {
//   FCMCubit(
//     this._localNotificationsService,
//   ) : super(FCMInitial());
//
//   final LocalNotificationsService _localNotificationsService;
//   late FirebaseMessaging _messaging;
//   late NotificationSettings _settings;
//   bool _initialized = false;
//
//   Future<String?> get fcmToken async => _messaging.getToken();
//   FirebaseMessaging get messaging => _messaging;
//
//   /// Used in case of Invalid refresh token to prevent user from recieving notifications
//   Future<void> deleteToken() async => _messaging.deleteToken();
//
//   /// Init for one time only
//   void onInit() async {
//     if (!_initialized) {
//       _messaging = FirebaseMessaging.instance;
//       await _requestPermission();
//       _initialized = true;
//     }
//     initPushNotifications();
//     log('FCM Token: ${await fcmToken}');
//   }
//
//   Future<void> handleMessage(BuildContext context,
//       [RemoteMessage? message]) async {
//     log('handleMessage: ${message?.data}');
//
//     Map<String, dynamic>? data = message?.data ?? {};
//     if (!data.containsKey("flowId")) return;
//
//     final notification = NotificationModel.fromMap(data);
//
//     if (!notification.canNavToDetails) return;
//
//     createRoute(BuildContext context, NotificationModel notification) {
//       if (notification.requestType == RequestType.evaluation) {
//         if (notification.reqActionType == "3") {
//           return MaterialPageRoute(
//             builder: (context) => const ProfileView(isPersonal: false,),
//           );
//         }
//       } else if (notification.reqActionType == "2") {
//         return MaterialPageRoute(
//           builder: (context) => const ProfileView(isPersonal: false,),
//         );
//       } else {
//         return MaterialPageRoute(
//           builder: (context) => const ProfileView(isPersonal: false,),
//         );
//       }
//     }
//
//     final route = createRoute(context, notification);
//
//     // final route = MaterialPageRoute(
//     //   builder: (context) => ActionDetailsView(
//     //     args: ActionDetailsArgs(
//     //       requestId: notification.specialReference!,
//     //       requestType: notification.requestType!,
//     //       flowId: notification.flowId!,
//     //       showActions: notification.showActions,
//     //       reqActionType: null,
//     //     ),
//     //   ),
//     // );
//
//     if (route != null && !route.isCurrent && data.isNotEmpty) {
//       // ignore: use_build_context_synchronously
//       Navigator.push(context, route);
//     }
//   }
//
// //
//   void initPushNotifications() async {
//     // 1. Check if user has accepted permission
//     if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
//       await _messaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       //3. Register channel
//       _localNotificationsService.init();
//
//       handleRecievedFCM();
//     } else {
//       log('User declined or has not accepted permission\n');
//     }
//   }
//
//   Future<void> _requestPermission() async {
//     // For Ios permission is asked when the app is installed
//     _settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   handleRecievedFCM() async {
//     // Get any messages which caused the application to open from a terminated state.
//     _messaging.getInitialMessage().then((message) {
//       if (message != null) {
//         emit(FCMBackgroundReceived(message));
//       }
//     });
//     // 2. Listen to messages when the app is in the foreground
//     FirebaseMessaging.onMessage.listen((message) {
//       emit(FCMForegroundReceived(message));
//     });
//     // Also handle any interaction when the app is in the background via
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       emit(FCMBackgroundReceived(message));
//     });
//     // Call Top Level [_firebaseMessagingBackgroundHandler] Function
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }
//
//   Future<void> showNotification(
//     BuildContext context,
//     RemoteMessage message,
//   ) async {
//     log('showNotification: $message');
//
//     // Create Notification Model
//     var notification = NotificationModel(
//       title: message.notification?.title ?? 'No Title',
//       body: NotificationBody(
//         remarks: message.data['Remarks'],
//       ),
//     );
//     showPushNotification(
//       context,
//       notification.title ?? "",
//       notification.body?.remarks ?? "",
//       () => handleMessage(context, message),
//     );
//   }
// }
