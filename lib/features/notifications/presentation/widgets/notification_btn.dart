import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications_button/notification_btn_cubit.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications_button/notifications_state.dart';

class NotificationBtn extends StatelessWidget {
  const NotificationBtn({
    super.key,
    this.onTap,
    this.color = Colors.black,
  });

  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBtnCubit, NotificationBtnState>(
      builder: (context, state) {
        late String counter;
        if (state.notificationCounter > 9) {
          counter = "+9";
        } else {
          counter = state.notificationCounter.toString();
        }

        counter = "+9";

        return GestureDetector(
          onTap: onTap ?? () => context.toNamed(AppRoutes.notificationsRoute),
          child: SizedBox(
            height: 30.sp,
            width: 30.sp,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.secondColor,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.baseBlack,
                    size: 24.sp,
                  ),
                ),

                //! Counter circle
                if (state.notificationCounter > 0)
                  Positioned(
                    top: 0,
                    right: context.locale.languageCode == "ar" ? null : 0,
                    left: context.locale.languageCode == "ar" ? 0 : null,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 1, horizontal: 2)
                              .r,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        counter,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .kFooterSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
