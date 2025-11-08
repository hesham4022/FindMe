// ** Important: Used to dismiss keyboard in main
import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          dismissFocusedWidget(context);
        },
        child: child,
      ),
    );
  }
}

dismissFocusedWidget(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
