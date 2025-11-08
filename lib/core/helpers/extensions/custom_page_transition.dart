// import 'package:animations/animations.dart';
// import 'package:flutter/cupertino.dart';

// enum TransitionType {
//   fade,
//   leftToRight,
//   rightToLeft,
//   topToBottom,
//   bottomToTop,
//   scale,
//   cupertino,
//   // kNative,
// }

// class CustomPageTransition extends PageRouteBuilder {
//   final Widget page;
//   final TransitionType? type;

//   // get type =>
//   //     deviceOS == 'ios' ? TransitionType.cupertino : TransitionType.fade;

//   CustomPageTransition({
//     required this.page,
//     this.type,
//     // this.type = TransitionType.cupertino,
//     super.settings,
//   }) : super(
//           // transitionDuration: const Duration(milliseconds: 200),
//           // reverseTransitionDuration: const Duration(milliseconds: 200),
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//         );

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     switch (type) {
//       case TransitionType.fade:
//         return FadeTransition(
//           opacity: CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOutQuad,
//           ),
//           child: child,
//         );

//       case TransitionType.leftToRight:
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(-1, 0),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );

//       case TransitionType.rightToLeft:
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(1, 0),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );

//       case TransitionType.bottomToTop:
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, 1),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );

//       case TransitionType.topToBottom:
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, -1),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );

//       case TransitionType.scale:
//         return ScaleTransition(
//           scale: animation,
//           child: child,
//         );

//       case TransitionType.cupertino:
//         return CupertinoPageTransition(
//           linearTransition: true,
//           primaryRouteAnimation: animation,
//           secondaryRouteAnimation: secondaryAnimation,
//           child: child,
//         );
//       default:
//         return PageTransitionSwitcher(
//           transitionBuilder: (
//             Widget child,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               SharedAxisTransition(
//             animation: animation,
//             secondaryAnimation: secondaryAnimation,
//             transitionType: SharedAxisTransitionType.horizontal,
//             child: child,
//           ),
//           child: child,
//         );
//     }
//   }

//   Offset getBeginOffset() {
//     switch (type) {
//       case TransitionType.topToBottom:
//         return const Offset(0, 1);
//       case TransitionType.bottomToTop:
//         return const Offset(0, -1);
//       case TransitionType.rightToLeft:
//         return const Offset(-1, 0);
//       case TransitionType.leftToRight:
//         return const Offset(1, 0);
//       default:
//         return Offset.zero;
//     }
//   }
// }
