import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_listener.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/child_info.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/incident_details_container.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/consent_verification_section.dart';
import 'package:find_me_app/features/add_case/presentation/widgets_Missing/reporterinformation.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCaseView extends StatelessWidget {
  const AddCaseView({super.key, this.caseToEdit});
  final CaseInfoModel? caseToEdit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddCaseCubit(sl(), sl())..fillWithCase(caseToEdit),
      child: _AddCaseViewBody(caseToEdit: caseToEdit),
    );
  }
}

class _AddCaseViewBody extends StatelessWidget {
  const _AddCaseViewBody({this.caseToEdit});
  final CaseInfoModel? caseToEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          caseToEdit == null
              ? "Report a Missing or Abducted Child"
              : "Edit Report",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: BlocBuilder<AddCaseCubit, AddCaseState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Text(
                  "What are you reporting?",
                  style: TextStyle(fontSize: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ReportType>(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.secondColor;
                            }
                            return Colors.white;
                          }),
                        ),
                        segments: const [
                          ButtonSegment(
                            value: ReportType.missingChild,
                            label: Text('Missing child'),
                          ),
                          ButtonSegment(
                            value: ReportType.foundChild,
                            label: Text('Found child'),
                          ),
                        ],
                        selected: {state.reportType ?? ReportType.missingChild},
                        onSelectionChanged: (newSelection) {
                          context
                              .read<AddCaseCubit>()
                              .reportTypeChanged(newSelection.first);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      const ChildInfo(),
                      const VSpace(35),
                      const IncidentDetailsContainer(),
                      const VSpace(35),
                      const ReporterInformation(),
                      const VSpace(35),
                      const ConsentVerificationSection(),
                      const VSpace(40),
                      BlocListener<AddCaseCubit, AddCaseState>(
                        listener: addCaseListener,
                        child: BlocBuilder<AddCaseCubit, AddCaseState>(
                          builder: (context, state) {
                            return CustomFilledButton(
                              state: context.read<AddCaseCubit>().isFormValid
                                  ? CustomState.active
                                  : CustomState.disabled,
                              color: Colors.red,
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      if (caseToEdit == null) {
                                        context
                                            .read<AddCaseCubit>()
                                            .submitReport(context);
                                      } else {
                                        context
                                            .read<AddCaseCubit>()
                                            .updateReport(
                                                context, caseToEdit!.id!);
                                      }
                                    },
                              title: Text(
                                caseToEdit == null
                                    ? "Send alert now"
                                    : "Edit Report",
                                style: Theme.of(context)
                                    .textTheme
                                    .kDisplay02ExtraBold
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                              ),
                              loading: state.isLoading,
                              width: 200,
                              radius: 20,
                            );
                          },
                        ),
                      ),
                      const VSpace(40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
