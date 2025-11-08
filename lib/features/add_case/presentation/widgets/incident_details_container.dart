import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/incident_details_wedgits/incident_details_feilds.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidentDetailsContainer extends StatelessWidget {
  const IncidentDetailsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Incident details:".ts,
              style: Theme.of(context).textTheme.kHeadingH2ExtraBold.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const VSpace(10),
          SizedBox(
            width: 170.w,
            child: DateTimeLastSeenField(),
          ),
          const VSpace(10),
          SizedBox(
            width: 170.w,
            child: LastKnownLocation(),
          ),
          const VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: FullBreakdownOfTheincidentField(),
          ),
          const VSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.62,
            child: VehicleDetailsField(),
          ),
          VSpace(10),
        ],
      ),
    );
  }
}
