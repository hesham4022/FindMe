import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/signup_listener.dart';
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';
import 'package:find_me_app/features/auth/presentation/widgets/signin_fields.dart';
import 'package:find_me_app/features/auth/presentation/widgets/sinup_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinUpView extends StatelessWidget {
  const SinUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SinupCubit(
        sl<AuthRepo>(),
        sl<AuthLocal>(),
      ),
      child: const _SinUpViewBody(),
    );
  }
}

class _SinUpViewBody extends StatelessWidget {
  const _SinUpViewBody();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Text(
          "sinupTitle".ts,
          style: Theme.of(context).textTheme.kHeadingH4SmallBoldBlack,
        ),
      ),
      body: BlocConsumer<SinupCubit, SinupState>(
        listener: signUpListener,
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: state.status == SinUpStatus.loading,
            progressIndicator: const CustomLoadingWidget(),
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: const [
                FullNameField(),
                VSpace(20),
                SinUpUserNameField(),
                VSpace(20),
                SignUpPasswordField(),
                VSpace(20),
                SignUpConfirmPasswordField(),
                VSpace(20),
                PhoneNumberField(),
                VSpace(20),
                NationalIdField(),
                VSpace(20),
                UplaodNationalId(),
                VSpace(40),
                TermsAndPrivacyText(),
                VSpace(10),
                SignUpButton(),
                VSpace(30),
                AlreadyHaveAcountButton(),
                VSpace(30),
                SwitchLanguage(),
                VSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
