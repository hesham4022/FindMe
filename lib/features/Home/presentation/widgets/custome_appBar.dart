import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeaderAppBar({
    super.key,
    this.onBellTap,
  });

  final VoidCallback? onBellTap;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  static const Color headerBg = Color(0xFFEFF2FF);
  static const Color chipBg = Color(0xFFE9EEFF);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostCubit, HostState>(
      builder: (context, state) {
        final user = state.user;
        // if (user == null) {
        //   return AppBar(
        //     automaticallyImplyLeading: false,
        //     elevation: 0,
        //     backgroundColor: Colors.white,
        //     toolbarHeight: 96,
        //     title: const Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }

        // لو هترجع CircleAvatar بعدين
        // final imagePath = (user.localImage?.isNotEmpty == true)
        //     ? user.localImage!
        //     : (user.imageUrl ?? "");

        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 96,
          titleSpacing: 16,
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 72,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<HostCubit>().changeIndex(2);
                  },
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.person, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Welcome',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user?.fullName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis, // لو الاسم طويل
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onBellTap,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: chipBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none, size: 20),
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
