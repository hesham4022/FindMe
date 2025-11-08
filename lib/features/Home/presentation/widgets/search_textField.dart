import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
    this.onFilterTap,
    this.onSearchTap,
    this.onSubmitted,
    required this.controller,
    required this.enabled,
    this.onChanged,
  });
  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final bool enabled;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.toNamed(AppRoutes.searchRoute);
      },
      child: TextField(
        onChanged: onChanged,
        autofocus: true,
        enabled: enabled,
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Search for cases in your area',
          filled: true,
          fillColor: AppColors.secondColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/Vectorss (1).svg',
                    width: 14,
                    height: 9,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: onSearchTap,
              child: SvgPicture.asset(
                'assets/icons/searchIcon.svg',
                width: 15.w,
                height: 18.h,
              ),
            ),
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 15, minHeight: 18),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Color(0xFF3F51F7), width: 1.2),
          ),
        ),
      ),
    );
  }
}
