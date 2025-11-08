import 'package:flutter/material.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception_handler.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_cubit.dart';

Future<void> notificationsListener(
  BuildContext context,
  NotificationsState state,
) async {
  if (state.isError) {
    showAlertSnackBar(
      context,
      state.failure?.msg ?? "",
      AlertType.error,
    );

    // sl<ExceptionHandler>().handleErrors(
    //   context,
    //   state.failure!,
    // );
  }
}
