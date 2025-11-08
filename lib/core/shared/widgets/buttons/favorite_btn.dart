// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../resources/images.dart';
// import '../animate_widgets_visibilty.dart';

// class FavoriteButton extends StatelessWidget {
//   const FavoriteButton({
//     super.key,
//     required this.onTap,
//     this.isInFavorite = true,
//   });

//   final Function()? onTap;
//   final bool isInFavorite;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(0).r,
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           GestureDetector(
//             onTap: onTap,
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//               ),
//               child: AnimateWidgetsVisiblity(
//                 duration: const Duration(milliseconds: 100),
//                 showFirst: isInFavorite,
//                 firstWidget: SvgPicture.asset(
//                   AppImages.favoriteFilled,
//                   width: 24.w,
//                   height: 24.w,
//                 ),
//                 secondWidget: SvgPicture.asset(
//                   AppImages.favoriteOutlined,
//                   width: 24.w,
//                   height: 24.w,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
