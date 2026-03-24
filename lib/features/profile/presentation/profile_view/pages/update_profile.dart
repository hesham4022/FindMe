import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/Home/presentation/cubit/user/user_cubit.dart';

import 'package:find_me_app/features/profile/presentation/profile_view/widgets/profile_avater.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/update_profile_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

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
              const NameField(),
              const VSpace(10),
              const PhoneNumberField(),
              const VSpace(10),
              const UpdateProfileUserNameField(),
              const VSpace(10),
              DateField(),
              const VSpace(50),
              UpdateProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}
