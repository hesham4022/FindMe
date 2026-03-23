// import 'package:easy_localization/easy_localization.dart';
// import 'package:find_me_app/core/shared/widgets/requests_bottomsheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:find_me_app/core/resources/colors.dart';
// import 'package:find_me_app/core/resources/themes.dart';
// import 'package:find_me_app/features/navigation_bar_host/data/model/bottom_nav_bar.dart';

// class CutomBottomNavigationBar extends StatelessWidget {
//   const CutomBottomNavigationBar({
//     super.key,
//     required this.selectedIndex,
//     required this.tabs,
//     required this.onTap,
//   });

//   final int selectedIndex;
//   final List<BottomNavBarTab> tabs;
//   final Function(int index) onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           padding:
//               const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 30).r,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x05000000),
//                 blurRadius: 16,
//                 offset: Offset(-1, -7),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x05000000),
//                 blurRadius: 28,
//                 offset: Offset(-2, -28),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x02000000),
//                 blurRadius: 38,
//                 offset: Offset(-5, -64),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x00000000),
//                 blurRadius: 45,
//                 offset: Offset(-9, -113),
//                 spreadRadius: 0,
//               ),
//               BoxShadow(
//                 color: Color(0x00000000),
//                 blurRadius: 50,
//                 offset: Offset(-15, -176),
//                 spreadRadius: 0,
//               )
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(tabs.length, (index) {
//               return Expanded(
//                 child: InkWell(
//                   onTap: () => onTap(index),
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 12).h,
//                     decoration: BoxDecoration(
//                       border: index == selectedIndex
//                           ? Border(
//                               top: BorderSide(
//                               width: 2.h,
//                               color: AppColors.daisyBush800,
//                             ))
//                           : null,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (tabs[index].icon != null)
//                           Icon(
//                             tabs[index].icon,
//                             color: index == selectedIndex
//                                 ? AppColors.daisyBush800
//                                 : AppColors.saltBox600,
//                             size: 24.w,
//                           )
//                         else if (tabs[index].img != null)
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5).h,
//                             child: SvgPicture.asset(
//                               index == selectedIndex
//                                   ? tabs[index].activeImg!
//                                   : tabs[index].img!,
//                               width: 24.w,
//                               height: 24.w,
//                             ),
//                           ),
//                         Text(
//                           tabs[index].title.tr(),
//                           style: index == selectedIndex
//                               ? Theme.of(context)
//                                   .textTheme
//                                   .kFooterBold
//                                   .copyWith(color: AppColors.daisyBush800)
//                               : Theme.of(context)
//                                   .textTheme
//                                   .kFooterSemiBold
//                                   .copyWith(color: AppColors.saltBox600),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//         // Positioned(
//         //   top: -20,
//         //   child: GestureDetector(
//         //     onTap: () => kShowRequestsBottomSheet(context),
//         //     child: Container(
//         //       width: 56.sp,
//         //       height: 56.sp,
//         //       clipBehavior: Clip.antiAlias,
//         //       decoration: ShapeDecoration(
//         //         color: Color(0xFF4A2AAF),
//         //         shape: RoundedRectangleBorder(
//         //           borderRadius: BorderRadius.circular(11111),
//         //         ),
//         //         shadows: [
//         //           BoxShadow(
//         //             color: Color(0x19000000),
//         //             blurRadius: 3,
//         //             offset: Offset(0, 1),
//         //             spreadRadius: 0,
//         //           ),
//         //           BoxShadow(
//         //             color: Color(0x16000000),
//         //             blurRadius: 5,
//         //             offset: Offset(0, 5),
//         //             spreadRadius: 0,
//         //           ),
//         //           BoxShadow(
//         //             color: Color(0x0C000000),
//         //             blurRadius: 7,
//         //             offset: Offset(0, 11),
//         //             spreadRadius: 0,
//         //           ),
//         //           BoxShadow(
//         //             color: Color(0x02000000),
//         //             blurRadius: 8,
//         //             offset: Offset(0, 19),
//         //             spreadRadius: 0,
//         //           ),
//         //           BoxShadow(
//         //             color: Color(0x00000000),
//         //             blurRadius: 8,
//         //             offset: Offset(0, 30),
//         //             spreadRadius: 0,
//         //           )
//         //         ],
//         //       ),
//         //       child: Icon(
//         //         Icons.add,
//         //         color: AppColors.scooter200,
//         //         size: 30.sp,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/features/navigation_bar_host/data/model/bottom_nav_bar.dart';

class CutomBottomNavigationBar extends StatelessWidget {
  const CutomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTap,
  });

  final int selectedIndex;
  final List<BottomNavBarTab> tabs;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final activeBg = AppColors.daisyBush800; // خلفية الدائرة النشطة
    final inactive = Color(0xff00278C);
    final iconSize = 28.w;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
        child: Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabs.length, (index) {
              final isActive = index == selectedIndex;

              Widget icon;
              if (tabs[index].icon != null) {
                icon = Icon(
                  tabs[index].icon,
                  size: iconSize,
                  color: isActive ? Colors.white : inactive,
                );
              } else if (tabs[index].img != null) {
                icon = SvgPicture.asset(
                  isActive
                      ? (tabs[index].activeImg ?? tabs[index].img!)
                      : tabs[index].img!,
                  width: iconSize,
                  height: iconSize,
                  colorFilter: ColorFilter.mode(
                      isActive ? Colors.white : inactive, BlendMode.srcIn),
                );
              } else {
                icon = Icon(Icons.circle,
                    size: iconSize, color: isActive ? Colors.white : inactive);
              }

              return Expanded(
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28.r),
                    onTap: () => onTap(index),
                    child: Center(child: icon),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
