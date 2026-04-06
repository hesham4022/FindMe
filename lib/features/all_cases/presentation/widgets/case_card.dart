import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/add_case/data/repo/delete_case_repo.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
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
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 IMAGE SECTION
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180.h,
                    child: caseModel.photos.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: caseModel.photos.first.url!,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                        : Image.asset(
                            "assets/images/Portrait_Placeholder.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                /// Gradient overlay
                Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                /// الاسم فوق الصورة
                Positioned(
                  left: 12.w,
                  bottom: 12.h,
                  child: Text(
                    "${caseModel.firstName} ${caseModel.lastName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// زر options
                if (caseModel.userId.toString() == sl<AuthLocal>().getUserId())
                  Positioned(
                    right: 8.w,
                    top: 8.h,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
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
                                    context.toNamed(
                                      AppRoutes.addCaseView,
                                      arguments: {
                                        'case': caseModel,
                                        'cubit': context.read<AllCasesCubit>(),
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete,
                                      color: Colors.red),
                                  title: const Text('Delete',
                                      style: TextStyle(color: Colors.red)),
                                  onTap: () async {
                                    Navigator.pop(context);

                                    await context
                                        .read<AllCasesCubit>()
                                        .deleteCaseOptimistic(
                                          context: context,
                                          caseModel: caseModel,
                                        );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),

            /// 🔹 CONTENT
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// location
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14.w, color: Colors.red),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          caseModel.address ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  /// actions
                  Row(
                    children: [
                      /// Info button
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20.r),
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

                      const Spacer(),

                      /// icons
                      ActionIcon(
                        icon: SvgPicture.asset(
                          'assets/icons/comment_icon.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),

                      SizedBox(width: 6.w),

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
                              color: Colors.red,
                              size: 18,
                            ),
                            onTap: () async {
                              final previous = updatedCase.isLiked;

                              context.read<AllCasesCubit>().updateCaseLike(
                                    updatedCase.id ?? -1,
                                    !previous,
                                  );

                              try {
                                await context
                                    .read<AllCasesCubit>()
                                    .toggleLike(updatedCase.id ?? -1);
                              } catch (_) {
                                context.read<AllCasesCubit>().updateCaseLike(
                                    updatedCase.id ?? -1, previous);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
