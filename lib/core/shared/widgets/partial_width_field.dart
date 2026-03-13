import 'package:flutter/material.dart';

class PartialWidthField extends StatelessWidget {
  const PartialWidthField(
      {super.key, required this.child, this.widthFactor = 0.62});
  final Widget child;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: child,
    );
  }
}
