import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
    required this.controller,
    required this.enabled,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.onSearchTap,
    this.hintText = 'Search by name',
    this.autofocus = false,
    // this.readOnly = false,
    // this.openSearchPageOnTap = false,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;
  final String hintText;
  final bool autofocus;
  // final bool readOnly;
  // final bool openSearchPageOnTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.trim().isNotEmpty;

        return TextField(
          // focusNode: focusNode,
          // readOnly: readOnly,

          controller: controller,
          enabled: enabled,
          autofocus: autofocus,
          // onTap: () => _handleTap(context),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.search,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
            ),
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.mainColor,
                size: 22.sp,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 44.w,
              minHeight: 44.h,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasText)
                  IconButton(
                    onPressed: () {
                      controller.clear();
                      onChanged?.call('');
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.grey.shade500,
                      size: 20.sp,
                    ),
                  ),
                if (onFilterTap != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.w),
                    child: InkWell(
                      onTap: onFilterTap,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/Vectorss (1).svg',
                            width: 14.w,
                            height: 10.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: 44.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: AppColors.mainColor,
                width: 1.3,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        );
      },
    );
  }
}
