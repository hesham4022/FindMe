import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildFirstNameField extends StatelessWidget {
  const ChildFirstNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return CustomTextField(
            radius: 30,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            hint: "First name".ts,
            errorText: state.firstNameErrorText,
            onSubmit: onSubmit,
            onChanged: (value) {
              context.read<AddCaseCubit>().firstNameChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateUsername(value);
              context.read<AddCaseCubit>().firstNameErrorTextChanged(err ?? "");

              return (err == null || err.trim().isEmpty) ? null : err;
            });
      },
    );
  }
}

class ChildLastNameField extends StatelessWidget {
  const ChildLastNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return CustomTextField(
            radius: 30,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            hint: "lastname".ts,
            errorText: state.lastNameErrorText,
            onSubmit: onSubmit,
            onChanged: (value) {
              context.read<AddCaseCubit>().lastNameChanged(value);
            },
            onValidate: (value) {
              final err = AppValidators.validateLastName(value);
              context.read<AddCaseCubit>().lastNameErrorTextChanged(err ?? "");

              return (err == null || err.trim().isEmpty) ? null : err;
            });
      },
    );
  }
}

class AgeField extends StatelessWidget {
  const AgeField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Age:",
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            VSpace(5),
            CustomTextField(
              radius: 30,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Age".ts,
              errorText: state.ageErrorText,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().ageChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validateAge(value);
                context.read<AddCaseCubit>().ageErrorChanged(err ?? "");
                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class AddressOfChild extends StatelessWidget {
  const AddressOfChild({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Address".ts,
                style: Theme.of(context).textTheme.kSubheadingRegular.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const VSpace(5),
            CustomTextField(
              radius: 30,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Cairo , Giza".ts,
              errorText: state.addressErrorText,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().addressChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validateAddress(value);
                context.read<AddCaseCubit>().addressErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class WeightField extends StatelessWidget {
  const WeightField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return CustomTextField(
          radius: 30,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          hint: "Weight in kg".ts,
          errorText: state.weightErrorText,
          onSubmit: onSubmit,
          onChanged: (value) {
            context.read<AddCaseCubit>().weightChanged(value);
          },
          onValidate: (value) {
            final err = AppValidators.validateUsername(value);
            context.read<AddCaseCubit>().weightErrorChanged(err ?? "");
            return (err == null || err.trim().isEmpty) ? null : err;
          },
        );
      },
    );
  }
}

class HeightField extends StatelessWidget {
  const HeightField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return CustomTextField(
          radius: 30,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          hint: "Height in cm".ts,
          errorText: state.heightErrorText,
          // errorText: "Feild is required",
          onSubmit: onSubmit,
          onChanged: (value) {
            context.read<AddCaseCubit>().heightChanged(value);
          },
          onValidate: (value) {
            final err = AppValidators.validateUsername(value);
            context.read<AddCaseCubit>().heightErrorChanged(err ?? "");
            return (err == null || err.trim().isEmpty) ? null : err;
          },
        );
      },
    );
  }
}

class ClothingDescroptionField extends StatelessWidget {
  const ClothingDescroptionField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Clothing description:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const VSpace(5),
            CustomTextField(
              maxLines: 3,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "what they were last seen wearing".ts,
              errorText: state.clothingDescriptionErrorText,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().clothingDescriptionChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validateUsername(value);
                context
                    .read<AddCaseCubit>()
                    .clothingDescriptionErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}

class OtherIdentifyingDetailsField extends StatelessWidget {
  const OtherIdentifyingDetailsField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Other Identifying Details:".ts,
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const VSpace(5),
            CustomTextField(
              maxLines: 3,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "birthmarks, scars, accessories, hairstyle".ts,
              errorText: state.descriptionErrorText,
              // errorText: "Feild is required",
              onSubmit: onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().descriptionChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validateUsername(value);
                context.read<AddCaseCubit>().descriptionErrorChanged(err ?? "");

                return (err == null || err.trim().isEmpty) ? null : err;
              },
            ),
          ],
        );
      },
    );
  }
}
