import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/Home/presentation/widgets/search_textField.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  TextEditingController controller = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickAndSearchImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        controller.clear();

        if (mounted) {
          context.read<AllCasesCubit>().searchByImage(image.path);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error: $e')),
        );
      }
    }
  }

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
        appBar: CustomAppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SearchTextfield(
              enabled: true,
              controller: controller,
              onChanged: (value) {
                context.read<AllCasesCubit>().searchByName(value);
              },
            ),
          ),
        ),
        body: Column(
          children: [
            // search by image button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: _pickAndSearchImage,
                icon: const Icon(Icons.image_search),
                label: const Text('Search By Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<AllCasesCubit, AllCasesState>(
                builder: (context, state) {
                  // التحميل
                  if (state.status == AllCasesStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // error
                  if (state.status == AllCasesStatus.error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.failure?.msg ?? 'error',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.filtered == null || state.filtered!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Results match',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // display result
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filtered.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CaseCard(
                          caseModel: state.filtered[index],
                          onTap: () {
                            context.toNamed(
                              AppRoutes.caseInfoRoute,
                              // arguments: recentCases[index],
                              arguments: {
                                'case': state.filtered[index],
                                'cubit': context.read<AllCasesCubit>(),
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
