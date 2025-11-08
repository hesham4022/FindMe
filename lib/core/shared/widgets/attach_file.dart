import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class AttachedFilesListWidget extends StatefulWidget {
  const AttachedFilesListWidget({
    super.key,
    required this.files,
    required this.onDeleteFile,
  });

  final List<UploadFile> files;
  final Function(int index) onDeleteFile;

  @override
  State<AttachedFilesListWidget> createState() =>
      _AttachedFilesListWidgetState();
}

class _AttachedFilesListWidgetState extends State<AttachedFilesListWidget> {
  late List<UploadFile> files;

  Widget _getFileIcon(UploadFile file) {
    switch (file.ext) {
      case 'pdf':
      // return SvgPicture.asset(
      //   AppImages.pdf,
      //   width: 32.sp,
      //   height: 32.sp,
      // );
      // case 'doc' || 'docx':
      //   return SvgPicture.asset(
      //     AppImages.word,
      //     width: 32.sp,
      //     height: 32.sp,
      //   );
      // case 'xls' || 'xlsx':
      //   return SvgPicture.asset(
      //     AppImages.excel,
      //     width: 32.sp,
      //     height: 32.sp,
      //   );

      default:
        return Image.file(file.file!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.files.length,
      separatorBuilder: (_, __) => VSpace(18),
      itemBuilder: (context, index) {
        final file = widget.files[index];
        return ListTile(
          dense: true,
          horizontalTitleGap: 8.w,
          contentPadding: EdgeInsets.zero,
          leading: _getFileIcon(file),
          title: Text(
            file.name,
            style: Theme.of(context)
                .textTheme
                .kCaptionRegular
                .copyWith(color: AppColors.saltBox800),
          ),
          trailing: GestureDetector(
            onTap: () => widget.onDeleteFile(index),
            child: Container(
              padding: const EdgeInsets.all(8).r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error600,
              ),
              child: Icon(
                Icons.delete_outline_outlined,
                color: AppColors.baseWhite,
                size: 20.sp,
              ),
            ),
          ),
        );
        // return ListTile(
        //   dense: true,
        //   horizontalTitleGap: 8.w,
        //   contentPadding: EdgeInsets.zero,
        //   leading: _getFileIcon(file),
        //   title: Text(
        //     file.name,
        //     style: Theme.of(context)
        //         .textTheme
        //         .kCaptionRegular
        //         .copyWith(color: AppColors.saltBox800),
        //   ),
        //   subtitle: file.isUploading
        //       ? Row(
        //           children: [
        //             LinearProgressIndicator(
        //               value: file.progress,
        //               minHeight: 6.h,
        //               valueColor: AlwaysStoppedAnimation<Color>(
        //                 file.isCompleted
        //                     ? Color(0xff10B981)
        //                     : AppColors.daisyBush800,
        //               ),
        //               backgroundColor: Color(0xffE0E7E6),
        //             ),
        //             HSpace(12),
        //             Icon(
        //               Icons.check_circle_rounded,
        //               color: Color(0xff10B981),
        //               size: 14.sp,
        //             ),
        //             HSpace(4),
        //             Text(
        //               "${file.progress}%",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .kParagraph01SemiBold
        //                   .copyWith(color: Color(0xff323D3D)),
        //             ),
        //           ],
        //         )
        //       : null,
        //   trailing: file.isCompleted
        //       ? Container(
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: AppColors.error600,
        //           ),
        //           child: Icon(
        //             Icons.delete_outline_outlined,
        //             color: AppColors.baseWhite,
        //             size: 20.sp,
        //           ),
        //         )
        //       : null,
        // );
      },
    );
  }
}
