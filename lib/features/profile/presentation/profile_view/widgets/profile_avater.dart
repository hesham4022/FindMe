import 'dart:io';

import 'package:find_me_app/features/auth/data/model/authed_user.dart';
import 'package:find_me_app/features/auth/presentation/cubit/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvater extends StatefulWidget {
  const ProfileAvater({
    super.key,
    required this.user,
  });

  final AuthedUser? user;

  @override
  State<ProfileAvater> createState() => _ProfileAvaterState();
}

class _ProfileAvaterState extends State<ProfileAvater> {
  String? _localImagePath; // الصورة المختارة محلياً قبل ما الـ backend يرد
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // أولوية العرض: الصورة المحلية الجديدة → صورة المستخدم من الـ backend
    final photo = _localImagePath ?? widget.user?.photo;

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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildAvatar(photo),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: _isLoading ? null : _pickAndUpdateImage,
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

  Future<void> _pickAndUpdateImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null || widget.user == null) return;

    // ١. غيّر الصورة على الشاشة فوراً (Optimistic UI)
    setState(() {
      _localImagePath = pickedFile.path;
      _isLoading = true;
    });

    try {
      final updatedUser = widget.user!.copyWith(photo: pickedFile.path);

      // ٢. ابعت التحديث للـ backend
      await context.read<AuthCubit>().updateCurrentUser(updatedUser);

      // ٣. بعد نجاح الـ backend امسح الـ local path (الـ cubit هيتكلم من نفسه)
      if (mounted) {
        setState(() {
          _localImagePath = null;
        });
      }
    } catch (e) {
      // لو فشل الـ backend ارجع للصورة القديمة
      if (mounted) {
        setState(() {
          _localImagePath = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تحديث الصورة، حاول تاني')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
