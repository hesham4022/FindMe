import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:flutter/material.dart';

class MorePhotosCard extends StatelessWidget {
  final CaseInfoModel caseInfo;

  static const String _placeholder =
      'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png';

  MorePhotosCard({required this.caseInfo});

  String _photoAt(int index) {
    if (caseInfo.photos.length > index) {
      return caseInfo.photos[index].url ?? _placeholder;
    }
    return _placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              const Icon(Icons.photo_library_outlined,
                  size: 14, color: Color(0xFF6B7280)),
              const SizedBox(width: 5),
              const Text(
                'More Photos',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Photo grid — 3 columns
          Row(
            children: [
              Expanded(child: _PhotoTile(url: _photoAt(1))),
              const SizedBox(width: 6),
              Expanded(child: _PhotoTile(url: _photoAt(2))),
              const SizedBox(width: 6),
              Expanded(child: _PhotoTile(url: _photoAt(3))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final String url;

  const _PhotoTile({required this.url});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: const Color(0xFFF3F4F6),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFFD1D5DB),
              size: 28,
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: const Color(0xFFF3F4F6),
            child: const Icon(
              Icons.broken_image_outlined,
              color: Color(0xFFD1D5DB),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
