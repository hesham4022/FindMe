// ignore_for_file: always_put_control_body_on_new_line

import 'package:find_me_app/core/shared/models/get_actions_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_cubit.dart';

void kNavigateToPage(BuildContext context, NotificationModel data) {
  // If can't
  if (!data.canNavToDetails) return;
  if (data.requestType == RequestType.evaluation) {
    if (data.reqActionType == "3") {
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
    } else if (data.reqActionType == "2") {
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
  } else {
    // ignore: use_build_context_synchronously
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
}

class NotificationCell extends StatelessWidget {
  const NotificationCell(this.notification, this.index, {super.key});

  final NotificationModel notification;
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
                notification.read ? AppColors.saltBox50 : AppColors.baseWhite,
            border: Border(
              bottom: BorderSide(
                color: AppColors.saltBox100,
                width: 1.w,
              ),
            ),
          ),
          child: ListTile(
            onTap: () async {
              context
                  .read<NotificationsCubit>()
                  .markNotificationAsRead(notification.id ?? 0, index);

              kNavigateToPage(context, notification);

              // if (notification.canNavToDetails) {
              //   context.toNamed(
              //     AppRoutes.actionDetailsPageRoute,
              //     arguments: ActionDetailsArgs(
              //       requestId: notification.specialReference!,
              //       requestType: notification.requestType!,
              //       reqActionType: notification.reqActionType,
              //       flowId: notification.flowId!,
              //       showActions: notification.showActions,
              //     ),
              //   );
              // }
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                if (notification.title != null)
                  Text(
                    notification.title!,
                    style: !notification.read
                        ? Theme.of(context)
                            .textTheme
                            .kParagraph01SemiBold
                            .copyWith(color: AppColors.saltBox900)
                        : Theme.of(context)
                            .textTheme
                            .kParagraph01Regular
                            .copyWith(color: AppColors.saltBox400),
                  ),
                if (notification.createdOn != null)
                  Text(
                    notification.parseCreatedOn,
                    style: Theme.of(context)
                        .textTheme
                        .kCaptionRegular
                        .copyWith(color: AppColors.saltBox400),
                  ),
                if (notification.stringBody != null)
                  Text(
                    notification.stringBody!,
                    style: Theme.of(context)
                        .textTheme
                        .kCaptionRegular
                        .copyWith(color: AppColors.saltBox400),
                  )
                else if (notification.body?.remarks != null)
                  Text(
                    notification.body!.remarks!,
                    style: Theme.of(context)
                        .textTheme
                        .kCaptionRegular
                        .copyWith(color: AppColors.saltBox400),
                  ),
              ],
            ),
            trailing: notification.canNavToDetails
                ? Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.saltBox300,
                    size: 16.sp,
                  )
                : null,
          ),
        );
      },
    );
  }
}
