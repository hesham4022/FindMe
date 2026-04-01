import 'dart:io';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/add_case/presentation/cubits/cubit/add_case_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderOfChildInfo extends StatelessWidget {
  const HeaderOfChildInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddCaseCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            "Child Info:",
            style: Theme.of(context).textTheme.kHeadingH5SmallSemiBold.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // النص
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "Most recent\nphotos of the\nchild",
                style: Theme.of(context)
                    .textTheme
                    .kHeadingH5SmallSemiBold
                    .copyWith(
                      fontSize: 16,
                      color: const Color(0xff4B5563),
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),

            const HSpace(20),

            // ✅ الصور
            Expanded(
              child: BlocBuilder<AddCaseCubit, AddCaseState>(
                builder: (context, state) {
                  final photos = state.photos;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // عرض الصور الحالية
                      for (final photo in photos)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: photo.startsWith('http')
                                  ? Image.network(
                                      photo,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(photo),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            // ❌ زر الحذف
                            Positioned(
                              top: -6,
                              right: -6,
                              child: GestureDetector(
                                onTap: () =>
                                    cubit.removePhoto(photo), // من الكيوبت
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      // ✅ زر الإضافة (يظهر فقط لو أقل من 4 صور)
                      if (photos.length < 4)
                        GestureDetector(
                          onTap: () => cubit.pickPhoto(),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_a_photo_outlined,
                                    color: Colors.black54),
                                const SizedBox(height: 4),
                                Text(
                                  "Upload",
                                  style: Theme.of(context)
                                      .textTheme
                                      .kHeadingH5SmallSemiBold
                                      .copyWith(
                                        fontSize: 12,
                                        color: const Color(0xff4B5563),
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
