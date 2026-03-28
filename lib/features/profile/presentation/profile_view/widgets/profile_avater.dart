import 'dart:io';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/profile/presentation/cubit/update_profile_cubit/cubit/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostCubit, HostState>(
      builder: (context, state) {
        final photo = state.user?.photo;

        return Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: ClipOval(
                child: _buildAvatar(photo),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async =>
                    context.read<UpdateProfileCubit>().pickPhoto().then((_) {
                  final pickedPhoto =
                      context.read<UpdateProfileCubit>().state.photo;
                  if (pickedPhoto != null) {
                    context.read<UpdateProfileCubit>().updateProfile();
                  }
                }),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A90E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatar(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      if (photo.startsWith('http')) {
        return Image.network(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.person, size: 60, color: Colors.grey[600]),
        );
      }
      return Image.file(
        File(photo),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.person, size: 60, color: Colors.grey[600]),
      );
    }
    return Icon(Icons.person, size: 60, color: Colors.grey[600]);
  }
}
