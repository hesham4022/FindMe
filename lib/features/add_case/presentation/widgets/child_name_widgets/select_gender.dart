import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedGender extends StatelessWidget {
  final List<String> labels;

  const SelectedGender({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCaseCubit, AddCaseState>(
      buildWhen: (prev, curr) =>
          prev.gender != curr.gender ||
          prev.genderErrorText != curr.genderErrorText,
      builder: (context, state) {
        final selectedIndex =
            state.gender != null ? labels.indexOf(state.gender!) : -1;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Gender:",
                style: Theme.of(context).textTheme.kHeadingH3SmallBold.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
              ),
            ),
            VSpace(5),
            Row(
              children: List.generate(labels.length, (index) {
                final isSelected = selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // 👈 أهم سطر
                      minimumSize: const Size(61, 25),
                      side: const BorderSide(color: Colors.black),
                      backgroundColor: isSelected
                          ? AppColors.mainColor
                          : AppColors.secondColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      final selectedGender = labels[index];
                      context
                          .read<AddCaseCubit>()
                          .genderChanged(selectedGender);
                    },
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                );
              }),
            ),
            if (state.genderErrorText != null &&
                state.genderErrorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text(
                  state.genderErrorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
