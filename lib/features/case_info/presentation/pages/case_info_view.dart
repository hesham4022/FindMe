import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/resources/colors.dart';
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
      appBar: const CustomAppBar(
        titleText: "Case Info",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CardAllCaseInfo(caseInfo: caseInfo),
              const VSpace(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("More Photos"),
                      VSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            height: 70,
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: caseInfo.photos.length > 1
                                  ? (caseInfo.photos[1].url ??
                                      "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")
                                  : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 70,
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: caseInfo.photos.length > 2
                                  ? (caseInfo.photos[1].url ??
                                      "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")
                                  : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 70,
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: caseInfo.photos.length > 3
                                  ? (caseInfo.photos[3].url ??
                                      "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")
                                  : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      VSpace(10),
                    ],
                  ),
                ),
              ),
              AdditionInfo(
                title: 'Last seen wearing:',
                text: caseInfo.lastSeenLocation,
              ),
              const VSpace(20),
              AdditionInfo(
                title: 'Details of the perpetrator:',
                text: caseInfo.lastSeenLocation,
              ),
              const VSpace(20),
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

//// by using api

// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
// import 'package:find_me_app/core/shared/widgets/sizes.dart';
// import 'package:find_me_app/features/case_info/presentation/cubits/cubit/case_info_cubit.dart';
// import 'package:find_me_app/features/case_info/presentation/widgets/addition_info.dart';
// import 'package:find_me_app/features/case_info/presentation/widgets/card_all_case_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CaseInfoView extends StatelessWidget {
//   final String caseId;
//   const CaseInfoView({super.key, required this.caseId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CaseInfoCubit(sl()),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: const CustomAppBar(titleText: "Case Info"),
//         body: CaseInfoViewBody(caseId: caseId),
//       ),
//     );
//   }
// }

// class CaseInfoViewBody extends StatefulWidget {
//   final String caseId;
//   const CaseInfoViewBody({super.key, required this.caseId});

//   @override
//   State<CaseInfoViewBody> createState() => _CaseInfoViewBodyState();
// }

// class _CaseInfoViewBodyState extends State<CaseInfoViewBody> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<CaseInfoCubit>().getCaseById(widget.caseId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CaseInfoCubit, CaseInfoState>(
//       builder: (context, state) {
//         if (state.status == CaseInfoStatus.laoding) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state.status == CaseInfoStatus.error) {
//           return const Center(child: Text("try again"));
//         }

//         final caseInfo = state.selectedCase;
//         if (caseInfo == null) {
//           return const Center(child: Text("no data"));
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               CardAllCaseInfo(caseInfo: caseInfo),
//               const VSpace(20),
//               AdditionInfo(
//                 title: 'Last seen wearing:',
//                 text: caseInfo.lastSeenLocation ?? '',
//               ),
//               const VSpace(20),
//               AdditionInfo(
//                 title: 'Details of the perpetrator:',
//                 text: caseInfo.lastSeenLocation ?? '',
//               ),
//               const VSpace(20),
//               AdditionInfo(
//                 title: 'Details of what happened:',
//                 text: caseInfo.lastSeenLocation ?? '',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
