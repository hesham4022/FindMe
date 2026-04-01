import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildFirstNameField extends StatefulWidget {
  const ChildFirstNameField({
    super.key,
  });

  @override
  State<ChildFirstNameField> createState() => _ChildFirstNameFieldState();
}

class _ChildFirstNameFieldState extends State<ChildFirstNameField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.firstName ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return CustomTextField(
            controller: _controller,
            radius: 30,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            hint: "First name".ts,
            errorText: state.firstNameErrorText,
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

class ChildLastNameField extends StatefulWidget {
  const ChildLastNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<ChildLastNameField> createState() => _ChildLastNameFieldState();
}

class _ChildLastNameFieldState extends State<ChildLastNameField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.lastName ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return CustomTextField(
            controller: _controller,
            radius: 30,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            hint: "lastname".ts,
            errorText: state.lastNameErrorText,
            onSubmit: widget.onSubmit,
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

class AgeField extends StatefulWidget {
  const AgeField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<AgeField> createState() => _AgeFieldState();
}

class _AgeFieldState extends State<AgeField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.age?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            const VSpace(5),
            CustomTextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              radius: 30,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Age".ts,
              errorText: state.ageErrorText,
              // errorText: "Feild is required",
              onSubmit: widget.onSubmit,
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

class AddressOfChild extends StatefulWidget {
  const AddressOfChild({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<AddressOfChild> createState() => _AddressOfChildState();
}

class _AddressOfChildState extends State<AddressOfChild> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.address ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              controller: _controller,
              radius: 30,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "Cairo , Giza".ts,
              errorText: state.addressErrorText,
              // errorText: "Feild is required",
              onSubmit: widget.onSubmit,
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

class WeightField extends StatefulWidget {
  const WeightField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.weight?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return CustomTextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          radius: 30,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          hint: "Weight in kg".ts,
          errorText: state.weightErrorText,
          onSubmit: widget.onSubmit,
          onChanged: (value) {
            context.read<AddCaseCubit>().weightChanged(value);
          },
          onValidate: (value) {
            final err = AppValidators.validateWeight(value);
            context.read<AddCaseCubit>().weightErrorChanged(err ?? "");
            return (err == null || err.trim().isEmpty) ? null : err;
          },
        );
      },
    );
  }
}

class HeightField extends StatefulWidget {
  const HeightField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<HeightField> createState() => _HeightFieldState();
}

class _HeightFieldState extends State<HeightField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.height?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
        return CustomTextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          radius: 30,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          hint: "Height in cm".ts,
          errorText: state.heightErrorText,
          // errorText: "Feild is required",
          onSubmit: widget.onSubmit,
          onChanged: (value) {
            context.read<AddCaseCubit>().heightChanged(value);
          },
          onValidate: (value) {
            final err = AppValidators.validateHeight(value);
            context.read<AddCaseCubit>().heightErrorChanged(err ?? "");
            return (err == null || err.trim().isEmpty) ? null : err;
          },
        );
      },
    );
  }
}

class ClothingDescroptionField extends StatefulWidget {
  const ClothingDescroptionField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<ClothingDescroptionField> createState() =>
      _ClothingDescroptionFieldState();
}

class _ClothingDescroptionFieldState extends State<ClothingDescroptionField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.clothingDescription ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              controller: _controller,
              maxLines: 3,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "what they were last seen wearing".ts,
              errorText: state.clothingDescriptionErrorText,
              onSubmit: widget.onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().clothingDescriptionChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validatInGeneralStringFielfs(value);
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

class OtherIdentifyingDetailsField extends StatefulWidget {
  const OtherIdentifyingDetailsField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  State<OtherIdentifyingDetailsField> createState() =>
      _OtherIdentifyingDetailsFieldState();
}

class _OtherIdentifyingDetailsFieldState
    extends State<OtherIdentifyingDetailsField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AddCaseCubit>().state.description ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              controller: _controller,
              maxLines: 3,
              radius: 13,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              hint: "birthmarks, scars, accessories, hairstyle".ts,
              errorText: state.descriptionErrorText,
              // errorText: "Feild is required",
              onSubmit: widget.onSubmit,
              onChanged: (value) {
                context.read<AddCaseCubit>().descriptionChanged(value);
              },
              onValidate: (value) {
                final err = AppValidators.validatInGeneralStringFielfs(value);
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
