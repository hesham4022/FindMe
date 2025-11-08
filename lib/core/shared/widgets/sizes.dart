import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/screen_util_ex.dart';

/// Vertical Space between widgets
class VSpace extends StatelessWidget {
  const VSpace(this.space, {super.key});
  final double space;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space).px;
  }
}

/// Horizontal Space between widgets
class HSpace extends StatelessWidget {
  const HSpace(this.space, {super.key});
  final double space;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space).px;
  }
}
