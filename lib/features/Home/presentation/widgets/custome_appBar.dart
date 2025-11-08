import 'dart:io';

import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/features/Home/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeaderAppBar({
    super.key,
    this.onBellTap,
  });

  final VoidCallback? onBellTap;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  static const Color headerBg = Color(0xFFEFF2FF);
  static const Color chipBg = Color(0xFFE9EEFF);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;

        if (user == null) {
          return AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 96,
            title: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final imagePath = (user.localImage?.isNotEmpty == true)
            ? user.localImage!
            : (user.imageUrl ?? "");

        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 96,
          titleSpacing: 16,
          title: SizedBox(
            height: 72,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.toNamed(AppRoutes.profileRoute);
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.black12,
                      backgroundImage: imagePath.startsWith('http')
                          ? NetworkImage(imagePath)
                          : FileImage(File(imagePath)) as ImageProvider,
                      child: imagePath.isEmpty
                          ? const Icon(Icons.person,
                              size: 40, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hi, Welcome',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
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
          ),
        );
      },
    );
  }
}
