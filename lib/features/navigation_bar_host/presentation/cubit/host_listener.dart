import 'package:flutter/material.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';

Future<void> hostListener(
  BuildContext context,
  HostState state,
) async {
  if (state.isError) {
    showAlertSnackBar(
      context,
      state.failure?.msg ?? "",
      AlertType.error,
    );

    /// TODO: uncomment for token is valid
    // sl<ExceptionHandler>().handleErrors(
    //   context,
    //   state.failure!,
    // );
  }
}
