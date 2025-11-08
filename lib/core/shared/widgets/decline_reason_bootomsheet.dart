import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

kShowDeclineReasongBottomSheet(
  BuildContext context, {
  required String title,
  required String actionBtnTitle,
  required void Function(String) onSubmit,
}) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: AppColors.baseWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (_) => _Options(
      title: title,
      actionBtnTitle: actionBtnTitle,
      onSubmit: onSubmit,
    ),
  );
}

class _Options extends StatefulWidget {
  const _Options({
    required this.title,
    required this.actionBtnTitle,
    required this.onSubmit,
  });

  final String title;
  final String actionBtnTitle;
  final void Function(String) onSubmit;

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
  @override
  void initState() {
    super.initState();
    _reasonCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  late TextEditingController _reasonCtrl;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //! title, Close Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
            height: 56.h,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.saltBox100,
                  width: 1.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 32.sp, height: 32.sp),
                Text(
                  widget.title.ts,
                  style: Theme.of(context).textTheme.kParagraph02SemiBold,
                ),
                GestureDetector(
                  onTap: context.back,
                  child: Container(
                    width: 32.sp,
                    height: 32.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.saltBox100,
                    ),
                    child: const Icon(
                      Icons.close_sharp,
                      size: 18,
                      color: AppColors.saltBox600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 30).r,
            child: Column(
              spacing: 32.h,
              children: [
                CustomTextField(
                  controller: _reasonCtrl,
                  autoFocus: false,
                  hint: AppStrings.reasonHint.ts,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  minLines: 5,
                  maxLines: 5,
                ),

                //! Buttons
                Row(
                  children: [
                    //! Cancel Button
                    Expanded(
                      child: CustomFilledButton(
                        titleText: AppStrings.cancel,
                        onPressed: () => unawaited(context.back()),
                        color: AppColors.saltBox100,
                        textColor: AppColors.saltBox600,
                        width: 96,
                        height: 50,
                      ),
                    ),
                    HSpace(12),
                    //! Decline Button
                    Expanded(
                      child: CustomFilledButton(
                        titleText: widget.actionBtnTitle,
                        onPressed: () {
                          if (_reasonCtrl.text.isNotEmpty) {
                            widget.onSubmit(_reasonCtrl.text);
                            unawaited(context.back());
                          }
                        },
                        color: AppColors.error500,
                        width: 96,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
