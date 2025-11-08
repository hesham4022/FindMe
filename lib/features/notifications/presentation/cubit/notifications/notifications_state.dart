part of 'notifications_cubit.dart';

enum NotificationStatus { initial, loading, success, failed }

class NotificationsState extends Equatable {
  final List<NotificationModel> notifications;
  final String? tappedNotificationID;
  final NotificationStatus status;
  final SuccessResponse? success;
  final Failure? failure;
  final bool isFetchingData;
  final int selectedPage;
  final bool hasReachedMax;
  final num editedIndex;

  const NotificationsState({
    required this.notifications,
    this.tappedNotificationID,
    this.status = NotificationStatus.initial,
    this.failure,
    this.success,
    this.isFetchingData = false,
    this.selectedPage = 0,
    this.hasReachedMax = false,
    this.editedIndex = -1,
  });

  factory NotificationsState.initial() {
    return NotificationsState(
      status: NotificationStatus.initial,
      notifications: [],
    );
  }

  bool get isInitial => status == NotificationStatus.initial;
  bool get isLoading => status == NotificationStatus.loading;
  bool get isSuccess => status == NotificationStatus.success;
  bool get isError => status == NotificationStatus.failed;

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    String? tappedNotificationID,
    NotificationStatus? status,
    Failure? failure,
    SuccessResponse? success,
    bool? isFetchingData,
    int? selectedPage,
    bool? hasReachedMax,
    num? editedIndex,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      tappedNotificationID: tappedNotificationID ?? this.tappedNotificationID,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      success: success ?? this.success,
      isFetchingData: isFetchingData ?? this.isFetchingData,
      selectedPage: selectedPage ?? this.selectedPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      editedIndex: editedIndex ?? this.editedIndex,
    );
  }

  @override
  List<Object?> get props => [
        notifications,
        tappedNotificationID,
        status,
        success,
        failure,
        isFetchingData,
        selectedPage,
        hasReachedMax,
        editedIndex,
      ];
}
