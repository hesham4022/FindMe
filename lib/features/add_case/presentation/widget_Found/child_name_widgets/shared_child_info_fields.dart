import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';

class AppChildNameField extends StatelessWidget {
  const AppChildNameField({
    super.key,
    this.onSubmit,
    this.errorText,
    required this.onChanged,
    required this.onValidate,
  });

  final Function(String)? onSubmit;
  final String? errorText;
  final Function(String) onChanged;
  final String? Function(String) onValidate;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      radius: 30,
      contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      hint: "First name",
      errorText: errorText,
      onSubmit: onSubmit,
      onChanged: onChanged,
      onValidate: onValidate,
    );
  }
}

class AppChildLastNameField extends StatelessWidget {
  const AppChildLastNameField({
    super.key,
    this.onSubmit,
    this.errorText,
    required this.onChanged,
    required this.onValidate,
  });

  final Function(String)? onSubmit;
  final String? errorText;
  final Function(String) onChanged;
  final String? Function(String) onValidate;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      radius: 30,
      contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      hint: "Last name",
      errorText: errorText,
      onSubmit: onSubmit,
      onChanged: onChanged,
      onValidate: onValidate,
    );
  }
}

class AppLabeledTextField extends StatelessWidget {
  const AppLabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.onSubmit,
    this.errorText,
    required this.onChanged,
    required this.onValidate,
    this.maxLines = 1,
    this.radius = 30,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
  });

  final String label;
  final String hint;
  final Function(String)? onSubmit;
  final String? errorText;
  final Function(String) onChanged;
  final String? Function(String) onValidate;
  final int maxLines;
  final double radius;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const VSpace(5),
        CustomTextField(
          radius: radius,
          maxLines: maxLines,
          contentPadding: contentPadding,
          hint: hint,
          errorText: errorText,
          onSubmit: onSubmit,
          onChanged: onChanged,
          onValidate: onValidate,
        ),
      ],
    );
  }
}
