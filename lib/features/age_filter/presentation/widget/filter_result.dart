import 'dart:io';
import 'dart:ui';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeFilterResultSection extends StatelessWidget {
  const AgeFilterResultSection({
    super.key,
    required this.isDark,
    required this.isResultLoading,
    required this.resultImagePath,
    required this.selectedImage,
    required this.onClear,
    required this.onSearchByImage,
    required this.resultLocalPath,
  });

  final bool isDark;
  final bool isResultLoading;
  final String? resultImagePath;
  final File selectedImage;
  final VoidCallback onClear;
  final void Function(String imageUrl) onSearchByImage;
  final String? resultLocalPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xFF5DCAA5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Result',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            if (!isResultLoading)
              GestureDetector(
                onTap: onClear,
                child: Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.black.withOpacity(0.35),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A22) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF5DCAA5).withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.5),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  selectedImage,
                  fit: BoxFit.cover,
                ),
                if (!isResultLoading && resultImagePath != null)
                  if (!isResultLoading && resultLocalPath != null)
                    Image.file(
                      File(resultLocalPath!), // ✅ من الـ local فورًا
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildError(),
                    ),
                if (isResultLoading)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                            SizedBox(height: 14),
                            Text(
                              'Applying age filter...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (!isResultLoading && resultImagePath != null)
          MaterialButton(
            color: AppColors.mainColor,
            onPressed: () =>
                onSearchByImage(resultImagePath!), // ✅ استخدم الـ callback
            child: const Text(
              "search by image",
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 32,
            color: isDark
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load result',
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
