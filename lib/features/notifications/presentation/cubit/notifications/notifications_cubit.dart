// ignore_for_file: always_put_control_body_on_new_line

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/data/repo/notification_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
    this._repo,
  ) : super(NotificationsState.initial());

  final NotificationRepo _repo;
  late final ScrollController scrollCtrl = ScrollController();
  final int limit = 11;

  void markNotificationAsRead(num id, int index) async {
    if (state.notifications[index].read == true) return;

    // Get Notifications From Api
    final result = await _repo.markNotificationsAsRead(id);
    if (isClosed) return;
    result.fold(
      (error) => emit(state.copyWith(
        failure: error,
        status: NotificationStatus.failed,
      )),
      (_) => emit(state.copyWith(
        editedIndex: index,
        notifications: state.notifications.map((e) {
          if (e.id == id) {
            return e.copyWith(read: true);
          }
          return e;
        }).toList(),
        status: NotificationStatus.success,
      )),
    );
  }

  void _getNotifications() async {
    if (isClosed) return;

    // Set Loading State
    emit(state.copyWith(status: NotificationStatus.loading));
    // Get Notifications From Api
    final result = await _repo.getNotifications(page: 0, size: limit);
    if (isClosed) return;
    result.fold(
      (error) => emit(state.copyWith(
        failure: error,
        status: NotificationStatus.failed,
      )),
      (result) {
        final notif = result.notifications;
        emit(state.copyWith(
          notifications: notif,
          hasReachedMax: notif.isEmpty || notif.length < limit,
          status: NotificationStatus.success,
        ));
      },
    );
  }

  void _paginateNotif() async {
    // 1. check fetching data
    if (state.isFetchingData) return;
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
      (success) {
        final allNotif = List<NotificationModel>.from(state.notifications);
        final newNotif = success.notifications;
        late bool hasReachedMax = false;
        int page = state.selectedPage;

        if (newNotif.isEmpty || newNotif.length < limit) {
          hasReachedMax = true;
        } else {
          page++;
        }

        allNotif.addAll(newNotif);

        emit(state.copyWith(
          status: NotificationStatus.success,
          hasReachedMax: hasReachedMax,
          selectedPage: page,
          notifications: allNotif,
          isFetchingData: false,
        ));
      },
    );
  }

  void _onScroll() {
    final maxScroll = scrollCtrl.position.maxScrollExtent;
    final currentScroll = scrollCtrl.offset;
    if (currentScroll >= (maxScroll * 0.9) && !state.hasReachedMax) {
      _paginateNotif();
    }
  }

  void refresh() {
    emit(state.copyWith(
      selectedPage: 0,
      hasReachedMax: false,
      notifications: [],
    ));
    _getNotifications();
  }

  void onInit() {
    _getNotifications();
    scrollCtrl.addListener(_onScroll);
  }

  @override
  Future<void> close() {
    scrollCtrl
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }
}
