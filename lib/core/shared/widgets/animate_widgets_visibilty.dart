import 'package:flutter/material.dart';

class AnimateWidgetsVisiblity extends StatelessWidget {
  const AnimateWidgetsVisiblity({
    super.key,
    required this.firstWidget,
    required this.secondWidget,
    required this.showFirst,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget firstWidget;
  final Widget secondWidget;
  final bool showFirst;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      alignment: Alignment.center,
      firstChild: firstWidget,
      secondChild: secondWidget,
      firstCurve: Curves.easeIn,
      crossFadeState:
          showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
    );
  }
}
