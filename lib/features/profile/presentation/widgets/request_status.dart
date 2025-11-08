import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/enums/date.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/profile/presentation/widgets/profile_info_list_widget.dart';

import 'package:find_me_app/features/profile/data/model/info_tile_model.dart';

class RequestStatusWidget extends StatelessWidget {
  const RequestStatusWidget({
    super.key,});


  @override
  Widget build(BuildContext context) {
    return InfoList(
      title: AppStrings.status,
      children: [
        //! status
        InfoTileModel(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.status.ts,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01SemiBold
                      .copyWith(color: AppColors.saltBox500),
                ),
              ),
              HSpace(10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // StatusTag(status: vacationRequest.status),
                  ],
                ),
              ),
            ],
          ),
        ),
        //! Date
        InfoTileModel(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.date.ts,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01SemiBold
                      .copyWith(color: AppColors.saltBox500),
                ),
              ),
              HSpace(10),
              Expanded(
                child: Text(
                  "vacationRequest.issuedDate.toDMYFormat",
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01Regular
                      .copyWith(color: AppColors.saltBox800),
                ),
              ),
            ],
          ),
        ),
        //! By
        InfoTileModel(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.by.ts,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01SemiBold
                      .copyWith(color: AppColors.saltBox500),
                ),
              ),
              HSpace(10),
              Expanded(
                child: Text(
                  "vacationRequest.approvedBy",
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01Regular
                      .copyWith(color: AppColors.saltBox800),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
