import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/widgets/signin_fields.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_listener.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';
import 'package:find_me_app/features/auth/presentation/widgets/auth_appbar.dart';

class SigninView extends StatelessWidget {
  const SigninView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("welcomeMessage".ts,
            style: Theme.of(context).textTheme.kHeadingH4SmallBoldBlack),
      ),
      resizeToAvoidBottomInset: false,
      body: const _SignInBody(),
    );
  }
}

class _SignInBody extends StatelessWidget {
  const _SignInBody();

  @override
  Widget build(BuildContext context) {
    /// Used for scrolling fields disappeared when keyboard appearing
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return BlocConsumer<SignInCubit, SignInState>(
      listener: signInListener,
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: state.isLoading,
          progressIndicator: CustomLoadingWidget(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, bottom).r,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              // AuthHeader(
              //   companyName: context.isArabic
              //       ? context.read<SignInCubit>().baseUrlInstance?.nameA
              //       : context.read<SignInCubit>().baseUrlInstance?.nameL,
              // ),
              VSpace(36),
              Text(
                AppStrings.welcomeMessage2.ts,
                style: Theme.of(context).textTheme.kHeadingH4SmallBoldBlack,
              ),

              const VSpace(36),
              const UserNameField(),
              const VSpace(20),
              const PasswordField(),
              const VSpace(10),
              const ForgotPasswordBtn(),
              const VSpace(40),
              const SignInButton(),
              const VSpace(60),
              const DontHaveAcountButton(),
              const VSpace(100),
              const SwitchLanguage(),
              const VSpace(20),
            ],
          ),
        );
      },
    );
  }
}
