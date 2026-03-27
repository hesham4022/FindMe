import 'package:flutter/material.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';

void signUpListener(BuildContext context, SinupState state) {
  if (state.status == SinUpStatus.error && state.error != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertSnackBar(
        context,
        state.error!.msg,
        AlertType.error,
      );
    });
  }
}
