import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/incident_details_wedgits/incident_details_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidentDetailsContainer extends StatelessWidget {
  const IncidentDetailsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.62;
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      builder: (context, state) {
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
                  style:
                      Theme.of(context).textTheme.kHeadingH2ExtraBold.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                ),
              ),
              const VSpace(10),
              const Row(
                children: [
                  Expanded(
                    child: DateTimeLastSeenField(),
                  ),
                  HSpace(5),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),

              const VSpace(10),
              const Row(
                children: [
                  Expanded(
                    child: LastKnownLocation(),
                  ),
                  HSpace(5),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),

              const VSpace(10),
              SizedBox(
                width: screenWidth,
                child: const FullBreakdownOfTheincidentField(),
              ),
              const VSpace(10),
              SizedBox(
                width: screenWidth,
                child: const VehicleDetailsField(),
              ),
              if (state.reportType == ReportType.foundChild) ...[
                const VSpace(10),
                SizedBox(
                  width: screenWidth,
                  child: const CurrentChildLocationField(),
                ),
              ],
              // VSpace(10),

              VSpace(10),
            ],
          ),
        );
      },
    );
  }
}
