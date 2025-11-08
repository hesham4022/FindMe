import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/auth/presentation/widgets/forget_password_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_listener.dart';
import 'package:find_me_app/features/auth/presentation/widgets/reset_password_fields.dart';

import 'package:find_me_app/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:find_me_app/features/auth/presentation/widgets/auth_appbar.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(sl()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text("forgotPasswordTitle".ts,
              style: Theme.of(context).textTheme.kHeadingH4SmallBoldBlack),
        ),
        resizeToAvoidBottomInset: false,
        body: _ForgotPasswordBody(),
      ),
    );
  }
}

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody();

  @override
  Widget build(BuildContext context) {
    /// Used for scrolling fields disappeared when keyboard appearing
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: forgotPasswordListener,
      builder: (context, state) => ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          EmailField(),
          VSpace(20),
          Align(
            alignment: Alignment.center,
            child: ConfirmButton(),
          ),
        ],
      ),
    );
  }
}
