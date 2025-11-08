import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/circle_icon_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCases extends StatelessWidget {
  final IconData iconOn;
  final IconData iconOff;
  final AllCasesFilter filter;

  const FilterCases({
    super.key,
    required this.iconOn,
    required this.iconOff,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCasesCubit, AllCasesState>(
      buildWhen: (p, c) => p.activeFilter != c.activeFilter,
      builder: (context, state) {
        final isActive = state.activeFilter == filter;

        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleIconBody(
            icon: isActive ? iconOn : iconOff,
            iconColor: isActive ? Colors.white : AppColors.mainColor,
            color: isActive ? AppColors.mainColor : AppColors.secondColor,
            onPressed: () {
              context.read<AllCasesCubit>().toggleFilter(filter);
            },
          ),
        );
      },
    );
  }
}
