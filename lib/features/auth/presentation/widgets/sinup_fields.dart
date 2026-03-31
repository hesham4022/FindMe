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
import 'package:find_me_app/features/auth/presentation/cubit/sinup/sinup_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';

// class NameField extends StatelessWidget {
//   const NameField({
//     super.key,
//     this.onSubmit,
//   });

//   final Function(String)? onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SinupCubit, SinupState>(
//       // buildWhen: (previous, current) => (previous != current.nameErrorText),
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "fullNameLabel".ts,
//               style: Theme.of(context).textTheme.kSubheadingRegular,
//             ),
//             VSpace(10),
//             CustomTextField(
//                 hint: "hintname".ts,
//                 errorText: state.nameErrorText,
//                 prefixIcon: Icon(
//                   Icons.account_circle_outlined,
//                   size: 20.sp,
//                   color: AppColors.saltBox600,
//                 ),
//                 onSubmit: onSubmit,
//                 onChanged: (value) {
//                   context.read<SinupCubit>().nameChanged(value);
//                 },
//                 onValidate: (value) {
//                   final err = AppValidators.validateUsername(
//                       value); // String? (null لو صحيح)
//                   // خزّن الرسالة في الـ state عشان UI تقدر تعرضها
//                   context.read<SinupCubit>().nameErrorTextChanged(err ?? "");
//                   // مهم: رجّع null لما الإدخال صحيح
//                   return (err == null || err.trim().isEmpty) ? null : err;
//                 }),
//           ],
//         );
//       },
//     );
//   }
// }

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "fullNameLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "hintname".ts,
              errorText: state.nameErrorText,
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<SinupCubit>().nameChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validateUsername(value);
                context.read<SinupCubit>().nameErrorTextChanged(err ?? "");
                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

// class FullNameField extends StatelessWidget {
//   const FullNameField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SinupCubit, SinupState>(
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "fullNameLabel".ts,
//               style: Theme.of(context).textTheme.kSubheadingRegular,
//             ),
//             const VSpace(10),
//             CustomTextField(
//               errorText: state.nameErrorText,
//               hint: "hintname".ts,
//               prefixIcon: Icon(
//                 MdiIcons.lockOpenVariantOutline,
//                 size: 20.sp,
//                 color: AppColors.saltBox600,
//               ),
//               onChanged: (value) {
//                 context.read<SinupCubit>().nameChanged(value);
//               },
//               onValidate: (value) {
//                 final errorText = AppValidators.validateUsername(value);
//                 context
//                     .read<SinupCubit>()
//                     .nameErrorTextChanged(errorText ?? "");
//                 return errorText;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
class FullNameField extends StatefulWidget {
  const FullNameField({super.key});

  @override
  State<FullNameField> createState() => _FullNameFieldState();
}

class _FullNameFieldState extends State<FullNameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final state = context.read<SinupCubit>().state;

    _controller = TextEditingController(
      text: state.fullName ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SinupCubit, SinupState>(
      listenWhen: (prev, curr) => prev.fullName != curr.fullName,
      listener: (_, state) {
        if (_controller.text != state.fullName) {
          _controller.text = state.fullName ?? '';
        }
      },
      child: BlocBuilder<SinupCubit, SinupState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "fullNameLabel".ts,
                style: Theme.of(context).textTheme.kSubheadingRegular,
              ),
              const VSpace(10),
              CustomTextField(
                controller: _controller,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SinupCubit>().nameChanged(value);
                },
                hint: "Full Name",
                errorText: state.nameErrorText,
                onValidate: (value) {
                  final errorText = AppValidators.validateUsername(value);
                  context
                      .read<SinupCubit>()
                      .nameErrorTextChanged(errorText ?? "");
                  return errorText;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class SignUpPasswordField extends StatelessWidget {
  const SignUpPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "passordLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            RPasswordField(
              errorText: state.passwordErrorText,
              hint: '******',
              prefixIcon: Icon(
                MdiIcons.lockOpenVariantOutline,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onChanged: (value) {
                context.read<SinupCubit>().passwordChanged(value);
              },
              validate: (value) {
                final errorText = AppValidators.validateSignInPassword(value);
                context
                    .read<SinupCubit>()
                    .passwordErrorTextChanged(errorText ?? "");
                return errorText;
              },
            ),
          ],
        );
      },
    );
  }
}

class SignUpConfirmPasswordField extends StatelessWidget {
  const SignUpConfirmPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      buildWhen: (previous, current) =>
          previous.passwordConfirmationErrorText !=
              current.passwordConfirmationErrorText ||
          previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "confirmpassordLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            RPasswordField(
              errorText: state.passwordConfirmationErrorText,
              hint: "******",
              prefixIcon: Icon(
                MdiIcons.lockOpenVariantOutline,
                size: 20.sp,
                color: AppColors.saltBox600,
              ),
              onChanged: (value) {
                context.read<SinupCubit>().passwordConfirmChanged(value);
              },
              validate: (value) {
                final password = context.read<SinupCubit>().state.password;
                String? errorText;

                if (value == null || value.isEmpty) {
                  errorText = "Field is required";
                } else if (value != password) {
                  errorText = "Passwords do not match";
                }
                context
                    .read<SinupCubit>()
                    .passwordConfirmErrorTextChanged(errorText ?? "");
                return errorText;
              },
            ),
          ],
        );
      },
    );
  }
}

