// import 'package:flutter/material.dart';
// import 'package:find_me_app/core/resources/colors.dart';
// import 'package:find_me_app/core/resources/strings.dart';
// import 'package:find_me_app/core/resources/themes.dart';
// import 'package:find_me_app/core/shared/widgets/custom_network_img.dart';
// import 'package:find_me_app/core/shared/widgets/sizes.dart';
// import 'package:find_me_app/features/profile/data/model/info_tile_model.dart';
// import 'package:find_me_app/features/profile/presentation/widgets/profile_info_list_widget.dart';
// import 'package:find_me_app/features/requests/presentation/vacation_request/data/model/vacation_request_model.dart';
// import 'package:find_me_app/features/services/my_requests/presentation/widgets/my_requests_card.dart';

// class ApprovalCommitteeWidget extends StatelessWidget {
//   const ApprovalCommitteeWidget({
//     super.key,
//     required this.vacationRequest,
//   });

//   final VacationRequestModel vacationRequest;

//   @override
//   Widget build(BuildContext context) {
//     return InfoList(
//       title: AppStrings.approvalCommittee,
//       children: [
//         InfoTileModel(
//           title: Row(
//             children: [
//               CustomNetworkImage(
//                 image:
//                     'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80',
//                 isCircle: true,
//                 width: 44,
//                 height: 44,
//               ),
//               HSpace(8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Mohammad Ahmed",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.saltBox800),
//                   ),
//                   Text(
//                     "Project manager",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kCaptionRegular
//                         .copyWith(color: AppColors.saltBox500),
//                   )
//                 ],
//               ),
//               Spacer(),
//               // HSpace(10),
//               StatusTag(status: vacationRequest.status),
//             ],
//           ),
//         ),
//         InfoTileModel(
//           title: Row(
//             children: [
//               CustomNetworkImage(
//                 image:
//                     'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80',
//                 isCircle: true,
//                 width: 44,
//                 height: 44,
//               ),
//               HSpace(8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Mohammad Ahmed",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.saltBox800),
//                   ),
//                   Text(
//                     "Project manager",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kCaptionRegular
//                         .copyWith(color: AppColors.saltBox500),
//                   )
//                 ],
//               ),
//               Spacer(),
//               // HSpace(10),
//               StatusTag(status: vacationRequest.status),
//             ],
//           ),
//         ),
//         InfoTileModel(
//           title: Row(
//             children: [
//               CustomNetworkImage(
//                 image:
//                     'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80',
//                 isCircle: true,
//                 width: 44,
//                 height: 44,
//               ),
//               HSpace(8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Mohammad Ahmed",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kParagraph01SemiBold
//                         .copyWith(color: AppColors.saltBox800),
//                   ),
//                   Text(
//                     "Project manager",
//                     strutStyle: StrutStyle(forceStrutHeight: true),
//                     style: Theme.of(context)
//                         .textTheme
//                         .kCaptionRegular
//                         .copyWith(color: AppColors.saltBox500),
//                   )
//                 ],
//               ),
//               Spacer(),
//               // HSpace(10),
//               StatusTag(status: vacationRequest.status),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
