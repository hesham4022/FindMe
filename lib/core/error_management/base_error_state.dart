import 'package:find_me_app/core/error_management/failure.dart';

abstract class BaseErrorState {
  final Failure failure;
  const BaseErrorState(this.failure);
}
