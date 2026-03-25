import 'dart:io';

import 'package:find_me_app/features/auth/data/model/authed_user.dart';
import 'package:find_me_app/features/auth/presentation/cubit/auth_cubit/cubit/auth_cubit_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvater extends StatelessWidget {
  const ProfileAvater({
    super.key,
    required this.user,
  });

  final AuthedUser? user;

  @override
  Widget build(BuildContext context) {
    final photo = user?.photo;

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
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);

              if (pickedFile != null && user != null) {
                final updatedUser = user!.copyWith(
                  photo: pickedFile.path,
                );

                await context.read<AuthCubit>().updateCurrentUser(updatedUser);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF4A90E2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      if (photo.startsWith('http')) {
        return Image.network(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            Icons.person,
            size: 60,
            color: Colors.grey[600],
          ),
        );
      }

      return Image.file(
        File(photo),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Icon(
          Icons.person,
          size: 60,
          color: Colors.grey[600],
        ),
      );
    }

    return Icon(
      Icons.person,
      size: 60,
      color: Colors.grey[600],
    );
  }
}
