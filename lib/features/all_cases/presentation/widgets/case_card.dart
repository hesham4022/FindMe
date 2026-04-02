import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/precentage_shape.dart';
import 'package:find_me_app/features/auth/data/model/authed_user.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key, required this.caseModel, required this.onTap});
  final CaseInfoModel caseModel;

  final VoidCallback onTap;
  get http => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.w),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6FA),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 90.w,
              height: 90.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: caseModel.photos.isNotEmpty
                      ? CachedNetworkImageProvider(caseModel.photos.first.url!)
                      : const AssetImage(
                          "assets/images/Portrait_Placeholder.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "${caseModel.firstName} ${caseModel.lastName}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                if (caseModel.userId.toString() ==
                                    sl<AuthLocal>().getUserId())
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: const Text('Edit'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                // كود الـ edit
                                                context.toNamed(
                                                    AppRoutes.addCaseView,
                                                    arguments: {
                                                      'case': caseModel,
                                                      'cubit': context.read<
                                                          AllCasesCubit>(),
                                                    });
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              title: const Text('Delete',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              onTap: () {
                                                Navigator.pop(context);
                                                // كود الـ delete
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.more_vert),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 14.w, color: Colors.red),
                                SizedBox(width: 4.w),
                                Text(
                                  caseModel.address ?? '',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (caseModel.similarityScore != null)
                        BalanceIndicator(
                          similarityScore: caseModel.similarityScore!,
                          desText: null,
                          radius: 30,
                          available: "",
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Action Buttons
                  Row(
                    children: [
                      // Info Button
                      GestureDetector(
                        onTap: () {
                          context.toNamed(
                            AppRoutes.caseInfoRoute,
                            arguments: {
                              'case': caseModel,
                              'cubit': context.read<AllCasesCubit>(),
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            "Info",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Action Icons
                      ActionIcon(
                        icon: SvgPicture.asset(
                          'assets/icons/comment_icon.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                      SizedBox(width: 2.w),

                      const ActionIcon(
                          icon: const Icon(
                        Icons.info_outline,
                        color: AppColors.mainColor,
                        size: 16,
                      )),
                      SizedBox(width: 2.w),

                      const ActionIcon(
                          icon: const Icon(
                        Icons.help_outline,
                        color: AppColors.mainColor,
                        size: 16,
                      )),
                      SizedBox(width: 2.w),

                      // Favorite Button connected to Cubit
                      // BlocBuilder<AllCasesCubit, AllCasesState>(
                      //   builder: (context, state) {
                      //     final updatedCase = state.filtered.firstWhere(
                      //       (c) => c.id == caseModel.id,
                      //       orElse: () => caseModel,
                      //     );
                      //     return ActionIcon(
                      //       icon: Icon(
                      //         updatedCase.isFavorite
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: AppColors.mainColor,
                      //         size: 16,
                      //       ),
                      //       onTap: () {
                      //         context
                      //             .read<AllCasesCubit>()
                      //             .toggleFavoriteCard(updatedCase.id ?? -1);
                      //       },
                      //     );
                      //   },
                      // ),

                      BlocBuilder<AllCasesCubit, AllCasesState>(
                        builder: (context, state) {
                          final updatedCase = state.filtered.firstWhere(
                            (c) => c.id == caseModel.id,
                            orElse: () => caseModel,
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
                  SizedBox(height: 16.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  const ActionIcon({super.key, required this.icon, this.onTap});
  final Widget icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
