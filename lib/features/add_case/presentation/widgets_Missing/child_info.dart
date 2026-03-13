import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/partial_width_field.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/add_case_child_info_fields.dart';

import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/first_and_last_name_feilds.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/header_of_child_Info.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/select_gender.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_name_widgets/weight_height_feilds.dart';
import 'package:flutter/material.dart';

class ChildInfo extends StatelessWidget {
  const ChildInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 40, top: 20),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderOfChildInfo(),
          VSpace(10),
          FirstAndLastNameFeilds(),
          VSpace(10),
          Row(
            children: [
              Expanded(child: AddressOfChild()),
              HSpace(5),
              Expanded(child: SizedBox()),
            ],
          ),
          VSpace(10),
          Row(
            children: [
              Expanded(child: AgeField()),
              HSpace(5),
              Expanded(child: SizedBox()),
            ],
          ),
          VSpace(10),
          SelectedGender(labels: ['male', 'female']),
          VSpace(10),
          WeightHeightFeilds(),
          VSpace(10),
          PartialWidthField(child: ClothingDescroptionField()),
          VSpace(10),
          PartialWidthField(child: OtherIdentifyingDetailsField()),
        ],
      ),
    );
  }
}
