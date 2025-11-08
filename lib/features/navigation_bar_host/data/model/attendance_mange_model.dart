import 'package:flutter/material.dart';

class AttendanceMangeModel {
  final String title;
  final IconData? icon;
  final String? svgIcon;
  final Color color;
  final Function()? onTap;
  final bool needBgColor;

  AttendanceMangeModel({
    required this.title,
    this.icon,
    this.svgIcon,
    required this.color,
    required this.onTap,
    this.needBgColor = false,
  });
}
