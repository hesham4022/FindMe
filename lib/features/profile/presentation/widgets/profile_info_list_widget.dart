import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/features/profile/data/model/info_tile_model.dart';

class InfoList extends StatelessWidget {
  const InfoList({
    super.key,
    required this.title,
    required this.children,
    this.separator,
    this.tileHeight = 31,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  final String title;
  final List<InfoTileModel> children;
  final Widget? separator;
  final double tileHeight;
  final EdgeInsets padding;

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
            padding: padding.r,
            separatorBuilder: (_, __) =>
                separator ??
                Container(
                  height: 8.h,
                  color: AppColors.baseWhite,
                ),
            itemCount: children.length,
            itemBuilder: (context, i) {
              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0).r,
                horizontalTitleGap: 10.w,
                // contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                minTileHeight: tileHeight.h,
                tileColor: AppColors.baseWhite,
                dense: true,
                leading: children[i].leading,
                title: children[i].title,
                subtitle: children[i].subtitle,
                trailing: children[i].trailing,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfileInfoSectionTitle extends StatelessWidget {
  const ProfileInfoSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      color: AppColors.saltBox50,
      child: Text(
        title.toLowerCase().tr().toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .kCaptionBold
            .copyWith(color: AppColors.saltBox400),
      ),
    );
  }
}
