import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications_button/notifications_state.dart';

class NotificationBtnCubit extends Cubit<NotificationBtnState> {
  NotificationBtnCubit(
    this._sharedPreferences,
  ) : super(const NotificationBtnState());

  final SharedPreferences _sharedPreferences;

  // Notifications handling
  void cacheUnReadedNotifsCount(int value) async {
    await _sharedPreferences.setInt(
      ApiConstants.cachedNotificationsUnReadedCount,
      value,
    );
    emit(state.copyWith(notificationCounter: value));
  }

  void getNotificationsUnReadedCount() {
    final notificationCounter = _sharedPreferences
            .getInt(ApiConstants.cachedNotificationsUnReadedCount) ??
        0;

    emit(state.copyWith(notificationCounter: notificationCounter));
  }

  Future<void> increaseCountByOne() async {
    final value = state.notificationCounter + 1;
    cacheUnReadedNotifsCount(value);
  }

  onInit() {
    getNotificationsUnReadedCount();
  }
}
