import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/data/source/notification_remote.dart';

class NotificationRepo {
  final NotificationsRemote remoteSource;

  NotificationRepo(this.remoteSource);

  Future<Either<Failure, NotificationResponseModel>> getNotifications({
    required int page,
    required int size,
  }) {
    return executeFunctionality<NotificationResponseModel>(
      function: () async {
        final response = await remoteSource.getNotifications(
          page: page,
          size: size,
        );

        log("getNotifications total: ${response.total}");
        log("getNotifications count: ${response.notifications.length}");

        return response;
      },
    );
  }

  // Future<Either<Failure, int>> getNotificationsCount() {
  //   return executeFunctionality<int>(
  //     function: () async {
  //       final count = await remoteSource.getNotificationsCount();

  //       log("getNotificationsCount: $count");

  //       return count;
  //     },
  //   );
  // }

  Future<Either<Failure, Unit>> markNotificationsAsRead(String id) {
    return executeFunctionality<Unit>(
      function: () async {
        await remoteSource.markNotificationsAsRead(id);
        return unit;
      },
    );
  }
}
