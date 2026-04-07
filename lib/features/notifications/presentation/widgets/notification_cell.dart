import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_cubit.dart';

void kNavigateToPage(BuildContext context, AppNotificationModel data) {
  context.toNamed(
    AppRoutes.profileRoute,
    arguments: false,
    callback: (value) {
      final refresh = value as bool?;
      if (refresh == true) {
        context.read<NotificationsCubit>().refresh();
      }
    },
  );
}

class NotificationCell extends StatelessWidget {
  const NotificationCell(this.notification, this.index, {super.key});

  final AppNotificationModel notification;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (previous, current) =>
          previous.editedIndex != current.editedIndex,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20).r,
          decoration: BoxDecoration(
            color:
                notification.isRead ? AppColors.saltBox50 : AppColors.baseWhite,
            border: Border(
              bottom: BorderSide(
                color: AppColors.saltBox100,
                width: 1.w,
              ),
            ),
          ),
          child: ListTile(
            onTap: () {
              context
                  .read<NotificationsCubit>()
                  .markNotificationAsRead(notification.id, index);

              kNavigateToPage(context, notification);
            },
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0,
            horizontalTitleGap: 12.w,
            dense: true,
            leading: Container(
              padding: EdgeInsets.all(10).r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff3C3A40).withAlpha((0.12 * 255).toInt()),
              ),
              child: Icon(
                Icons.notifications_active_rounded,
                color: AppColors.saltBox900,
                size: 20.sp,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.data.message,
                  style: !notification.isRead
                      ? Theme.of(context)
                          .textTheme
                          .kParagraph01SemiBold
                          .copyWith(color: AppColors.saltBox900)
                      : Theme.of(context)
                          .textTheme
                          .kParagraph01Regular
                          .copyWith(color: AppColors.saltBox400),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.createdAt,
                  style: Theme.of(context)
                      .textTheme
                      .kCaptionRegular
                      .copyWith(color: AppColors.saltBox400),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
