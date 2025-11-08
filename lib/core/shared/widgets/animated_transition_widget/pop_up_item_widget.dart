import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/visable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpItemWidget extends StatelessWidget {
  const PopUpItemWidget({
    super.key,
    required this.title,
    required this.iconPAth,
    this.lastItem = false,
    required this.value,
    this.onTap,
    this.color,
  });

  final String title, iconPAth;
  final bool? lastItem;
  final void Function()? onTap;
  final Color? color;

  final int value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.saltBox600,
                  ),
            ),
            VisibleWidget(
              visible: lastItem == false,
              child: Divider(
                color: AppColors.saltBox600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
