// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../resources/colors.dart';

// enum IconButtonState { filled, outline, disabled, whiteActive }

// class CustomIconButton extends StatelessWidget {
//   CustomIconButton({
//     super.key,
//     required this.icon,
//     required this.width,
//     required this.height,
//     required this.state,
//     required this.onPressed,
//     required this.iconSize,
//     required this.radius,
//     this.borderWidth = 1,
//   });

//   final IconData icon;
//   final double width;
//   final double height;
//   final IconButtonState state;
//   final void Function() onPressed;
//   final double iconSize;
//   final double radius;
//   final double borderWidth;

//   late Color iconColor;
//   late Color backGroundColor;
//   late Color borderColor;

//   _getColors() {
//     switch (state) {
//       case IconButtonState.filled:
//         backGroundColor = AppColors.daisyBush800;
//         iconColor = Colors.white;
//         borderColor = AppColors.daisyBush800;
//         break;

//       case IconButtonState.outline:
//         backGroundColor = Colors.white;
//         iconColor = AppColors.daisyBush800;
//         borderColor = AppColors.daisyBush800;
//         break;

//       case IconButtonState.disabled:
//         backGroundColor = AppColors.saltBox200;
//         iconColor = AppColors.saltBox200;
//         borderColor = AppColors.saltBox200;
//         break;
//       case IconButtonState.whiteActive:
//         backGroundColor = Colors.white;
//         iconColor = Colors.black;
//         borderColor = Colors.white;
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _getColors();
//     return SizedBox(
//       width: width.r,
//       height: height.r,
//       child: Center(
//         child: TextButton(
//           style: ButtonStyle(
//             fixedSize: WidgetStateProperty.all(Size(width.r, height.r)),
//             overlayColor: state == IconButtonState.disabled
//                 ? WidgetStateProperty.all(Colors.transparent)
//                 : null,
//             backgroundColor: WidgetStateProperty.all(backGroundColor),
//             shape: WidgetStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(radius.r),
//                 side: BorderSide(color: borderColor, width: borderWidth.r),
//               ),
//             ),
//           ),
//           onPressed: onPressed,
//           child: Icon(
//             icon,
//             color: iconColor,
//             size: iconSize.r,
//           ),
//         ),
//       ),
//     );
//   }
// }
