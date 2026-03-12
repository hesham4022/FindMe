import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/reporter_information_widgets/reporter_information_feilds.dart';

import 'package:flutter/material.dart';

class ReporterInformation extends StatelessWidget {
  const ReporterInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Reporter’s Information:".ts,
              style: Theme.of(context).textTheme.kHeadingH2ExtraBold.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: FullNameField(),
          ),
          VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: RelationshipChildField(),
          ),
          VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: PhoneNumberField(),
          ),
          VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: EmailAddressField(),
          ),
        ],
      ),
    );
  }
}
