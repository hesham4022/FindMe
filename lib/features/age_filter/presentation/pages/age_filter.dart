import 'dart:io';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:http/http.dart' as http;
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/age_filter/data/repo/age_filter_repo.dart';
import 'package:find_me_app/features/age_filter/data/source/age_filter_remote.dart';
import 'package:find_me_app/features/age_filter/presentation/widget/apply_button.dart';
import 'package:find_me_app/features/age_filter/presentation/widget/filter_result.dart';
import 'package:find_me_app/features/age_filter/presentation/widget/image_card.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AgeFilter extends StatefulWidget {
  const AgeFilter({super.key});

  @override
  State<AgeFilter> createState() => _AgeFilterState();
}

class _AgeFilterState extends State<AgeFilter> with TickerProviderStateMixin {
  File? _selectedImage;
  String? _resultImagePath;
  bool _isLoading = false;
  bool _isResultLoading = false;
  double _sourceAge = 21;
  double _targetAge = 50;
  final ImagePicker _picker = ImagePicker();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final AgeFilterRepo _ageFilterRepo = sl<AgeFilterRepo>();
  String? _resultLocalPath;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        _resultImagePath = null;
      });
    }
  }

  Future<void> _applyFilter() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      _isResultLoading = true;
      _resultImagePath = _selectedImage!.path;
    });

    final request = AgeFilterRequest(
      imagePath: _selectedImage!.path,
      sourceAge: _sourceAge.round(),
      targetAge: _targetAge.round(),
    );

    final result = await _ageFilterRepo.applyAgeFilter(request);

    result.fold(
      (failure) {
        _showSnack(failure.msg, isError: true);
        setState(() {
          _isResultLoading = false;
          _resultImagePath = null;
        });
      },
      (imageUrl) async {
        // ✅ حمّل وحفظ locally فور ما الـ API يرجع
        final response = await http.get(Uri.parse(imageUrl));
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/age_filter_result.jpg');
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _resultImagePath = imageUrl;
          _resultLocalPath = file.path; // ✅ احفظ الـ local path
          _isResultLoading = false;
        });
      },
    );
    setState(() => _isLoading = false);
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            isError ? const Color(0xFFE24B4A) : const Color(0xFF1D9E75),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(titleText: "Age Filter"),
      backgroundColor:
          isDark ? const Color(0xFF0F0F12) : const Color(0xFFF5F4F0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  AgeFilterImageCard(
                    imagePath: _selectedImage?.path,
                    isLoading: _isLoading,
                    onChooseImage: _pickImage,
                    onApplyFilter: _applyFilter,
                    onRemoveImage: () => setState(() {
                      _selectedImage = null;
                      _resultImagePath = null;
                    }),
                  ),
                  const SizedBox(height: 24),
                  _buildAgeControls(isDark),
                  const SizedBox(height: 24),
                  if (_resultImagePath != null || _isResultLoading)
                    BlocProvider(
                      create: (context) => AllCasesCubit(sl(), sl()),
                      child: AgeFilterResultSection(
                        isDark: isDark,
                        isResultLoading: _isResultLoading,
                        resultImagePath: _resultImagePath,
                        selectedImage: _selectedImage!,
                        onClear: () => setState(() {
                          _resultImagePath = null;
                        }),
                        onSearchByImage: (_) {
                          final cubit = AllCasesCubit(sl(), sl());
                          cubit.setLocalImage(_resultLocalPath!);
                          if (mounted) {
                            context.toNamed(AppRoutes.searchByImageRoute,
                                arguments: cubit);
                          }
                        },
                        resultLocalPath: _resultLocalPath,
                      ),
                    ),
                  const SizedBox(height: 8),
                  AgeFilterApplyButton(
                    isLoading: _isLoading,
                    onApply: _applyFilter,
                    pulseAnimation: _pulseAnimation,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeControls(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.08),
        ),
      ),
      child: Column(
        children: [
          _buildAgeSlider(
            label: 'currentAge'.ts,
            value: _sourceAge,
            color: const Color(0xFF5DCAA5),
            onChanged: (v) => setState(() => _sourceAge = v),
            isDark: isDark,
          ),
          Divider(
            height: 28,
            color: isDark
                ? Colors.white.withOpacity(0.07)
                : Colors.black.withOpacity(0.07),
          ),
          _buildAgeSlider(
            label: 'targetAge'.ts,
            value: _targetAge,
            color: const Color(0xFF7F77DD),
            onChanged: (v) => setState(() => _targetAge = v),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildAgeSlider({
    required String label,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.45),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${value.round()} yrs',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.15),
            thumbColor: color,
            overlayColor: color.withOpacity(0.1),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: 10,
            max: 90,
            divisions: 80,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
