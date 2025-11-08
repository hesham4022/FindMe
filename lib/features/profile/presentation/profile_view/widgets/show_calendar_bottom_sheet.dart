import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/helpers/enums/date.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

kShowCalendarBottomSheet(
  BuildContext context, {
  DateTime? initialDate,
  required Function(DateTime value) onSelected,
}) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (_) => CustomCalendarWidget(
      initialDate: initialDate,
      onSelected: onSelected,
    ),
  );
}

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({
    super.key,
    this.initialDate,
    required this.onSelected,
    this.needsCustomHeader = true,
    this.needsDismissOnSelection = true,
  });

  final DateTime? initialDate;
  final Function(DateTime value) onSelected;
  final bool? needsCustomHeader;
  final bool? needsDismissOnSelection;

  @override
  State<CustomCalendarWidget> createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime? _selected;
  bool isYearListOpen = false;

  DateTime get initialDate => DateTime.now().toDateOnly;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
  }

  Widget _buildCustomHeader(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat.MMMM(context.locale.languageCode).format(date),
          style: Theme.of(context).textTheme.kParagraph01Regular,
        ),
        HSpace(4),
        Text(
          date.year.toString(),
          style: Theme.of(context).textTheme.kParagraph01Regular,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //! title, Close Button
        if (widget.needsCustomHeader == true)
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
                  AppStrings.calendar.ts,
                  style: Theme.of(context).textTheme.kParagraph02SemiBold,
                ),
                GestureDetector(
                  onTap: () async => context.back(),
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
        // VSpace(12),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24).r,
          child: TableCalendar(
            firstDay: DateTime.utc(1800, 10, 16),
            // currentDay: _selected ?? DateTime(1991, 09),
            lastDay: DateTime.utc(2030, 3, 14),
            locale: context.locale.languageCode,
            focusedDay: _selected ?? initialDate,
            //
            daysOfWeekVisible: true,
            daysOfWeekHeight: 36.sp,
            rowHeight: 36.sp,
            calendarStyle: CalendarStyle(
              weekendTextStyle: Theme.of(context).textTheme.kParagraph01Regular,
              cellMargin: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 2,
              ).r,
              defaultTextStyle: Theme.of(context).textTheme.kParagraph01Regular,
              todayTextStyle: Theme.of(context).textTheme.kParagraph01Regular,
              weekendDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              disabledDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              outsideDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              holidayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.daisyBush100,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.daisyBush800,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              headerPadding: EdgeInsets.only(bottom: 20).h,
              titleTextStyle: Theme.of(context).textTheme.kParagraph01Regular,
              formatButtonVisible: false,
              titleCentered: true,
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 18.sp,
              ),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 18.sp,
              ),
              rightChevronPadding: EdgeInsets.symmetric(horizontal: 8).w,
              leftChevronPadding: EdgeInsets.symmetric(horizontal: 8).w,
              rightChevronMargin: EdgeInsets.zero,
              leftChevronMargin: EdgeInsets.zero,
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, date) => _buildCustomHeader(date),
            ),

            selectedDayPredicate: (day) {
              return isSameDay(_selected, day);
            },
            //
            onDaySelected: (selectedDay, focusedDay) async {
              // Update Calendar State
              setState(() {
                _selected = selectedDay;
              });
              // retrun selected day
              widget.onSelected(selectedDay);

              // Close BottomSheet
              if (widget.needsDismissOnSelection == true) {
                context.back();
              }
            },
          ),
        ),
      ],
    );
  }
}
