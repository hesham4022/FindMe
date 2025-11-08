import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/custom_network_img.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum AlertType { normal, success, error, warning }

showAlertSnackBar(
  BuildContext context,
  String msg,
  AlertType alert,
) {
  showTopSnackBar(
    Overlay.of(context),
    animationDuration: const Duration(milliseconds: 750),
    displayDuration: const Duration(seconds: 3),
    reverseAnimationDuration: const Duration(milliseconds: 750),
    curve: Curves.fastOutSlowIn,
    reverseCurve: Curves.fastOutSlowIn,
    snackBarPosition: SnackBarPosition.bottom,
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.baseWhite,
          // color: alert == AlertType.error
          //     ? AppColors.error500
          //     : AppColors.success500,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 16,
              offset: Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              alert == AlertType.error
                  ? Icons.error_outline
                  : Icons.check_circle_rounded,
              size: 24,
              color: alert == AlertType.error
                  ? AppColors.error500
                  : AppColors.success500,
            ),
            const HSpace(10.5),
            Flexible(
              child: Text(
                msg.ts,
                style: Theme.of(context)
                    .textTheme
                    .kParagraph01Regular
                    .copyWith(color: AppColors.saltBox950),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> kShowAlertCard<T extends Cubit>({
  required BuildContext context,
  required String title,
  required Widget icon,
  String? subtitle,
  Widget? buttons,
}) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
            body: Column(
              children: [
                const Spacer(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24).r,
                    ),
                    padding: const EdgeInsets.all(24).r,
                    margin: const EdgeInsets.all(20).r,
                    child: Column(
                      children: [
                        icon,
                        const VSpace(20),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.kSubheadingSemiBold,
                        ),
                        const VSpace(8),
                        if (subtitle != null)
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.kCaptionRegular,
                          ),
                        if (buttons != null) VSpace(24),
                        if (buttons != null) buttons,
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      });
}

Future<void> kPreviewImage(BuildContext context, String imageUrl,
    [String? token]) async {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => context.back(),
          child: Scaffold(
            backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 20).r,
              child: Center(
                child: InteractiveViewer(
                  child: CustomNetworkImage(
                    image: imageUrl,
                    accessToken: token,
                    width: double.maxFinite,
                    radius: 2,
                    placeholder: Icons.account_circle_rounded,
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> kPreviewPdf(
  BuildContext context,
  String url,
  String? token,
) async {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => context.back(),
          child: Scaffold(
            backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
            body: Center(
              child: SfPdfViewer.network(
                url,
                headers:
                    token != null ? {'Authorization': 'Bearer $token'} : null,
              ),
            ),
          ),
        );
      });
}

// Future<void> showRateDialog({
//   required BuildContext context,
//   bool isLoading = false,
//   required void Function(int rating, String? comment) onSubmit,
// }) async {
//   showDialog(
//     context: context,
//     builder: (context) => RatingView(
//       onSubmit: onSubmit,
//       isLoading: isLoading,
//     ),
//   );
// }

// Future<void> showConfirmationDialog({
//   required BuildContext context,
//   required String title,
//   String buttonTitle = AppStrings.delete,
//   String? subtitle,
//   required void Function() onSubmit,
// }) async {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(
//           title,
//           style: Theme.of(context).textTheme.bold18,
//         ),
//         content: subtitle != null
//             ? Text(
//                 subtitle,
//                 style: Theme.of(context).textTheme.regular16,
//               )
//             : null,
//         actions: [
//           //! Button
//           TextButton(
//             onPressed: () {
//               // close showDeleteDialog
//               context.back();
//               onSubmit();
//             },
//             child: Text(
//               buttonTitle.ts,
//               style: Theme.of(context)
//                   .textTheme
//                   .bold18
//                   .copyWith(color: Colors.red),
//             ),
//           ),
//           //! Cancel
//           TextButton(
//             onPressed: () => context.back(),
//             child: Text(
//               AppStrings.cancel.ts,
//               style: Theme.of(context)
//                   .textTheme
//                   .bold18
//                   .copyWith(color: AppColors.almostBlack),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// //! show close dialog
// Future<void> showCloseDialog(BuildContext context,
//     [void Function()? exitPressed]) async {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text(
//         AppStrings.warning.ts,
//         style: Theme.of(context).textTheme.bold18,
//       ),
//       content: Text(
//         AppStrings.exitPageMsg.ts,
//         style: Theme.of(context).textTheme.regular16,
//       ),
//       actions: [
//         TextButton(
//           onPressed: exitPressed ??
//               () {
//                 // close showDeleteDialog
//                 context.back();
//                 // Back to previous page
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   context.back();
//                 });
//               },
//           child: Text(
//             AppStrings.exit.ts,
//             style:
//                 Theme.of(context).textTheme.bold18.copyWith(color: Colors.red),
//           ),
//         ),
//         //! Cancel
//         TextButton(
//           child: Text(
//             AppStrings.cancel.ts,
//             style: Theme.of(context)
//                 .textTheme
//                 .bold18
//                 .copyWith(color: AppColors.main),
//           ),
//           onPressed: () => context.back(),
//         ),
//       ],
//     ),
//   );
// }

class CustomErrorPageArgs {
  final String title;
  final String btnTitle;
  final String? subtitle;
  final void Function() onPressed;

  CustomErrorPageArgs({
    required this.title,
    this.btnTitle = AppStrings.tryAgain,
    required this.onPressed,
    this.subtitle,
  });
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.args,
  });

  final CustomErrorPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10).h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 75.r,
              color: AppColors.error500,
            ),
            //! Title
            Padding(
              padding: const EdgeInsets.only(top: 40).h,
              child: Text(
                args.title.ts,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            //! Subtitle
            if (args.subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 25).h,
                child: Text(
                  args.subtitle!.ts,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            //! Try Again Button
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25).h,
              child: Center(
                child: CustomFilledButton(
                  titleText: args.btnTitle,
                  onPressed: args.onPressed,
                  width: 200,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> showLocationAlertCard({
//   required BuildContext context,
// }) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return Scaffold(
//           backgroundColor: Colors.black.withAlpha(50),
//           body: Column(
//             children: [
//               const Spacer(),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20).r,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10).r,
//                     ),
//                     padding: const EdgeInsets.all(20).r,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.location_off_rounded,
//                           size: 75.r,
//                           color: AppColors.error100,
//                         ),
//                         //! Title
//                         Padding(
//                           padding: const EdgeInsets.only(top: 40).h,
//                           child: Text(
//                             "To use the app features, we need access to your location",
//                             style: Theme.of(context).textTheme.bold18,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),

//                         //! Try Again Button
//                         Padding(
//                           padding: const EdgeInsets.only(top: 25, bottom: 25).h,
//                           child: Center(
//                             child: CustomFilledButton(
//                               titleText: "Give Access",
//                               onPressed: () =>
//                                   Geolocator.openLocationSettings(),
//                               width: 200,
//                               height: 40,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//         );
//       });
// }

// Future<void> showLoadingCard({
//   required BuildContext context,
// }) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return Scaffold(
//           backgroundColor: Colors.black.withAlpha(50),
//           body: Column(
//             children: [
//               const Spacer(),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20).r,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10).r,
//                     ),
//                     padding: const EdgeInsets.all(20).r,
//                     child: const CustomProgressIndicator(),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//         );
//       });
// }
