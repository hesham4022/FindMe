import 'dart:ui';

import 'package:find_me_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isContainer;

  const MenuItemWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.isContainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon with blue circular background
            isContainer
                ? Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.secondColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.mainColor,
                      size: 22,
                    ),
                  )
                : Icon(
                    icon,
                    color: AppColors.mainColor,
                    size: 30,
                  ),

            const SizedBox(width: 16),

            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            // Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mainColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutDialog {
  static void show(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
