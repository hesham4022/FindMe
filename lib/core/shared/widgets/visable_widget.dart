import 'package:flutter/material.dart';

class VisibleWidget extends StatelessWidget {
  final bool? visible;
  final Widget child;
  const VisibleWidget({super.key,required this.visible,required this.child});

  @override
  Widget build(BuildContext context) {

    if(visible!=null&&visible!){
      return child;
    }
    return const SizedBox.shrink();
  }
}
