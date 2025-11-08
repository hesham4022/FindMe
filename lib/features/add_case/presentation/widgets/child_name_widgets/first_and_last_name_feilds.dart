import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/add_case_child_info_fields.dart';
import 'package:flutter/material.dart';

class FirstAndLastNameFeilds extends StatelessWidget {
  const FirstAndLastNameFeilds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Child name:",
            style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        VSpace(5),
        const IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ChildNameField(),
                ),
              ),
              HSpace(5),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ChildLastNameField(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
