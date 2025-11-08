import 'package:flutter/material.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception_handler.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/change_password/change_password_state.dart';

Future<void> changePasswordListener(
    BuildContext context, ChangePasswordState state) async {
  if (state.isSuccess) {
    showAlertSnackBar(
      context,
      state.success?.msg ?? 'move to next step',
      AlertType.success,
    );

    context.back();
  } else if (state.isError) {
    showAlertSnackBar(
      context,
      state.error?.msg ?? "",
      AlertType.error,
    );

    // sl<ExceptionHandler>().handleErrors(
    //   context,
    //   state.error!,
    // );
  }
}
