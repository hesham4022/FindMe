import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/reporter_information_widgets/reporter_information_feilds.dart';

import 'package:flutter/material.dart';

class ReporterInformation extends StatelessWidget {
  const ReporterInformation({super.key});

  static const _fieldWidthFactor = 0.70;
  static const _spacing = 10.0;

  @override
  Widget build(BuildContext context) {
    final fields = [
      const FullNameField(),
      const RelationshipChildField(),
      const PhoneNumberField(),
      const EmailAddressField(),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fieldWidth = constraints.maxWidth * _fieldWidthFactor;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Reporter's Information:".ts,
                  style: Theme.of(context)
                      .textTheme
                      .kHeadingH2ExtraBold
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const VSpace(_spacing),
              ...fields.map(
                (field) => Padding(
                  padding: const EdgeInsets.only(bottom: _spacing),
                  child: SizedBox(width: fieldWidth, child: field),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
