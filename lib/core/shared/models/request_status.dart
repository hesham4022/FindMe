import 'package:find_me_app/core/helpers/extensions/double_ex.dart';
import 'package:find_me_app/core/resources/strings.dart';

enum RequestStatus {
  pending,
  approved,
  rejected,
  cancelled,
  delegated,
  done,
}

extension RequestStatusExtension on RequestStatus {
  String get name {
    switch (this) {
      case RequestStatus.pending:
        return AppStrings.pending;
      case RequestStatus.approved:
        return AppStrings.approved;
      case RequestStatus.done:
        return AppStrings.done;
      case RequestStatus.rejected:
        return AppStrings.rejected;
      case RequestStatus.cancelled:
        return AppStrings.cancelled;
      case RequestStatus.delegated:
        return AppStrings.delegated;
    }
  }

  static RequestStatus fromName(String name) {
    switch (name.toLowerCase().capitalize()) {
      case AppStrings.pending:
        return RequestStatus.pending;
      case AppStrings.approved:
        return RequestStatus.approved;
      case AppStrings.rejected:
        return RequestStatus.rejected;
      case AppStrings.cancelled || "Withdrawn":
        return RequestStatus.cancelled;
      case AppStrings.delegated:
        return RequestStatus.delegated;
      default:
        return RequestStatus.pending;
    }
  }

  int get value {
    switch (this) {
      case RequestStatus.pending:
        return 0;
      case RequestStatus.approved:
        return 1;
      case RequestStatus.done:
        return 1;
      case RequestStatus.rejected:
        return 2;
      case RequestStatus.cancelled:
        return 3;
      case RequestStatus.delegated:
        return 4;
    }
  }
}
