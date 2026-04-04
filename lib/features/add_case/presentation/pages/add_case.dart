import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/data/repo/add_case_repo.dart';
import 'package:find_me_app/features/add_case/data/repo/update_case_repo.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_action/cubit/case_action_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_action/cubit/case_action_state.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_form/cubit/case_form_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/case_form/cubit/case_form_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CaseFormCubit(),
        ),
        BlocProvider(
          create: (_) =>
              CaseActionCubit(sl<AddCasesRepo>(), sl<UpdateCaseRepo>()),
        ),
      ],
      child: const _AddCaseViewBody(),
    );
    // BlocProvider(
    //   create: (_) => AddCaseCubit(sl(), sl())..fillWithCase(caseToEdit),
    //   child: _AddCaseViewBody(caseToEdit: caseToEdit),
    // );
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
      body: BlocBuilder<CaseFormCubit, CaseFormState>(
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
                      BlocListener<CaseActionCubit, CaseActionState>(
                        listener: addCaseListener,
                        child: BlocBuilder<CaseFormCubit, CaseFormState>(
                          builder: (context, formState) {
                            final formCubit = context.read<CaseFormCubit>();
                            final actionState =
                                context.watch<CaseActionCubit>().state;

                            final isEnabled = caseToEdit == null
                                ? formCubit.isFormValid
                                : formCubit.canUpdate;

                            return CustomFilledButton(
                              state: isEnabled
                                  ? CustomState.active
                                  : CustomState.disabled,
                              color: Colors.red,
                              onPressed: actionState.isLoading
                                  ? null
                                  : () {
                                      if (!formCubit.validateForm()) return;

                                      final actionCubit =
                                          context.read<CaseActionCubit>();

                                      if (caseToEdit == null) {
                                        actionCubit.addCase(formCubit.state);
                                      } else {
                                        actionCubit.updateCase(
                                            formCubit.state, caseToEdit!.id!);
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
                              loading: actionState.isLoading,
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