class SinUpUserNameField extends StatelessWidget {
  const SinUpUserNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "emailLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: AppStrings.username.ts,
                errorText: state.emailErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.emailAddress,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<SinupCubit>().emailChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateEmail(value);
                  context.read<SinupCubit>().emailErrorTextChanged(err ?? "");
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "phoneNumberLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: "hintPhone".ts,
                errorText: state.phoneErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.number,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<SinupCubit>().phoneChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validatePhoneNumber(value);
                  context.read<SinupCubit>().phoneErrorTextChanged(err ?? "");
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class NationalIdField extends StatelessWidget {
  const NationalIdField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "nationalidLabel".ts,
              style: Theme.of(context).textTheme.kSubheadingRegular,
            ),
            const VSpace(10),
            CustomTextField(
                hint: "hintId".ts,
                errorText: state.nationalIdErrorText,
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.saltBox600,
                ),
                keyboardType: TextInputType.number,
                onSubmit: onSubmit,
                onChanged: (value) {
                  context.read<SinupCubit>().nationalIdChanged(value);
                },
                onValidate: (value) {
                  final err = AppValidators.validateNumber(value);
                  context
                      .read<SinupCubit>()
                      .nationalIdErrorTextChanged(err ?? "");
                  return (err == null || err.trim().isEmpty) ? null : err;
                }),
          ],
        );
      },
    );
  }
}

class UplaodNationalId extends StatelessWidget {
  const UplaodNationalId({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SinupCubit>();

    return BlocBuilder<SinupCubit, SinupState>(
      buildWhen: (prev, curr) =>
          prev.nationalIdImages != curr.nationalIdImages ||
          prev.nationalPhotoPathErrorText != curr.nationalPhotoPathErrorText,
      builder: (context, state) {
        final images = state.nationalIdImages;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "upLaodNationalId".ts,
              style: Theme.of(context).textTheme.kHeadingH3SemiBold.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 5),

            // زرار الرفع
            MaterialButton(
              minWidth: 94.w,
              height: 45.h,
              onPressed: () async {
                await cubit.pickNationalIdImages();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              color: const Color(0xffECF1FF),
              child: const Text(
                "Upload",
                style: TextStyle(color: Color(0xff809CFF)),
              ),
            ),

            if (state.nationalPhotoPathErrorText != null &&
                state.nationalPhotoPathErrorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.nationalPhotoPathErrorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // معاينة الصور
            if (images.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final xf = images[i];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: kIsWeb
                                ? FutureBuilder<Uint8List>(
                                    future: xf.readAsBytes(),
                                    builder: (context, snap) {
                                      if (!snap.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return Image.memory(snap.data!,
                                          fit: BoxFit.cover);
                                    },
                                  )
                                : Image.file(File(xf.path), fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () => cubit.removeNationalIdImageAt(i),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "${"ByContinuing,YouAgreeTo".ts}\n",
        style: Theme.of(context).textTheme.kHeadingH3SemiBold.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
        children: [
          TextSpan(
            text: "Terms of Use".ts,
            style: const TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Terms page
              },
          ),
          TextSpan(text: "and".ts, style: const TextStyle(fontSize: 12)),
          TextSpan(
            text: "Privacy Policy".ts,
            style: const TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Privacy page
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinupCubit, SinupState>(
      builder: (context, state) {
        return CustomFilledButton(
          state: context.read<SinupCubit>().isFormValid
              ? CustomState.active
              : CustomState.disabled,
          width: 0.55.sw,
          height: 45.h,
          radius: 30.r,
          title: Text(
            "SignUp".ts,
            style: Theme.of(context)
                .textTheme
                .kHeadingH4SmallBold
                .copyWith(fontSize: 22.sp),
          ),
          color: AppColors.mainColor,
          loading: state.isLoading,
          onPressed: () {
            context.read<SinupCubit>().submitSinUp(context);
          },
        );
      },
    );
  }
}

class AlreadyHaveAcountButton extends StatelessWidget {
  const AlreadyHaveAcountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "already have an account?",
          style: Theme.of(context)
              .textTheme
              .kHeadingH1ExtraBold
              .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 2),
        TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // 👈 مهم عشان يشيل البادينج الافتراضي
              minimumSize: Size(0, 0), // 👈 يخلي الزر على قد النص
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              context.toNamed(
                AppRoutes.signinRoute,
              );
            },
            child: Text(
              "Log In",
              style: Theme.of(context).textTheme.kHeadingH1ExtraBold.copyWith(
                  fontSize: 12,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500),
            )),
      ],
    );
  }
}
