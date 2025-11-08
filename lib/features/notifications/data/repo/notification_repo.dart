import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/data/source/notification_remote.dart';

class NotificationRepo {
  final NotificationsRemote remoteSource;

  NotificationRepo(
    this.remoteSource,
  );

  Future<Either<Failure, NotificationsResponse>> getNotifications({
    required int page,
    required int size,
  }) {
    return executeFunctionality<NotificationsResponse>(function: () async {
      final json = await remoteSource.getNotifications(page: page, size: size);

      log("getNotifications: $json");
      return NotificationsResponse.fromJson(json);
    });
  }

  Future<Either<Failure, int>> getNotificationsCount() {
    return executeFunctionality<int>(function: () async {
      final json = await remoteSource.getNotificationsCount();
      log("getNotificationsCount: $json");
      return 0;
    });
  }

  Future<Either<Failure, Unit>> markNotificationsAsRead(num id) {
    return executeFunctionality<Unit>(function: () async {
      await remoteSource.markNotificationsAsRead(id);
      return unit;
    });
  }
}
