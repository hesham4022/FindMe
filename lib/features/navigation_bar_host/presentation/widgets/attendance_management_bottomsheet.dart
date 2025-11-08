import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/navigation_bar_host/data/model/attendance_mange_model.dart';

// kAttendanceManagementBottomSheet(BuildContext context) async {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     isDismissible: true,
//     backgroundColor: AppColors.baseWhite,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(24),
//         topRight: Radius.circular(24),
//       ),
//     ),
//     builder: (_) => _AttendanceManagementView(),
//   );
// }

// class _AttendanceManagementView extends StatelessWidget {
//   const _AttendanceManagementView();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HostCubit, HostState>(
//         buildWhen: (previous, current) =>
//             previous.currentPosition != current.currentPosition,
//         builder: (context, state) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 //! title, Close Button
//                 Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                   height: 56.h,
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: AppColors.saltBox100,
//                         width: 2.w,
//                       ),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(width: 32.sp, height: 32.sp),
//                       Text(
//                         "AttendanceManagement".ts,
//                         style: Theme.of(context).textTheme.kParagraph02SemiBold,
//                       ),
//                       GestureDetector(
//                         onTap: () async => context.back(),
//                         child: Container(
//                           width: 32.sp,
//                           height: 32.sp,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.saltBox100,
//                           ),
//                           child: const Icon(
//                             Icons.close_sharp,
//                             size: 18,
//                             color: AppColors.saltBox600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16.r),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                     height: 336.h,
//                     child: GoogleMap(
//                       myLocationEnabled: true,
//                       zoomGesturesEnabled: true,
//                       trafficEnabled: false,
//                       scrollGesturesEnabled: true,
//                       mapType: MapType.normal,
//                       markers: {
//                         Marker(
//                           onTap: () {
//                             debugPrint('Tapped');
//                           },
//                           draggable: true,
//                           markerId: const MarkerId('Marker'),
//                           position: LatLng(state.currentPosition?.latitude ?? 0,
//                               state.currentPosition?.longitude ?? 0),
//                           onDragEnd: (newPosition) {
//                             debugPrint(newPosition.toString());
//                             context.read<HostCubit>().updateMarker(newPosition);
//                           },
//                         )
//                         // if (helperMap.currentPosition != null)
//                         //   Marker(
//                         //     markerId: const MarkerId('source'),
//                         //     position: LatLng(helperMap.currentPosition!.latitude!, helperMap.currentPosition!.longitude!) ,
//                         //   ),
//                       },
//                       // polylines: helperMap.polyLines,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(state.currentPosition?.latitude ?? 0,
//                             state.currentPosition?.longitude ?? 0),
//                         zoom: 13,
//                         bearing: 0.0,
//                         tilt: 6,
//                       ),
//                       onMapCreated: (controller) =>
//                           context.read<HostCubit>().onMapCreated(controller),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4.h,
//                 ),

//                 Row(
//                   children: [
//                     Icon(
//                       Icons.info_outline,
//                       size: 22.w,
//                       color: AppColors.saltBox600,
//                     ),
//                     SizedBox(width: 8.sp),
//                     Text(
//                       "YouAreInPermittedArea".ts,
//                       style: Theme.of(context)
//                           .textTheme
//                           .kParagraph01Regular
//                           .copyWith(color: AppColors.saltBox500),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 16.h,
//                 ),

//                 GridView.builder(
//                   // itemCount: !state.showMoreAttendMangeItem? 3 :state.kAttendMangeItems(context).length,
//                   itemCount: state.kAttendMangeItems(context).length,
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, // Number of items in a row
//                     crossAxisSpacing: 16.w,
//                     mainAxisSpacing: 16.h,
//                     childAspectRatio: 1, // Adjust for square-like items
//                   ),
//                   itemBuilder: (context, index) {
//                     return AttendMangeItemWidget(
//                         data: state.kAttendMangeItems(context)[index]);
//                   },
//                 ),
//                 SizedBox(
//                   height: 34.h,
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

//! Request Widget -------------------------------------------------------------
class AttendMangeItemWidget extends StatelessWidget {
  const AttendMangeItemWidget({
    super.key,
    required this.data,
  });

  final AttendanceMangeModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16).r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: data.color,
          color: data.needBgColor == true ? data.color : AppColors.saltBox100,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data.icon != null
                ? Icon(
                    data.icon,
                    // color: AppColors.baseWhite,
                    color: data.needBgColor
                        ? AppColors.baseWhite
                        : AppColors.saltBox600,
                    size: 24.sp,
                  )
                : SvgPicture.asset(
                    data.svgIcon!,
                    width: 24.sp,
                    height: 24.sp,
                  ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              data.title.ts,
              style: Theme.of(context).textTheme.kParagraph01Regular.copyWith(
                    // color: AppColors.saltBox500,
                    color: data.needBgColor
                        ? AppColors.baseWhite
                        : AppColors.saltBox600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
