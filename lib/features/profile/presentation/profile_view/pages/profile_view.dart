import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/features/Home/presentation/cubit/cubit/user_cubit.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/auth/presentation/pages/signin.dart';
import 'package:find_me_app/features/navigation_bar_host/data/model/bottom_nav_bar.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/menu_Item_widget.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/profile_avater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: Text("My Profile"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return const Center(
              child: Text("no data"),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Profile Avatar Section
                ProfileAvater(user: user),

                const SizedBox(height: 10),

                // User Name from Cubit
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                // Menu Items
                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {
                    context.toNamed(AppRoutes.updateProfileRoute);
                  },
                ),
                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.favorite_outline,
                  title: 'Favorite',
                  onTap: () {},
                ),
                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.lock_outline,
                  title: 'Privacy Policy',
                  onTap: () {
                    context.toNamed(AppRoutes.privacyRoute);
                  },
                ),
                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    context.read<HostCubit>().changeIndex(3);
                  },
                ),

                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.help_outline,
                  title: 'Help',
                  onTap: () {
                    context.toNamed(AppRoutes.helpCenterView);
                  },
                ),
                MenuItemWidget(
                  isContainer: true,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    LogoutDialog.show(
                      context,
                      onConfirm: () async {
                        context.read<HostCubit>().logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => SigninView(),
                          ),
                          (route) => false,
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
