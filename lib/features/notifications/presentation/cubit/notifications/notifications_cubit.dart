// // ignore_for_file: always_put_control_body_on_new_line
// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/features/notifications/data/source/pusher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:find_me_app/core/error_management/failure.dart';
// import 'package:find_me_app/core/networking/success_response.dart';
// import 'package:find_me_app/features/notifications/data/model/notification.dart';
// import 'package:find_me_app/features/notifications/data/repo/notification_repo.dart';

// part 'notifications_state.dart';

// class NotificationsCubit extends Cubit<NotificationsState> {
//   NotificationsCubit(this._repo) : super(NotificationsState.initial());

//   final NotificationRepo _repo;

//   late final ScrollController scrollCtrl = ScrollController();

//   final int limit = 11;

//   // 🔥 MARK AS READ
//   void markNotificationAsRead(String id, int index) async {
//     if (state.notifications[index].isRead) return;

//     final result = await _repo.markNotificationsAsRead(id);

//     if (isClosed) return;

//     result.fold(
//       (error) => emit(state.copyWith(
//         failure: error,
//         status: NotificationStatus.failed,
//       )),
//       (_) {
//         final updated = List<AppNotificationModel>.from(state.notifications);

//         final item = updated[index];

//         updated[index] = AppNotificationModel(
//           id: item.id,
//           type: item.type,
//           notifiableType: item.notifiableType,
//           notifiableId: item.notifiableId,
//           data: item.data,
//           readAt: DateTime.now().toIso8601String(), // ✔️ نخليه read
//           createdAt: item.createdAt,
//           updatedAt: item.updatedAt,
//         );

//         emit(state.copyWith(
//           notifications: updated,
//           editedIndex: index,
//           status: NotificationStatus.success,
//         ));
//       },
//     );
//   }

//   // 🔥 GET FIRST PAGE
//   void _getNotifications() async {
//     if (isClosed) return;

//     emit(state.copyWith(status: NotificationStatus.loading));

//     final result = await _repo.getNotifications(
//       page: 1,
//       size: limit,
//     );

//     if (isClosed) return;

//     result.fold(
//       (error) => emit(state.copyWith(
//         failure: error,
//         status: NotificationStatus.failed,
//       )),
//       (response) {
//         final notif = response.notifications;

//         emit(state.copyWith(
//           notifications: notif,
//           total: response.total,
//           hasReachedMax: notif.length < limit,
//           selectedPage: 2, // الصفحة اللي بعدها
//           status: NotificationStatus.success,
//         ));
//       },
//     );
//   }

//   // 🔥 PAGINATION
//   void _paginateNotif() async {
//     if (state.isFetchingData || state.hasReachedMax) return;
//     if (isClosed) return;

//     emit(state.copyWith(isFetchingData: true));

//     final result = await _repo.getNotifications(
//       page: state.selectedPage,
//       size: limit,
//     );

//     if (isClosed) return;

//     result.fold(
//       (failure) => emit(state.copyWith(
//         status: NotificationStatus.failed,
//         failure: failure,
//         isFetchingData: false,
//       )),
//       (response) {
//         final newNotif = response.notifications;

//         final allNotif = List<AppNotificationModel>.from(state.notifications)
//           ..addAll(newNotif);

//         final hasReachedMax = newNotif.length < limit;

//         emit(state.copyWith(
//           status: NotificationStatus.success,
//           notifications: allNotif,
//           selectedPage: state.selectedPage + 1,
//           hasReachedMax: hasReachedMax,
//           isFetchingData: false,
//         ));
//       },
//     );
//   }

//   // 🔥 SCROLL
//   void _onScroll() {
//     final maxScroll = scrollCtrl.position.maxScrollExtent;
//     final currentScroll = scrollCtrl.offset;

//     if (currentScroll >= (maxScroll * 0.9)) {
//       _paginateNotif();
//     }
//   }

//   // 🔥 REFRESH
//   void refresh() {
//     emit(state.copyWith(
//       selectedPage: 1,
//       hasReachedMax: false,
//       notifications: [],
//     ));

//     _getNotifications();
//   }

//   // 🔥 INIT
//   void onInit() {
//     _getNotifications();
//     scrollCtrl.addListener(_onScroll);
//   }

//   @override
//   Future<void> close() {
//     scrollCtrl
//       ..removeListener(_onScroll)
//       ..dispose();
//     return super.close();
//   }
// }

