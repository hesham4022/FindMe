part of 'notifications_cubit.dart';

enum NotificationStatus { initial, loading, success, failed }

class NotificationsState extends Equatable {
  final List<NotificationResponseModel> notifications;
  final String? tappedNotificationID;
  final NotificationStatus status;
  final SuccessResponse? success;
  final Failure? failure;
  final bool isFetchingData;
  final int selectedPage;
  final bool hasReachedMax;
  final int editedIndex;
  final int total;
  final int unreadCount;

  const NotificationsState({
    required this.notifications,
    this.tappedNotificationID,
    this.status = NotificationStatus.initial,
    this.failure,
    this.success,
    this.isFetchingData = false,
    this.selectedPage = 1,
    this.hasReachedMax = false,
    this.editedIndex = -1,
    this.total = 0,
    this.unreadCount = 0,
  });

  factory NotificationsState.initial() {
    return const NotificationsState(
      notifications: [],
      tappedNotificationID: null,
      status: NotificationStatus.initial,
      failure: null,
      success: null,
      isFetchingData: false,
      selectedPage: 1,
      hasReachedMax: false,
      editedIndex: -1,
      total: 0,
      unreadCount: 0,
    );
  }

  bool get isInitial => status == NotificationStatus.initial;
  bool get isLoading => status == NotificationStatus.loading;
  bool get isSuccess => status == NotificationStatus.success;
  bool get isError => status == NotificationStatus.failed;

  NotificationsState copyWith({
    List<NotificationResponseModel>? notifications,
    String? tappedNotificationID,
    NotificationStatus? status,
    Failure? failure,
    SuccessResponse? success,
    bool? isFetchingData,
    int? selectedPage,
    bool? hasReachedMax,
    int? editedIndex,
    int? total,
    int? unreadCount,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      tappedNotificationID: tappedNotificationID ?? this.tappedNotificationID,
      status: status ?? this.status,
      failure: failure,
      success: success,
      isFetchingData: isFetchingData ?? this.isFetchingData,
      selectedPage: selectedPage ?? this.selectedPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      editedIndex: editedIndex ?? this.editedIndex,
      total: total ?? this.total,
      unreadCount: unreadCount ?? this.unreadCount,
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
        total,
        unreadCount,
      ];
}
