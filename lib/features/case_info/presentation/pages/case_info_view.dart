import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/case_info/presentation/widgets/addition_info.dart';
import 'package:find_me_app/features/case_info/presentation/widgets/card_all_case_info.dart';

import 'package:flutter/material.dart';

class CaseInfoView extends StatelessWidget {
  final CaseInfoModel caseInfo;
  const CaseInfoView({super.key, required this.caseInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Case Info",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CardAllCaseInfo(caseInfo: caseInfo),
              VSpace(20),
              AdditionInfo(
                title: 'Last seen wearing:',
                text: caseInfo.lastSeenLocation,
              ),
              VSpace(20),
              AdditionInfo(
                title: 'Details of the perpetrator:',
                text: caseInfo.lastSeenLocation,
              ),
              VSpace(20),
              AdditionInfo(
                title: 'Details of what happened:',
                text: caseInfo.lastSeenLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
