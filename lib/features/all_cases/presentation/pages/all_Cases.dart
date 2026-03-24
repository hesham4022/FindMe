// ignore_for_file: dead_code

import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/animated_transition_widget/animated_transition_widget.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/circle_icon_appBar.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/filter_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class AllCasesView extends StatefulWidget {
  const AllCasesView({super.key});

  @override
  State<AllCasesView> createState() => _AllCasesViewState();
}

class _AllCasesViewState extends State<AllCasesView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hideBackButton: true,
        title: const Text("All Cases"),
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleIconAppbar(
              asset: 'assets/icons/searchIcon.svg',
              onTap: () {
                context.toNamed(AppRoutes.searchRoute);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Sort By"),
                const HSpace(5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.mainColor,
                  ),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'A ', style: TextStyle(color: Colors.white)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.arrow_right_alt,
                              size: 18, color: Colors.white),
                        ),
                        TextSpan(
                            text: ' Z', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // فلتر Favorites
                const FilterCases(
                  iconOn: Icons.star,
                  iconOff: Icons.star_border,
                  filter: AllCasesFilter.favorites,
                ),

                //  Female filter
                const FilterCases(
                  iconOn: Icons.female,
                  iconOff: Icons.female,
                  filter: AllCasesFilter.female,
                ),

                // فلتر Male
                const FilterCases(
                  iconOn: Icons.male,
                  iconOff: Icons.male,
                  filter: AllCasesFilter.male,
                ),
              ],
            ),
            const VSpace(15),
            Expanded(
              child: BlocBuilder<AllCasesCubit, AllCasesState>(
                builder: (context, state) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      context
                          .read<AllCasesCubit>()
                          .updateScroll(notification.metrics.pixels);
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<AllCasesCubit>()
                            .getAllCasesResponseData();
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: state.filtered.length,
                        itemBuilder: (context, index) =>
                            TransitionSlidingWidget(
                          slidingDirection: index % 2 == 1
                              ? SlidingDirection.fromLeft
                              : SlidingDirection.fromRight,
                          duration: 2,
                          child: GestureDetector(
                            onTap: () => context.toNamed(
                                AppRoutes.caseInfoRoute,
                                arguments: state.filtered[index]),
                            child: CaseCard(
                              caseModel: state.filtered[index],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ScrollingFabAnimated(
          color: AppColors.mainColor,
          radius: 24,
          width: 140,
          height: 60,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          text: const Text(
            'Add Case',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          onPress: () {
            context.toNamed(AppRoutes.addCaseView);
          },
          scrollController: _scrollController,
          animateIcon: true,
          inverted: false,
        ),
      ),
    );
  }
}
