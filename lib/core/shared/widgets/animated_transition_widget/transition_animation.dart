// Predefined functions for transition animations
// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'package:flutter/material.dart';

///Defines animation transition
enum AnimType {
  scale,
  leftSlide,
  rightSlide,
  bottomSlide,
  topSlide,
}

/// Exp: AnimationTransition.fromRight(animation, secondaryAnimation, child);
///
class AnimationTransition {
  /// Slide animation, from right to left (SlideTransition)
  static Widget fromRight(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.2, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.ease,
          ),
        ),
        child: child,
      ),
    );
  }

  /// Slide animation, from left to right (SlideTransition)
  static Widget fromLeft(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.2, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.ease,
          ),
        ),
        child: child,
      ),
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static Widget fromTop(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.ease,
          ),
        ),
        child: child,
      ),
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static Widget fromBottom(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.ease,
          ),
        ),
        child: child,
      ),
    );
  }

  /// Scale animation, from in to out (ScaleTransition)
  static Widget scale(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.7,
          end: 1,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.ease),
        ),
        child: child,
      ),
    );
  }

  /// Scale animation, from out to in (ScaleTransition)
  static Widget shrink(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.2,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0.50,
              1,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

///Main button with press animation effect base on elevated button from flutter
///with 0 elevation
class AnimatedButton extends StatefulWidget {
  ///Constructor
  const AnimatedButton({
    required this.pressEvent,
    super.key,
    this.text,
    this.icon,
    this.color,
    this.height,
    this.isFixedHeight = true,
    this.width = double.infinity,
    this.borderRadius,
    this.buttonTextStyle,
  });

  /// Function to execute when button is pressed
  final void Function() pressEvent;

  /// Text of the [AnimatedButton]
  final String? text;

  /// Icon for the [AnimatedButton]
  final IconData? icon;

  /// Width of the [AnimatedButton]
  final double width;

  /// Height of the [AnimatedButton]
  final double? height;

  /// If true, height is setted to `50.0`.
  ///
  /// Priority over [height]
  final bool isFixedHeight;

  /// Color for the [AnimatedButton]
  final Color? color;

  /// Border Radius of the [AnimatedButton]
  final BorderRadiusGeometry? borderRadius;

  /// Textstyle to use for the text of the [AnimatedButton]
  final TextStyle? buttonTextStyle;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  static const int _forwardDurationNumber = 150;
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _forwardDurationNumber),
      reverseDuration: const Duration(milliseconds: 100),
    )..addStatusListener(
        _animationStatusListener,
      );
    _scale = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await _animationController.forward();
    //Delayed added in purpose to keep same animation behavior as previous version when dialog was closed while animation was still playing
    await Future<void>.delayed(
      const Duration(milliseconds: _forwardDurationNumber ~/ 2),
    );
    widget.pressEvent();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: _animatedButtonUI,
    );
  }

  Widget get _animatedButtonUI => SizedBox(
        width: widget.width,
        height: widget.isFixedHeight ? 50 : widget.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(100),
                  ),
            ),
          ),
          onPressed: _onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.icon != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
              Flexible(
                child: FittedBox(
                  child: Text(
                    '${widget.text}',
                    // maxLines: 1,
                    textAlign: TextAlign.center,
                    style: widget.buttonTextStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
