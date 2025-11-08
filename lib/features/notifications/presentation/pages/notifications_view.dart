import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/custom_loader_widget.dart';
import 'package:find_me_app/core/shared/widgets/no_data.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications/notifications_listener.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications_button/notification_btn_cubit.dart';
import 'package:find_me_app/features/notifications/presentation/widgets/notification_cell.dart';
import 'package:find_me_app/features/notifications/presentation/widgets/notifications_list_shimmer.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(sl())..onInit(),
      child: Scaffold(
        backgroundColor: AppColors.saltBox50,
        appBar: CustomAppBar(
          titleText: AppStrings.notifications,
          background: Colors.white,
          elevation: 0.3,
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: notificationsListener,
      builder: (context, state) {
        // Loading State
        if (state.status == NotificationStatus.loading) {
          return const _LoadingState();
        }
        // Success State
        else if (state.status == NotificationStatus.success) {
          context
              .read<NotificationBtnCubit>()
              .cacheUnReadedNotifsCount(state.notifications.length);
          return state.notifications.isNotEmpty
              ? _SuccessState(state)
              : NoDataWidget(
                  title: AppStrings.noNotif,
                  icon: Icons.notifications_rounded,
                );
        }
        // Initial State
        else {
          return NoDataWidget(
            title: AppStrings.noNotif,
            icon: Icons.notifications_rounded,
          );
        }
      },
    );
  }
}

//------------------------------------------------------------------------------
class _SuccessState extends StatelessWidget {
  const _SuccessState(
    this.state,
  );

  final NotificationsState state;

  @override
  Widget build(BuildContext context) {
    final notifications = state.notifications;
    return ListView.builder(
      controller: context.read<NotificationsCubit>().scrollCtrl,
      padding: const EdgeInsets.symmetric(vertical: 8).h,
      itemCount: notifications.length + 1,
      itemBuilder: (_, i) {
        if (i < notifications.length) {
          return NotificationCell(notifications[i], i);
        }
        // Pagination Loader
        else {
          return Center(
            child: state.hasReachedMax
                ? const SizedBox.shrink()
                : CustomLoadingWidget(height: 75, width: 75),
          );
        }
      },
    );
  }
}

// Loading State
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const NotificationsListShimmerEffect();
  }
}
