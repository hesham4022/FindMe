import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:flutter/material.dart';

class HalfWidthField extends StatelessWidget {
  const HalfWidthField({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        const HSpace(5),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
