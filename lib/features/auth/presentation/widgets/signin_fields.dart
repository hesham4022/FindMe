import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/password_field.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_state.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class TokenIDField extends StatefulWidget {
//   const TokenIDField({super.key});
//
//   @override
//   State<TokenIDField> createState() => _TokenIDFieldState();
// }
// class _TokenIDFieldState extends State<TokenIDField> {
//   late final TextEditingController _controller;
//   late final FocusNode _focusNode;
//   bool _isUserModified = false; // Tracks if the user has modified the text
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _focusNode = FocusNode();
//     _focusNode.addListener(_onFocusChange);
//
//     // Load cached token ID only once when the screen is first entered
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final cachedTokenID = context.read<SignInCubit>().state.baseUrlResponse?.tokenId;
//       if (cachedTokenID != null && _controller.text.isEmpty) {
//         _controller.text = cachedTokenID.toString();
//         context.read<SignInCubit>().tokenIDChanged(int.tryParse(cachedTokenID) ?? 0);
//       }
//     });
//   }
//
//   void _onTextChanged(String value) {
//     setState(() {
//       _isUserModified = true; // Mark as modified when user types
//     });
//     context.read<SignInCubit>().tokenIDChanged(int.tryParse(value) ?? 0);
//   }
//
//   Future<void> _onFocusChange() async {
//     if (!_focusNode.hasFocus) {
//       dismissFocusedWidget(context);
//       await context.read<SignInCubit>().getBaseUrl();
//     }
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SignInCubit, SignInState>(
//       listener: (context, state) {
//         if (!_isUserModified && _controller.text.isEmpty) {
//           // Avoid overwriting user's cleared text
//           final cachedTokenID = state.baseUrlResponse?.tokenId;
//           if (cachedTokenID != null) {
//             _controller.text = cachedTokenID.toString();
//           }
//         }
//       },
//       builder: (context, state) {
//         return CustomTextField(
//           controller: _controller,
//           focusNode: _focusNode,
//           errorText: state.tokenIDErrorText,
//           hint: AppStrings.tokenID,
//           prefixIcon: Icon(
//             MdiIcons.cardAccountDetailsOutline,
//             size: 20.sp,
//             color: AppColors.saltBox600,
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: _onTextChanged,
//           onValidate: (value) {
//             final errorText = AppValidators.validateTokenID(value);
//             context.read<SignInCubit>().tokenIDErrorTextChanged(errorText ?? "");
//             return errorText;
//           },
//           onSubmit: (v) async {
//             dismissFocusedWidget(context);
//             await context.read<SignInCubit>().getBaseUrl();
//           },
//         );
//       },
//     );
//   }
// }

// class TokenIDField extends StatefulWidget {
//   const TokenIDField({super.key});

//   @override
//   State<TokenIDField> createState() => _TokenIDFieldState();
// }

// class _TokenIDFieldState extends State<TokenIDField> {
//   late final TextEditingController _controller;
//   late final FocusNode _focusNode;
//   bool _isUserModified = false; // Tracks if the user has modified the text
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _focusNode = FocusNode();
//     _focusNode.addListener(_onFocusChange);
//
//     // Load cached token ID only once when the screen is first entered
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final cachedTokenID = context.read<SignInCubit>().state.baseUrlResponse?.tokenId;
//       if (cachedTokenID != null && _controller.text.isEmpty) {
//         _controller.text = cachedTokenID.toString();
//         context.read<SignInCubit>().tokenIDChanged(int.tryParse(cachedTokenID) ?? 0);
//       }
//     });
//   }
//
//   void _onTextChanged(String value) {
//     setState(() {
//       _isUserModified = true; // Mark as modified when user types
//     });
//     context.read<SignInCubit>().tokenIDChanged(int.tryParse(value) ?? 0);
//   }
//
//   Future<void> _onFocusChange() async {
//     if (!_focusNode.hasFocus) {
//       dismissFocusedWidget(context);
//       await context.read<SignInCubit>().getBaseUrl();
//     }
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SignInCubit, SignInState>(
//       listener: (context, state) {
//         if (!_isUserModified && _controller.text.isEmpty) {
//           // Avoid overwriting user's cleared text
//           final cachedTokenID = state.baseUrlResponse?.tokenId;
//           if (cachedTokenID != null) {
//             _controller.text = cachedTokenID.toString();
//           }
//         }
//       },
//       builder: (context, state) {
//         return CustomTextField(
//           controller: _controller,
//           focusNode: _focusNode,
//           errorText: state.tokenIDErrorText,
//           hint: AppStrings.tokenID,
//           prefixIcon: Icon(
//             MdiIcons.cardAccountDetailsOutline,
//             size: 20.sp,
//             color: AppColors.saltBox600,
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: _onTextChanged,
//           onValidate: (value) {
//             final errorText = AppValidators.validateTokenID(value);
//             context.read<SignInCubit>().tokenIDErrorTextChanged(errorText ?? "");
//             return errorText;
//           },
//           onSubmit: (v) async {
//             dismissFocusedWidget(context);
//             await context.read<SignInCubit>().getBaseUrl();
//           },
//         );
//       },
//     );
//   }
// }
// class _TokenIDFieldState extends State<TokenIDField> {
//   late final TextEditingController _controller;
//   late final FocusNode _focusNode;
//   bool _isTokenLoaded = false; // Flag to track if the token has been loaded

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _focusNode = FocusNode();
//     _focusNode.addListener(_onFocusChange);
//   }

//   @override
//   // Future<void> didChangeDependencies() async {
//   //   super.didChangeDependencies();

//   //   // Check if the user has modified the text in the controller
//   //   final isUserModified = _controller.text.isNotEmpty;

//   //   // If the user hasn't modified the text and the token hasn't been loaded yet, update it with the cached token ID
//   //   if (!isUserModified && !_isTokenLoaded) {
//   //     // ✅ Get cached token ID from SignInCubit
//   //     final cachedTokenID =
//   //         context.read<SignInCubit>().state.baseUrlResponse?.tokenId;

//   //     if (cachedTokenID != null) {
//   //       _controller.text = cachedTokenID.toString();
//   //       context
//   //           .read<SignInCubit>()
//   //           .tokenIDChanged(int.tryParse(cachedTokenID) ?? 0);
//   //       _isTokenLoaded = true; // Mark the token as loaded
//   //     } else {
//   //       context.read<SignInCubit>().loadCachedBaseUrlResponse();
//   //       final tokenId =
//   //           context.watch<SignInCubit>().getBaseUrlInstance()?.tokenId;
//   //       if (tokenId != null) {
//   //         _controller.text = tokenId;
//   //         _isTokenLoaded = true; // Mark the token as loaded
//   //       }
//   //     }
//   //   }
//   // }

//   void _onFocusChange() {
//   if (!_focusNode.hasFocus) {
//     dismissFocusedWidget(context);
//   }
// }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SignInCubit, SignInState>(
//       listener: tokenIdListener,
//       builder: (context, state) {
//         return CustomTextField(
//           controller: _controller,
//           focusNode: _focusNode,
//           errorText: state.tokenIDErrorText,
//           hint: AppStrings.tokenID,
//           prefixIcon: Icon(
//             MdiIcons.cardAccountDetailsOutline,
//             size: 20.sp,
//             color: AppColors.saltBox600,
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: (value) {
//             context
//                 .read<SignInCubit>()
//                 .tokenIDChanged(int.tryParse(value) ?? 0);
//           },
//           onValidate: (value) {
//             final errorText = AppValidators.validateTokenID(value);
//             context
//                 .read<SignInCubit>()
//                 .tokenIDErrorTextChanged(errorText ?? "");
//             return errorText;
//           },
//           onSubmit: (v) async {
//             dismissFocusedWidget(context);
//             await context.read<SignInCubit>().getBaseUrl();
//           },
//         );
//       },
//     );
//   }
// }

class UserNameField extends StatelessWidget {
  const UserNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "emailOrMobileNumber".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: AppStrings.username.ts,
                errorText: state.usernameErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.emailAddress,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<SignInCubit>().usernameChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateEmail(value);
                  context
                      .read<SignInCubit>()
                      .usernameErrorTextChanged(err ?? "");
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "passordLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
              errorText: state.passwordErrorText,
              hint: "*********".ts,
              prefixIcon: Icon(
                MdiIcons.lockOpenVariantOutline,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onChanged: (value) {
                final cubit = context.read<SignInCubit>();
                cubit.passwordChanged(value);
                cubit.passwordErrorTextChanged("");
              },
              onValidate: (value) {
                return AppValidators.validateSignInPassword(value);
              },
            ),
          ],
        );
      },
    );
  }
}

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => context.toNamed(
            AppRoutes.forgotPasswordRoute,
          ),
          child: Text(
            AppStrings.forgotPassword.ts,
            style: Theme.of(context)
                .textTheme
                .kParagraph01SemiBold
                .copyWith(color: AppColors.saltBox500, fontSize: 12),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final isValid = AppValidators.validateEmail(state.username) == null &&
            AppValidators.validateSignInPassword(state.password) == null;
        return CustomFilledButton(
          state: state.isLoading
              ? CustomState.active
              : isValid
                  ? CustomState.active
                  : CustomState.disabled,
          color: AppColors.mainColor,
          width: 0.55.sw,
          height: 45.h,
          radius: 30.r,
          title: Text(
            "login".ts,
            style: Theme.of(context)
                .textTheme
                .kHeadingH4SmallBold
                .copyWith(fontSize: 22.sp),
          ),
          loading: state.isLoading, // ← هنا
          onPressed: () {
            context.read<SignInCubit>().submitSignIn();
          },
        );
      },
    );
  }
}

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.locale.languageCode == 'en'
            ? context.setLocale(Locale('ar'))
            : context.setLocale(Locale('en'));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.public_rounded,
            size: 17.sp,
            color: AppColors.saltBox600,
          ),
          const HSpace(10),
          Text(
            context.locale.languageCode == 'en'
                ? AppStrings.switchToArabic.ts
                : AppStrings.switchToEnglish.ts,
            strutStyle: const StrutStyle(forceStrutHeight: true),
            style: Theme.of(context)
                .textTheme
                .kCaptionSemiBold
                .copyWith(color: AppColors.saltBox800),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "poweredBy".ts,
          style: Theme.of(context)
              .textTheme
              .kCaptionRegular
              .copyWith(color: AppColors.saltBox500),
        ),
        const HSpace(4),
      ],
    );
  }
}

class DontHaveAcountButton extends StatelessWidget {
  const DontHaveAcountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’tHaveAnAccount".ts,
          style: Theme.of(context)
              .textTheme
              .kHeadingH1ExtraBold
              .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 2),
        TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              context.toNamed(
                AppRoutes.signupRoute,
              );
            },
            child: Text(
              "SignUp".ts,
              style: Theme.of(context).textTheme.kHeadingH1ExtraBold.copyWith(
                  fontSize: 12,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w400),
            )),
      ],
    );
  }
}
