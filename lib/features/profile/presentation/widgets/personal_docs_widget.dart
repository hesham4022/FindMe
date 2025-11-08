import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/functions.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/core/shared/widgets/rdivider.dart';
import 'package:find_me_app/features/profile/presentation/widgets/profile_info_list_widget.dart';

class PersonalDocs extends StatelessWidget {
  const PersonalDocs({
    super.key,
    required this.title,
    required this.files,
  });

  final List<UploadFile> files;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileInfoSectionTitle(title: title),
        Container(
          color: AppColors.baseWhite,
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: files.length,
              separatorBuilder: (_, __) => RDivider(
                    thickness: 2,
                    padding: EdgeInsets.zero,
                  ),
              itemBuilder: (context, i) {
                final file = files[i];
                return ListTile(
                  contentPadding: const EdgeInsets.all(18).r,
                  horizontalTitleGap: 10.w,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  minTileHeight: 0,
                  dense: true,
                  // leading: kGetFileIcon(file.ext ?? ""),
                  title: Text(
                    file.name,
                    style: Theme.of(context)
                        .textTheme
                        .kParagraph01SemiBold
                        .copyWith(color: AppColors.saltBox800),
                  ),
                  // subtitle: Text(
                  //   file.name,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .kCaptionRegular
                  //       .copyWith(color: AppColors.saltBox500),
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // //! Download button
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: AppColors.saltBox100,
                      //     borderRadius: BorderRadius.circular(10).r,
                      //   ),
                      //   child: IconButton(
                      //     onPressed: () {
                      //       //TODO
                      //     },
                      //     icon: SvgPicture.asset(
                      //       AppImages.download,
                      //       width: 24.sp,
                      //       height: 24.sp,
                      //       colorFilter: ColorFilter.mode(
                      //         AppColors.saltBox800,
                      //         BlendMode.srcIn,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // HSpace(8),
                      //! Preview
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.saltBox100,
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.abc),
                          onPressed: () async {
                            switch (file.ext) {
                              case "pdf":
                                kPreviewPdf(
                                  context,
                                  files[i].url ?? "",
                                  files[i].token ?? "",
                                );
                                break;
                              default:
                                kPreviewImage(
                                  context,
                                  files[i].url ?? "",
                                  files[i].token ?? "",
                                );
                                break;
                            }
                          },
                          // icon: SvgPicture.asset(
                          //   AppImages.visibility,
                          //   width: 24.sp,
                          //   height: 24.sp,
                          //   colorFilter: ColorFilter.mode(
                          //     AppColors.saltBox800,
                          //     BlendMode.srcIn,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
