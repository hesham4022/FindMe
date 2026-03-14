import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Your Full Name:".ts,
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
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
          hint: "Name".ts,

          // errorText: state.usernameErrorText,
          // errorText: "Feild is required",
          onSubmit: onSubmit,
          onChanged: (value) {},
          onValidate: (value) {
            final err =
                AppValidators.validateUsername(value); // String? (null لو صحيح)

            return (err == null || err.trim().isEmpty) ? null : err;
          },
        ),
      ],
    );
  }
}

class RelationshipChildField extends StatelessWidget {
  const RelationshipChildField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Relationship to the Child:".ts,
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
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
          hint: "e.g., parent, guardian, relative".ts,

          // errorText: state.usernameErrorText,
          onSubmit: onSubmit,
          onChanged: (value) {},
          onValidate: (value) {
            final err =
                AppValidators.validateUsername(value); // String? (null لو صحيح)

            return (err == null || err.trim().isEmpty) ? null : err;
          },
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Phone Number:".ts,
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
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
          hint: "e.g., parent, guardian, relative".ts,

          // errorText: state.usernameErrorText,
          onSubmit: onSubmit,
          onChanged: (value) {},
          onValidate: (value) {
            final err =
                AppValidators.validateUsername(value); // String? (null لو صحيح)

            return (err == null || err.trim().isEmpty) ? null : err;
          },
        ),
      ],
    );
  }
}

class EmailAddressField extends StatelessWidget {
  const EmailAddressField({
    super.key,
    this.onSubmit,
  });

  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Email address:".ts,
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
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
          hint: "emailLabel".ts,

          // errorText: state.usernameErrorText,
          onSubmit: onSubmit,
          onChanged: (value) {},
          onValidate: (value) {
            final err =
                AppValidators.validateUsername(value); // String? (null لو صحيح)

            return (err == null || err.trim().isEmpty) ? null : err;
          },
        ),
      ],
    );
  }
}
