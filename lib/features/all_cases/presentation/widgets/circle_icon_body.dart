import 'package:find_me_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class CircleIconBody extends StatelessWidget {
  const CircleIconBody(
      {super.key,
      required this.icon,
      this.onPressed,
      this.color,
      this.iconColor,
      this.isFavorite});
  final bool? isFavorite;
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.secondColor,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }
}
