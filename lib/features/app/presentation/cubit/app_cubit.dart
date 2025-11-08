import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/features/notifications/data/repo/notification_repo.dart';

part 'app_state.dart';

int? unReadedNotifsCount;

class AppCubit extends Cubit<AppState> {
  AppCubit(
    this._notificationRepo,
  ) : super(AppInitial());

  final NotificationRepo _notificationRepo;

  void getNotificationsUnReadedCount() async {
    final result = await _notificationRepo.getNotificationsCount();
    result.fold(
      (error) => log('Getting notifications count error: $error'),
      (count) {
        unReadedNotifsCount = count;
      },
    );
  }

  // void _cacheUnReadedNotifsCount(int value) async {
  //   await _sharedPreferences.setInt(
  //       ApiConstants.cachedNotificationsUnReadedCount, value);
  // }

  onInit() async {
    // getNotificationsUnReadedCount();
  }
}
