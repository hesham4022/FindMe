import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/resources/strings.dart';

class Failure extends Equatable {
  final String msg;

  const Failure(
    this.msg,
  );

  @override
  List<Object?> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

class CacheFailure extends Failure {
  const CacheFailure(super.msg);
}

// class RefreshTokenFailure extends Failure {
//   const RefreshTokenFailure(super.msg);
// }

class UserTokenFailure extends Failure {
  const UserTokenFailure(super.msg);
}

class StoreTokenFailure extends Failure {
  const StoreTokenFailure(super.msg);
}

class ProfileIdFailure extends Failure {
  const ProfileIdFailure(super.msg);
}

class FormatFailure extends Failure {
  const FormatFailure() : super(AppStrings.formatExceptionError);
}

class InternetFailure extends Failure {
  const InternetFailure() : super(AppStrings.noInternetTitle);
}

class StorageFailure extends Failure {
  const StorageFailure([super.msg = "Storage Failure"]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.msg = AppStrings.errorScreenSubtitle]);
}

class LocationDetectionFailure extends Failure {
  const LocationDetectionFailure([super.msg = AppStrings.needAccessLocation]);
}

class UserCancellationFailure extends Failure {
  const UserCancellationFailure(super.msg);
}
