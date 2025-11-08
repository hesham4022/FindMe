// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:find_me_app/core/resources/colors.dart';

class RDropDownMenuBtn extends StatelessWidget {
  const RDropDownMenuBtn({
    super.key,
    required this.items,
    required this.value,
    required this.width,
    this.borderColor,
    required this.height,
    required this.onChanged,
    this.onTap,
  });

  final List<String> items;
  final String value;
  final double width;
  final double height;
  final Color? borderColor;
  final Function(String?)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0).r,
        color: Colors.white,
        border: Border.all(
          color: borderColor ?? AppColors.daisyBush800,
          style: BorderStyle.solid,
          width: 0.80.w,
        ),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: value,
          alignment: Alignment.center,
          underline: const SizedBox(),
          focusColor: Colors.transparent,
          dropdownColor: Colors.white,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.daisyBush800),
          icon: Icon(
            Icons.expand_more,
            color: AppColors.daisyBush800,
            size: 20.r,
          ),
          items: List.generate(
            items.length,
            (i) => DropdownMenuItem(
              value: items[i],
              onTap: onTap,
              child: Text(
                items[i],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.daisyBush800),
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
