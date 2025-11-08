import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/add_case_child_info_fields.dart';

import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/first_and_last_name_feilds.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/header_of_child_Info.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/select_gender.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_name_widgets/weight_height_feilds.dart';
import 'package:flutter/material.dart';

class ChildInfo extends StatelessWidget {
  const ChildInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6, bottom: 40, top: 20),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderOfChildInfo(),
          const VSpace(10),
          const FirstAndLastNameFeilds(),
          const VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.42,
            child: AddressOfChild(),
          ),
          const VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.42,
            child: AgeField(),
          ),
          const VSpace(10),
          const SelectedGender(labels: ['male', 'female']),
          const VSpace(10),
          const WeightHeightFeilds(),
          const VSpace(10),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.62,
          //   child: ClothingDescroptionField(),
          // ),
          const VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: OtherIdentifyingDetailsField(),
          ),
        ],
      ),
    );
  }
}
