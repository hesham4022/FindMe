import 'package:find_me_app/core/resources/strings.dart';

class AppException implements Exception {
  final String msg;

  AppException(this.msg);

  @override
  bool operator ==(covariant AppException other) {
    if (identical(this, other)) {
      return true;
    }

    return other.msg == msg;
  }

  @override
  int get hashCode => msg.hashCode;
}

class UnknownException extends AppException {
  UnknownException(super.msg);
}

class ServerException extends AppException {
  ServerException(super.msg);
}

class CacheException extends AppException {
  CacheException() : super(AppStrings.cacheFailure);
}

/////////
class NavigateToVerifyEmailException implements Exception {
  final String? message;
  NavigateToVerifyEmailException([this.message]);
  @override
  String toString() => message ?? "NavigateToVerifyEmailException";
}

// class UserTokenException extends AppException {
//   UserTokenException() : super(AppStrings.tokenInValid);
// }

class InternetException extends AppException {
  InternetException() : super(AppStrings.noInternetTitle);
}

class StorageException extends AppException {
  StorageException() : super("Storage Exception");
}

class UserCancellationException extends AppException {
  UserCancellationException() : super("User Canceled Exception");
}
