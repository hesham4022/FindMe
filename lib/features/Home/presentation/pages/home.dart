import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/animated_transition_widget/animated_transition_widget.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';
import 'package:find_me_app/features/Home/presentation/widgets/case_item.dart';
import 'package:find_me_app/features/Home/presentation/widgets/custome_appBar.dart';
import 'package:find_me_app/features/Home/presentation/widgets/search_textField.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageNoNavBar extends StatelessWidget {
  HomePageNoNavBar({
    super.key,
  });

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HomeHeaderAppBar(onBellTap: () {}),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlurryModalProgressHUD(
          inAsyncCall: context.watch<AllCasesCubit>().state.isLoading,
          progressIndicator: const CustomLoadingWidget(),
          blurEffectIntensity: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: SearchTextfield(
                  controller: controller,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: const Color(0xFFCFE6F3),
                    child: Image.asset(
                      'assets/images/Map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<AllCasesCubit, AllCasesState>(
                    builder: (context, state) {
                      final recentCases =
                          context.read<AllCasesCubit>().getLatestFiveCases();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Cases',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (recentCases.isNotEmpty)
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await context
                                      .read<AllCasesCubit>()
                                      .getAllCasesResponseData();
                                },
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: recentCases.length < 5
                                      ? recentCases.length
                                      : 5,
                                  itemBuilder: (context, index) =>
                                      TransitionSlidingWidget(
                                    slidingDirection: index % 2 == 1
                                        ? SlidingDirection.fromLeft
                                        : SlidingDirection.fromRight,
                                    duration: 2,
                                    child: CaseCard(
                                      caseModel: recentCases[index],
                                      onTap: () {
                                        context.toNamed(
                                          AppRoutes.caseInfoRoute,
                                          // arguments: recentCases[index],
                                          arguments: {
                                            'case': recentCases[index],
                                            'cubit':
                                                context.read<AllCasesCubit>(),
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else if (!state.isLoading)
                            const Text(
                              "No recent cases found",
                              style: TextStyle(color: Colors.grey),
                            ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
