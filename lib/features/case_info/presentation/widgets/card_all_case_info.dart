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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          /// 🔥 IMAGE + OVERLAY
          Stack(
            alignment: Alignment.center,
            children: [
              /// الصورة
              Container(
                width: 140.w,
                height: 140.w,
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

              /// Age badge (يمين فوق)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 14),
                      SizedBox(width: 4.w),
                      Text(
                        "${caseInfo?.age} years old",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const VSpace(10),

          /// 🔹 NAME + LOCATION
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  "${caseInfo?.firstName} ${caseInfo?.lastName}",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.red),
                    SizedBox(width: 4.w),
                    Text(
                      caseInfo?.address ?? '',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const VSpace(10),

          /// 🔹 FEATURES BOX (زي الصورة)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1D4ED8),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Features:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VSpace(5),
                CustomFeature(text: "${caseInfo?.height ?? ''} cm"),
                CustomFeature(text: caseInfo?.gender ?? ''),
                CustomFeature(text: caseInfo?.description ?? ''),
              ],
            ),
          ),

          const VSpace(10),

          /// 🔹 LOST INFO
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              "Lost on: ${caseInfo?.dateLastSeen ?? ''}",
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
            ),
          ),

          const VSpace(12),

          /// 🔹 ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.white, size: 16),
                    SizedBox(width: 6.w),
                    Text(
                      "Contact",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

              /// ❤️ LIKE
              BlocBuilder<AllCasesCubit, AllCasesState>(
                builder: (context, state) {
                  final updatedCase = state.filtered.firstWhere(
                    (c) => c.id == caseInfo?.id,
                    orElse: () => caseInfo!,
                  );

                  return GestureDetector(
                    onTap: () async {
                      final prev = updatedCase.isLiked;

                      context.read<AllCasesCubit>().updateCaseLike(
                            updatedCase.id ?? -1,
                            !prev,
                          );

                      try {
                        await context
                            .read<AllCasesCubit>()
                            .toggleLike(updatedCase.id ?? -1);
                      } catch (_) {
                        context
                            .read<AllCasesCubit>()
                            .updateCaseLike(updatedCase.id ?? -1, prev);
                      }
                    },
                    child: Icon(
                      updatedCase.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.mainColor,
                    ),
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
