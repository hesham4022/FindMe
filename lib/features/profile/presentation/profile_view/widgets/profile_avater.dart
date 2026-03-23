import 'dart:io';

import 'package:find_me_app/core/shared/models/userdata.dart';
import 'package:find_me_app/features/Home/presentation/cubit/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvater extends StatelessWidget {
  const ProfileAvater({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
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
            child: (user!.localImage != null && user!.localImage!.isNotEmpty)
                ? Image.file(
                    File(user!.localImage!),
                    fit: BoxFit.cover,
                  )
                : (user!.imageUrl.isNotEmpty
                    ? Image.network(
                        user!.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey[600],
                      )),
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
              if (pickedFile != null) {
                context
                    .read<UserCubit>()
                    .updateProfileImageLocal(pickedFile.path);
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
}
