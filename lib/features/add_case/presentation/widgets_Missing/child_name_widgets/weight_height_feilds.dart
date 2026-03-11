import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/add_case_child_info_fields.dart';
import 'package:flutter/material.dart';

class WeightHeightFeilds extends StatelessWidget {
  const WeightHeightFeilds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Weight & Height:",
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
          ),
        ),
        const VSpace(5),
        const Row(
          children: [
            Expanded(child: WeightField()),
            HSpace(5),
            Expanded(child: HeightField()),
          ],
        )
      ],
    );
  }
}
