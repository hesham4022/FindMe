import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_listener.dart';
import 'package:find_me_app/features/auth/presentation/cubit/verify_email/verify_otp_state.dart';
import 'package:find_me_app/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:find_me_app/features/auth/presentation/widgets/verify_otp_fields.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';

class VerifyOTPArgs {
  final String username;

  VerifyOTPArgs({required this.username});
}

class VerfiyOTPView extends StatelessWidget {
  const VerfiyOTPView({
    super.key,
    required this.args,
  });

  final VerifyOTPArgs args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VerifyOTPCubit(
            sl<AuthRepo>(),
            sl<AuthLocal>(),
            args,
          ),
        ),
        BlocProvider(
          create: (_) => SinupCubit(
            sl<AuthRepo>(),
            sl<AuthLocal>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AuthAppBar(title: "Verify Email".ts),
        resizeToAvoidBottomInset: false,
        body: _VerifyOTPBody(),
      ),
    );
  }
}

class _VerifyOTPBody extends StatelessWidget {
  const _VerifyOTPBody();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return BlocConsumer<VerifyOTPCubit, VerifyOTPState>(
      listener: verifyOTPListener,
      builder: (context, state) => ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          const VSpace(16),
          const VerifyOTPTitleAndSubtitle(),
          const VSpace(32),
          const OTPWidget(),
          const VSpace(32),
          const ConfirmButton(),
          const VSpace(12),
          const ResendOTPButton(),
        ],
      ),
    );
  }
}
