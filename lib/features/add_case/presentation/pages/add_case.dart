import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/child_info.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/incident_details_container.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/reporterinformation.dart';
import 'package:find_me_app/features/add_case/presentation/widgets/consent_verification_section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCaseView extends StatelessWidget {
  const AddCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 🟢 هنا بننشئ الكيوبت
      create: (_) => AddCaseCubit(sl()),
      child: const _AddCaseViewBody(),
    );
  }
}

// 🧩 فصل جسم الصفحة لسهولة التعامل مع BlocProvider
class _AddCaseViewBody extends StatelessWidget {
  const _AddCaseViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          "Report a Missing or Abducted Child",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ChildInfo(),
              const VSpace(35),
              const IncidentDetailsContainer(),
              const VSpace(35),
              // const ReporterInformation(),
              const VSpace(20),
              const ConsentVerificationSection(),
              const VSpace(40),
              BlocBuilder<AddCaseCubit, AddCaseState>(
                builder: (context, state) {
                  return CustomFilledButton(
                    color: Colors.red,
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context
                                .read<AddCaseCubit>()
                                .validateFieldsBeforeSubmit(context);
                          },
                    title: Text(
                      state.isLoading ? "Sending..." : "Send alert now",
                      style: Theme.of(context)
                          .textTheme
                          .kDisplay02ExtraBold
                          .copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                    ),
                    width: 200,
                    radius: 20,
                  );
                },
              ),
              const VSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