// ignore_for_file: always_put_control_body_on_new_line
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/notifications/data/source/pusher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/data/repo/notification_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(NotificationsState.initial());

  final NotificationRepo _repo;

  ScrollController _scrollCtrl = ScrollController();
  ScrollController get scrollCtrl => _scrollCtrl;

  final int limit = 11;

  void attachScrollListener() {
    if (!_scrollCtrl.hasClients) {
      try {
        _scrollCtrl.dispose();
      } catch (_) {}
      _scrollCtrl = ScrollController();
    }
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.addListener(_onScroll);
  }

  int _calculateUnreadCount(List<AppNotificationModel> notifications) {
    return notifications.where((e) => !e.isRead).length;
  }

  // 🔥 استقبال إشعار جديد من Pusher
  void addNotificationFromPusher(AppNotificationModel notification) {
    print('BEFORE unreadCount = ${state.unreadCount}');
    final alreadyExists =
        state.notifications.any((e) => e.id == notification.id);

    if (alreadyExists) return;

    final updatedNotifications = [
      notification,
      ...state.notifications,
    ];

    emit(state.copyWith(
      notifications: updatedNotifications,
      total: state.total + 1,
      unreadCount: state.unreadCount + 1,
      status: NotificationStatus.success,
    ));
  }

  // 🔥 MARK AS READ
  void markNotificationAsRead(String id, int index) async {
    if (state.notifications[index].isRead) return;

    final result = await _repo.markNotificationsAsRead(id);

    if (isClosed) return;

    result.fold(
      (error) => emit(state.copyWith(
        failure: error,
        status: NotificationStatus.failed,
      )),
      (_) {
        final updated = List<AppNotificationModel>.from(state.notifications);

        final item = updated[index];

        updated[index] = AppNotificationModel(
          id: item.id,
          type: item.type,
          notifiableType: item.notifiableType,
          notifiableId: item.notifiableId,
          data: item.data,
          readAt: DateTime.now().toIso8601String(),
          createdAt: item.createdAt,
          updatedAt: item.updatedAt,
        );

        emit(state.copyWith(
          notifications: updated,
          editedIndex: index,
          unreadCount: _calculateUnreadCount(updated),
          status: NotificationStatus.success,
        ));
      },
    );
  }

  // 🔥 GET FIRST PAGE
  void _getNotifications() async {
    if (isClosed) return;

    emit(state.copyWith(status: NotificationStatus.loading));

    final result = await _repo.getNotifications(
      page: 1,
      size: limit,
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(state.copyWith(
        failure: error,
        status: NotificationStatus.failed,
      )),
      (response) {
        final notif = response.notifications;

        emit(state.copyWith(
          notifications: notif,
          total: response.total,
          unreadCount: _calculateUnreadCount(notif),
          hasReachedMax: notif.length < limit,
          selectedPage: 2,
          status: NotificationStatus.success,
        ));
      },
    );
  }

  // 🔥 PAGINATION
  void _paginateNotif() async {
    if (state.isFetchingData || state.hasReachedMax) return;
    if (isClosed) return;

    emit(state.copyWith(isFetchingData: true));

    final result = await _repo.getNotifications(
      page: state.selectedPage,
      size: limit,
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(
        status: NotificationStatus.failed,
        failure: failure,
        isFetchingData: false,
      )),
      (response) {
        final newNotif = response.notifications;

        final allNotif = List<AppNotificationModel>.from(state.notifications)
          ..addAll(newNotif);

        final hasReachedMax = newNotif.length < limit;

        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: allNotif,
          unreadCount: _calculateUnreadCount(allNotif),
          selectedPage: state.selectedPage + 1,
          hasReachedMax: hasReachedMax,
          isFetchingData: false,
        ));
      },
    );
  }

  // 🔥 SCROLL
  void _onScroll() {
    final maxScroll = scrollCtrl.position.maxScrollExtent;
    final currentScroll = scrollCtrl.offset;

    if (currentScroll >= (maxScroll * 0.9)) {
      _paginateNotif();
    }
  }

  // 🔥 REFRESH
  void refresh() {
    emit(state.copyWith(
      selectedPage: 1,
      hasReachedMax: false,
      notifications: [],
      unreadCount: 0,
    ));
    _getNotifications();
  }

  // 🔥 INIT
  void onInit() {
    _getNotifications();
    // scrollCtrl.addListener(_onScroll);
    attachScrollListener();
  }

  @override
  Future<void> close() {
    scrollCtrl
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }
}
