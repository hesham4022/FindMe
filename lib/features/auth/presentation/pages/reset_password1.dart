import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_listener.dart';
import 'package:find_me_app/features/auth/presentation/widgets/reset_password_fields.dart';

class ResetPassword1 extends StatelessWidget {
  final ResetPasswordArgs args; // ✅ جاي من الصفحة اللي قبلها

  const ResetPassword1({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(
        sl(),
        args,
      ),
      child: const _ResetPasswordBody(),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "forgotPasswordTitle".ts,
          style: Theme.of(context).textTheme.kHeadingH4SmallBoldBlack,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: resetPasswordListener, // ✅ نفس نظامك الحالي
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            OTPField(), // field for otp
            VSpace(32),
            NewPasswordField(), // field for new password
            VSpace(32),
            ConfirmNewPasswordField(), // confirm password
            VSpace(32),
            Align(
              alignment: Alignment.center,
              child: ContinueButton(), // button
            ),
          ],
        ),
      ),
    );
  }
}
