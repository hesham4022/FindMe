// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../resources/colors.dart';
// import '../../resources/strings.dart';
// import 'rdivider.dart';

// /// show choose photo source bottom sheet
// chooseImageSource(
//   BuildContext context,
//   Function(ImageSource) onPressed,
// ) async {
//   await showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.transparent,
//     enableDrag: false,
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.fromLTRB(10, 40, 10, 22).r,
//         child: Wrap(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12).r,
//               ),
//               child: Column(
//                 children: [
//                   //! add photo text
//                   SizedBox(
//                     height: 40.h,
//                     child: Center(
//                       child: Text(
//                         AppStrings.addPhoto.tr,
//                         style: Theme.of(context)
//                             .textTheme
//                             .regular14
//                             .copyWith(color: AppColors.secondaryText),
//                       ),
//                     ),
//                   ),

//                   const RDivider(
//                     padding: EdgeInsets.symmetric(vertical: 0),
//                   ),

//                   //! camera
//                   GestureDetector(
//                     onTap: () {
//                       context.back();
//                       onPressed(ImageSource.camera);
//                     },
//                     child: SizedBox(
//                       height: 58.h,
//                       child: Center(
//                         child: Text(
//                           AppStrings.takePhoto.tr,
//                           style: Theme.of(context)
//                               .textTheme
//                               .regular18
//                               .copyWith(color: AppColors.chooseBtn),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const RDivider(
//                     padding: EdgeInsets.symmetric(vertical: 0),
//                   ),

//                   //! gallery
//                   GestureDetector(
//                     onTap: () {
//                       context.back();
//                       onPressed(ImageSource.gallery);
//                     },
//                     child: SizedBox(
//                       height: 58.h,
//                       child: Center(
//                         child: Text(
//                           AppStrings.chooseImage.tr,
//                           style: Theme.of(context)
//                               .textTheme
//                               .regular18
//                               .copyWith(color: AppColors.chooseBtn),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             //! cancel
//             Padding(
//               padding: const EdgeInsets.only(top: 10).h,
//               child: GestureDetector(
//                 onTap: () => context.back(),
//                 child: Container(
//                   height: 58.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12).r,
//                   ),
//                   child: Center(
//                     child: Text(
//                       AppStrings.cancel.tr,
//                       style: Theme.of(context)
//                           .textTheme
//                           .regular18
//                           .copyWith(color: AppColors.chooseBtn),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
