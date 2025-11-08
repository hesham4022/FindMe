import 'package:equatable/equatable.dart';

class NotificationBtnState extends Equatable {
  final int notificationCounter;

  const NotificationBtnState({this.notificationCounter = 0});

  NotificationBtnState copyWith({
    int? notificationCounter,
  }) {
    return NotificationBtnState(
      notificationCounter: notificationCounter ?? this.notificationCounter,
    );
  }

  @override
  List<Object> get props => [notificationCounter];
}
