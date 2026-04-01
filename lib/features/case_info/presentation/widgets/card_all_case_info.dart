import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardAllCaseInfo extends StatelessWidget {
  final CaseInfoModel? caseInfo;
  const CardAllCaseInfo({super.key, this.caseInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      caseInfo!.photos.isNotEmpty
                          ? caseInfo!.photos.first.url!
                          : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const HSpace(12),
              Column(
                children: [
                  Container(
                    width: 120,
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "${caseInfo?.age} years old",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VSpace(3),
                  Container(
                    width: 120,
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D4ED8), // الأزرق
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Features:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // هنا بنحط Padding حوالين كل العناصر
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 15, right: 5),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       CustomFeature(text: caseInfo?.height.toString() ?? ''),
                        //       CustomFeature(text: caseInfo?.eyeColor ?? ''),
                        //       CustomFeature(text: caseInfo?.skinColor ?? ''),
                        //       CustomFeature(text: caseInfo?.hairColor ?? ''),
                        //       Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const Text(
                        //             "• ",
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 11,
                        //               height: 1.2,
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               " ${caseInfo?.birthMark} ",
                        //               style: const TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 11,
                        //                 height: 1.2,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const VSpace(10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 2, top: 1),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text("${caseInfo?.firstName} ${caseInfo?.lastName}" ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 16,
                    ),
                    const HSpace(4),
                    Text(caseInfo?.address ?? ''),
                  ],
                ),
              ],
            ),
          ),
          const VSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              BlocBuilder<AllCasesCubit, AllCasesState>(
                builder: (context, state) {
                  final updatedCase = state.filtered.firstWhere(
                    (c) => c.id == caseInfo?.id,
                    orElse: () => caseInfo!,
                  );

                  return ActionIcon(
                    icon: Icon(
                      updatedCase.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.mainColor,
                      size: 16,
                    ),
                    onTap: () async {
                      // Optimistic UI: قلب فورًا
                      final previousValue = updatedCase.isLiked;
                      context.read<AllCasesCubit>().updateCaseLike(
                            updatedCase.id ?? -1,
                            !previousValue,
                          );

                      try {
                        // Cubit يتعامل مع request ويرجع isLiked
                        await context.read<AllCasesCubit>().toggleLike(
                              updatedCase.id ?? -1,
                            );
                      } catch (e) {
                        print('Like toggle failed: $e');

                        // ارجع القيمة القديمة لو فشل
                        context.read<AllCasesCubit>().updateCaseLike(
                            updatedCase.id ?? -1, previousValue);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomFeature extends StatelessWidget {
  const CustomFeature({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("•  ${text}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          height: 1.2,
        ));
  }
}
