import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/shared/widgets/animated_transition_widget/animated_transition_widget.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/Home/presentation/widgets/chip.dart';
import 'package:find_me_app/features/Home/presentation/widgets/convert_time.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/all_cases/presentation/widgets/case_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key, required this.caseModel, required this.onTap});
  final CaseInfoModel caseModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFFCAD6FF);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.black12,
              backgroundImage: caseModel.photos.isNotEmpty
                  ? CachedNetworkImageProvider(caseModel.photos.first.url!)
                  : const AssetImage("assets/images/Portrait_Placeholder.png"),
              onBackgroundImageError: (_, __) {},
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(13),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${caseModel.firstName} ${caseModel.lastName}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            )),
                        Row(
                          children: [
                            const Icon(Icons.place,
                                size: 14, color: Colors.redAccent),
                            HSpace(4),
                            Expanded(
                              child: Text(
                                caseModel.address ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        VSpace(4),
                      ],
                    ),
                  ),
                  VSpace(5),
                  Row(
                    children: [
                      CustomeChip(
                        label: '${timeAgo(caseModel.createdAt)}',
                      ),
                      const Spacer(),
                      CustomeChip(
                        icon: Image.asset(
                          'assets/icons/comment_icon.png',
                          width: 15.w,
                          height: 15.h,
                        ),
                        label: '${caseModel.age}',
                      ),
                      HSpace(6),
                      ActionIcon(
                        icon: const Icon(
                          Icons.help_outline_rounded,
                          color: AppColors.mainColor,
                          size: 16,
                        ),
                        onTap: () {},
                      ),
                      HSpace(6),
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
                            onTap: () {
                              // context
                              // .read<AllCasesCubit>()
                              // .toggleFavoriteCard(updatedCase.id ?? -1);
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
