import 'package:find_me_app/core/shared/widgets/animated_transition_widget/delayed_widget.dart';
import 'package:find_me_app/core/shared/widgets/animated_transition_widget/transition_animation.dart';
import 'package:flutter/material.dart';

enum SlidingDirection {
  scale,
  fromLeft,
  fromRight,
  fromBottom,
  fromTop,
}

class TransitionSlidingWidget extends StatefulWidget {
  const TransitionSlidingWidget({
    required this.child,
    required this.slidingDirection,
    this.duration,
    this.delay = 0,
    super.key,
  });

  final Widget child;
  final SlidingDirection slidingDirection;
  final int? duration;
  final int delay;

  @override
  State<TransitionSlidingWidget> createState() =>
      _TransitionSlidingWidgetState();
}

class _TransitionSlidingWidgetState extends State<TransitionSlidingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: widget.duration ?? 1),
      vsync: this,
    )..forward();

    animation = animationController.drive(
      CurveTween(curve: Curves.ease),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child;

    switch (widget.slidingDirection) {
      case SlidingDirection.scale:
        animatedChild = DelayedWidget(
          seconds: widget.delay,
          child: AnimationTransition.scale(
            animation,
            animation,
            animatedChild,
          ),
        );
        break;
      case SlidingDirection.fromLeft:
        animatedChild = AnimationTransition.fromLeft(
          animation,
          animation,
          animatedChild,
        );
        break;
      case SlidingDirection.fromRight:
        animatedChild = AnimationTransition.fromRight(
          animation,
          animation,
          animatedChild,
        );
        break;
      case SlidingDirection.fromBottom:
        animatedChild = AnimationTransition.fromBottom(
          animation,
          animation,
          animatedChild,
        );
        break;
      case SlidingDirection.fromTop:
        animatedChild = AnimationTransition.fromTop(
          animation,
          animation,
          animatedChild,
        );
        break;
    }

    return animatedChild;
  }
}
