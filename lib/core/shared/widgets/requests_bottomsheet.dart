import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/shared/models/requests_static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';

kShowRequestsBottomSheet(BuildContext context) async {
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
    builder: (_) => _RequestsView(),
  );
}

class _RequestsView extends StatelessWidget {
  const _RequestsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //! title, Close Button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                AppStrings.requests.ts,
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

        ListView.builder(
          shrinkWrap: true,
          itemCount: kRequests(context).length,
          itemBuilder: (context, i) =>
              ListTileWidget(data: kRequests(context)[i]),
        ),
      ],
    );
  }
}

//! Request Widget -------------------------------------------------------------
class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.data,
  });

  final ListTileModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20).r,
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.saltBox100,
            width: 1.w,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 0,
        horizontalTitleGap: 8.w,
        dense: true,
        onTap: data.onTap,
        leading: Container(
          padding: EdgeInsets.all(10).r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: data.color,
          ),
          child: data.icon != null
              ? Icon(
                  data.icon,
                  color: AppColors.baseWhite,
                  size: 20.sp,
                )
              : SvgPicture.asset(
                  data.svgIcon!,
                  width: 24.sp,
                  height: 24.sp,
                ),
        ),
        title: Text(
          data.title.tr(),
          style: Theme.of(context)
              .textTheme
              .kParagraph01SemiBold
              .copyWith(color: AppColors.saltBox900),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.saltBox300,
          size: 16.sp,
        ),
      ),
    );
  }
}
