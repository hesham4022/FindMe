import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/Home/presentation/widgets/search_textField.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SearchTextfield(
            controller: controller,
            enabled: true,
            onChanged: (value) {
              context.read<AllCasesCubit>().searchByName(value);
            },
          ),
        ),
      ),
      body: BlocBuilder<AllCasesCubit, AllCasesState>(
        builder: (context, state) {
          if (state.filtered == null || state.filtered!.isEmpty) {
            return const Center(
              child: Text(
                "No cases found",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.filtered!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CaseCard(caseModel: state.filtered![index]),
              );
            },
          );
        },
      ),
    );
  }
}
