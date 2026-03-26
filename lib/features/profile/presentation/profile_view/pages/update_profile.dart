import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_cubit.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_listener.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/profile_avater.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/widgets/update_profile_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProfileCubit(sl(), context.read<HostCubit>()),
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
      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: updateProfileListener,
        builder: (context, state) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileAvatar(),
                  VSpace(40),
                  FullNameField(),
                  VSpace(10),
                  PhoneNumberField(),
                  VSpace(10),
                  EmailField(),
                  VSpace(10),
                  DateField(),
                  VSpace(50),
                  UpdateProfileButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
