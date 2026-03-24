import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/Home/presentation/cubit/user/user_cubit.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_cubit.dart';

import 'package:find_me_app/features/profile/presentation/profile_view/widgets/profile_avater.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/update_profile_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProfileCubit(
        sl(),
      ),
      child: const UpdateProfileBody(),
    );
  }
}

class UpdateProfileBody extends StatelessWidget {
  const UpdateProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  final user = state.user;
                  final imagePath = user!.localImage?.isNotEmpty == true
                      ? user!.localImage!
                      : user.imageUrl;
                  if (user == null) {
                    return const Center(
                      child: Text("no data"),
                    );
                  }
                  return ProfileAvater(user: user);
                },
              ),
              const VSpace(40),
              const FullNameField(),
              const VSpace(10),
              const PhoneNumberField(),
              const VSpace(10),
              const EmailField(),
              const VSpace(10),
              const DateField(),
              const VSpace(50),
              const UpdateProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}
