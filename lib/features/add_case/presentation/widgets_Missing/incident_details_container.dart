import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/half_width_field.dart';
import 'package:find_me_app/core/shared/widgets/partial_width_field.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/incident_details_wedgits/incident_details_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncidentDetailsContainer extends StatelessWidget {
  const IncidentDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final halfWidth = MediaQuery.of(context).size.width * 0.5;
    final fieldWidth = MediaQuery.of(context).size.width * 0.62;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
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
          const HalfWidthField(child: DateTimeLastSeenField()),
          const VSpace(10),
          const HalfWidthField(child: LastKnownLocation()),
          const VSpace(10),
          const PartialWidthField(child: FullBreakdownOfTheincidentField()),
          const VSpace(10),
          SizedBox(width: fieldWidth, child: const VehicleDetailsField()),
          _ConditionalLocationField(fieldWidth: fieldWidth),
          const VSpace(10),
        ],
      ),
    );
  }
}

class _ConditionalLocationField extends StatelessWidget {
  const _ConditionalLocationField({required this.fieldWidth});
  final double fieldWidth;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCaseCubit, AddCaseState, ReportType?>(
      selector: (state) => state.reportType,
      builder: (context, reportType) {
        if (reportType != ReportType.foundChild) return const SizedBox.shrink();
        return const Column(
          children: [
            VSpace(10),
            PartialWidthField(child: CurrentChildLocationField()),
          ],
        );
      },
    );
  }
}
