import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/no_internet_widgit.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({
    required this.state,
  });

  final AllCasesState state;

  @override
  Widget build(BuildContext context) {
    final isNoInternet = state.failure is InternetFailure;

    if (state.imageSearchStatus == AllCasesStatus.loading) {
      return Container(
        height: 260,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    if (isNoInternet) {
      return NoInternetWidget(
        onRetry: () => context.read<AllCasesCubit>().submitImageSearch(),
      );
    }

    if (state.imageSearchStatus == AllCasesStatus.error) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 42,
            ),
            const SizedBox(height: 12),
            Text(
              state.failure?.msg ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (state.filtered.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade500,
              size: 42,
            ),
            const SizedBox(height: 12),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try searching with a different name or another image.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: state.filtered.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CaseCard(
          caseModel: state.filtered[index],
          onTap: () {
            context.toNamed(
              AppRoutes.caseInfoRoute,
              arguments: {
                'case': state.filtered[index],
                'cubit': context.read<AllCasesCubit>(),
              },
            );
          },
        );
      },
    );
  }
}
