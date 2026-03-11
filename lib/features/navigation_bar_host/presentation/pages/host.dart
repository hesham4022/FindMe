import 'package:find_me_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/navigation_bar_host/data/model/bottom_nav_bar.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_listener.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/widgets/custom_bottom_nav_bar.dart';

class HostView extends StatelessWidget {
  const HostView({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(sl()),
      child: BlocConsumer<HostCubit, HostState>(
        listener: hostListener,
        buildWhen: (p, c) => p.selectedIndex != c.selectedIndex,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                final hostCubit = context.read<HostCubit>();
                final history = hostCubit.tabHistory;

                final currentIndex = hostCubit.state.selectedIndex;

                if (currentIndex == 0) {
                  SystemNavigator.pop();
                  return;
                }

                if (history.length > 1) {
                  history.removeLast();
                  final previousIndex = history.last;
                  hostCubit.emit(
                      hostCubit.state.copyWith(selectedIndex: previousIndex));
                } else {
                  SystemNavigator.pop();
                }
              }
            },
            child: Scaffold(
              body: Center(
                child: kUserBottomBarTabs[state.selectedIndex].screen,
              ),
              bottomNavigationBar: CutomBottomNavigationBar(
                selectedIndex: state.selectedIndex,
                tabs: kUserBottomBarTabs,
                onTap: (index) {
                  context.read<HostCubit>().changeIndex(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// class _HostBody extends StatelessWidget {
//   const _HostBody();

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HostCubit, HostState>(
//       listener: hostListener,
//       buildWhen: (p, c) => p.selectedIndex != c.selectedIndex,
//       builder: (context, state) {
//         return PopScope(
//           canPop: false,
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             resizeToAvoidBottomInset: false,
//             // extendBody: true,
//             // appBar: const HostAppBar(),
//             // drawer: const CustomDrawer(),
//             // floatingActionButton:FloatingActionButton(
//             //   onPressed: () {
//             //     context.to(ChatView());
//             //   },
//             //   elevation: 0,
//             //   backgroundColor: Colors.transparent, // Makes the background transparent
//             //   shape: const CircleBorder(), // Makes the button circular
//             //   child: Container(
//             //     width: 56.sp, // Adjust size as needed
//             //     height: 56.sp, // Adjust size as needed
//             //     decoration: const BoxDecoration(
//             //       shape: BoxShape.circle, // Ensures the container is circular
//             //       color: AppColors.scooter50, // Set your desired background color
//             //     ),
//             //     child: Center(
//             //       child: SvgPicture.asset(
//             //         AppImages.forum,
//             //         // width: 24.sp, // Adjust icon size as needed
//             //         // height: 24.sp,
//             //         // colorFilter: const ColorFilter.mode(
//             //         //   Colors.white, // Set icon color
//             //         //   BlendMode.srcIn,
//             //         // ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             body: Center(
//               child: kUserBottomBarTabs[state.selectedIndex].screen,
//             ),
//             bottomNavigationBar: CutomBottomNavigationBar(
//               selectedIndex: state.selectedIndex,
//               tabs: kUserBottomBarTabs,
//               onTap: (index) {
//                 context.read<HostCubit>().changeIndex(index);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
