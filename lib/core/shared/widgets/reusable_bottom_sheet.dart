import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';

kShowReusableBottomSheet(
  BuildContext context, {
  String? initialValue,
  required String title,
  required List<String> values,
  required void Function(String, int) onChanged,
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
      initialValue: initialValue,
      values: values,
      onChanged: onChanged,
    ),
  );
}

class _Options extends StatefulWidget {
  const _Options({
    this.initialValue,
    required this.title,
    required this.values,
    required this.onChanged,
  });

  final String title;
  final String? initialValue;
  final List<String> values;
  final void Function(String, int) onChanged;

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
  String? _selectedValue;

  @override
  void initState() {
    // Take the initial value or the first value of the list as default
    _selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.9;
    final double itemHeight =
        56.h; // Height of each list item (customize as needed)
    final double calculatedHeight = (widget.values.length * itemHeight);
    final double modalHeight =
        calculatedHeight > maxHeight ? maxHeight : calculatedHeight;

    return Column(
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
                width: 2.w,
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

        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: modalHeight),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.values.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () async {
                setState(() {
                  _selectedValue = widget.values[i];
                });
                widget.onChanged(widget.values[i], i);
                context.back();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.values[i],
                      style: Theme.of(context).textTheme.kParagraph01SemiBold,
                    ),
                    SizedBox(
                      width: 24.sp,
                      height: 24.sp,
                      child: Radio<String>(
                        value: widget.values[i],
                        groupValue: _selectedValue,
                        onChanged: (value) async {
                          setState(() {
                            _selectedValue = value!;
                          });

                          widget.onChanged(value!, i);
                          context.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
