import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/search_case/presentation/pages/result_section.dart';
import 'package:find_me_app/features/search_case/presentation/pages/section_header.dart';
import 'package:find_me_app/features/search_case/presentation/widgets/image_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchByImage extends StatelessWidget {
  SearchByImage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<AllCasesCubit>().resetSearch();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FD),
        appBar: const CustomAppBar(
          titleText: "search By Image",
        ),
        body: BlocBuilder<AllCasesCubit, AllCasesState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    children: [
                      ImageSearchCard(
                        state: state,
                        onChooseImage: () {
                          controller.clear();
                          context.read<AllCasesCubit>().selectImage();
                        },
                        onStartSearch: () {
                          context.read<AllCasesCubit>().submitImageSearch();
                        },
                        onRemoveImage: () {
                          context.read<AllCasesCubit>().clearSelectedImage();
                        },
                      ),
                      const SizedBox(height: 20),
                      SectionHeader(
                        title: state.isImageSearch
                            ? 'Matched Results'
                            : 'All Cases',
                        subtitle: state.isImageSearch
                            ? (state.searchMessage ??
                                'Search results based on selected image')
                            : 'Browse and search by child Image',
                      ),
                      const SizedBox(height: 12),
                      ResultsSection(state: state),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
