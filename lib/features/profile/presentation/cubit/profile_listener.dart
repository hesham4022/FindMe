import 'package:flutter/material.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception_handler.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/profile/presentation/cubit/profile_cubit.dart';

Future<void> profileListener(BuildContext context, ProfileState state) async {
  //! Add Post Error
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
