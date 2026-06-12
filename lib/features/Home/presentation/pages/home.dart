import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/animated_transition_widget/animated_transition_widget.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';
import 'package:find_me_app/features/Home/presentation/widgets/case_item.dart';
import 'package:find_me_app/features/Home/presentation/widgets/custome_appBar.dart';
import 'package:find_me_app/features/Home/presentation/widgets/search_textField.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageNoNavBar extends StatelessWidget {
  HomePageNoNavBar({
    super.key,
  });

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NotificationsCubit>(),
      child: Builder(builder: (context) {
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
                  const Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: const Text("search by:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        _actionButton(
                          title: "Name",
                          icon: Icons.person,
                          onTap: () {
                            context.toNamed(
                              AppRoutes.searchRoute,
                              arguments: context.read<AllCasesCubit>(),
                            );
                          },
                        ),
                        SizedBox(width: 8),
                        _actionButton(
                          title: "Image",
                          icon: Icons.image,
                          onTap: () {
                            context.toNamed(
                              AppRoutes.searchByImageRoute,
                              arguments: context.read<AllCasesCubit>(),
                            );
                          },
                        ),
                        SizedBox(width: 8),
                        _actionButton(
                          title: "Age Filter",
                          icon: Icons.auto_awesome,
                          onTap: () {
                            context.toNamed(AppRoutes.ageFilterRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       context.toNamed(
                  //         AppRoutes.searchRoute,
                  //         arguments: context.read<AllCasesCubit>(),
                  //       );
                  //     },
                  //     child: AbsorbPointer(
                  //       child: SearchTextfield(
                  //         controller: controller,
                  //         enabled: false,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                          final recentCases = context
                              .read<AllCasesCubit>()
                              .getLatestFiveCases();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Recent Cases:',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<HostCubit>().changeIndex(1);
                                    },
                                    child: const Text(
                                      'Show All Cases',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await context
                                        .read<AllCasesCubit>()
                                        .getAllCasesResponseData();
                                  },
                                  child: Builder(
                                    builder: (context) {
                                      final state =
                                          context.watch<AllCasesCubit>().state;

                                      if (state.isLoading &&
                                          recentCases.isEmpty) {
                                        return ListView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: const [
                                            SizedBox(height: 1),
                                          ],
                                        );
                                      }

                                      if (recentCases.isEmpty) {
                                        return ListView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: const [
                                            SizedBox(height: 200),
                                            Center(
                                              child: Text(
                                                "No recent cases found",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      return ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
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
                                                arguments: {
                                                  'case': recentCases[index],
                                                  'cubit': context
                                                      .read<AllCasesCubit>(),
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
      }),
    );
  }
}

Widget _actionButton({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20),
            SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}
