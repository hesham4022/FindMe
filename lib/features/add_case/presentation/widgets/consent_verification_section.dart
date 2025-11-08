import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class ConsentVerificationSection extends StatelessWidget {
  const ConsentVerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      buildWhen: (prev, curr) =>
          prev.confirmInformation != curr.confirmInformation ||
          prev.consentToShare != curr.consentToShare ||
          prev.consentErrorText != curr.consentErrorText,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Consent & Verification".ts,
              style: Theme.of(context).textTheme.kDisplay02SemiBold.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const VSpace(20),
            BuildConsentItem(
              text:
                  "I confirm that the information provided is\ntrue to the best of my knowledge.",
              value: state.confirmInformation,
              onChanged: (value) {
                context
                    .read<AddCaseCubit>()
                    .confirmInformationChanged(value ?? false);
              },
            ),
            const VSpace(16),
            BuildConsentItem(
              text:
                  "I consent to sharing this information\npublicly to help locate the child.",
              value: state.consentToShare,
              onChanged: (value) {
                context
                    .read<AddCaseCubit>()
                    .consentToShareChanged(value ?? false);
              },
            ),
            if (state.consentErrorText != null &&
                state.consentErrorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  state.consentErrorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

class BuildConsentItem extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const BuildConsentItem({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(width: 8),
        Checkbox(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
